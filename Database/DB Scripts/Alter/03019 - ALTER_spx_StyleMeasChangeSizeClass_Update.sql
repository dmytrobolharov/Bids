-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasChangeSizeClass_Update') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasChangeSizeClass_Update
GO


CREATE PROCEDURE spx_StyleMeasChangeSizeClass_Update
(
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,
	@SampleSizeID uniqueidentifier,
	@ProductTypeID uniqueidentifier,	
	@PrimaryKeysOnly int,		
	@KeepExistingPOM int,
	@Keepsamplesizemeas int,
	@OverrideDesc int,
	@OverrideRules int,
	@RemoveRules int,
	@CUser nvarchar(200),
	@CDate datetime 
)
AS

DECLARE @OldSizeClassID uniqueidentifier 
DECLARE @OldSizeRangeID uniqueidentifier 
DECLARE @OldProductTypeID uniqueidentifier 
DECLARE @OldSampleSizeID uniqueidentifier 
declare @SizeRange uniqueidentifier
declare @OldSizeRange uniqueidentifier
declare @SampleCol int
declare @MaxSizeCol int
declare @TotalCount int
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt  int
Declare @SizeCol  int
Declare @GRSampleSizeCol  nvarchar(10)
DECLARE @query NVARCHAR(4000)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
declare @SizeColcnt  int
declare @MaxPOMRow  int
declare @MaxoldPOMRow int
declare @oldRowCounter int
declare @MaxOldSizecnt int
declare @MaxNewSizecnt int
declare @oldSampleCol int
declare @cntZero  nvarchar(2)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)

SELECT @MaxOldSizecnt = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

select @MaxNewSizecnt = count(SizeCount) from pGRSizeRangeDetail WITH (NOLOCK) where ClassRangeId = @SizeRangeID 

SELECT  @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @OldProductTypeID = ProductTypeID 
,@OldSizeRangeID = SizeRangeID  , @OldSizeClassID = SizeClassID FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Select @SampleCol = SizeCount from pGRSizeRangeDetail WITH (NOLOCK) where ClassRangeId = @SizeRangeID and SizeRangeDetailId=@SampleSizeID

Select @oldSampleCol = sizecol from pamlmeaslbl WITH (NOLOCK) where issample=1 and amlmeashdrid=@AMLMeasHdrId

set @SampleCol = @SampleCol-1

Select @OldSampleSizeID = SizeRangeDetailId from pGRSizeRangeDetail WITH (NOLOCK) where ClassRangeId = @OldSizeRangeID and Sizecount=@oldSampleCol+1

SELECT @MaxPOMRow = COALESCE(max(POM_Row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

--Select @oldSampleCol as oldSampleCol
--Select @SampleCol as SampleCol
--Select @SampleSizeID as SampleSizeID
--SELECT @MaxPOMRow as MaxPOMRow

set @SizeCnt = 1
set @IncrCols = ''
set @SizeCol = 0
set @SizeColcnt = 0
set @cntZero='0'
set @IncrNullCols = '' 
set @IncrCol = ''

if @MaxPOMRow>0 

	begin
--Get only Incr cols for Sizecols present
	if @MaxNewSizecnt>0
		begin
			WHILE @SizeCnt <= @MaxNewSizecnt
				BEGIN
					set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
					set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
					set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '''' + @cntZero + ''') AS ' + @IncrCol + ','
					SET @SizeCnt = @SizeCnt + 1
				END

		if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
		if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
		--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols	
	end

	--hold sample data  for old sample
	CREATE TABLE #tempsampleData (
		 POMCompanyId nvarchar(50)
		 ,POMGuidId nvarchar(50)
		 ,POMAlternatesId nvarchar(50)	
		 ,AMLMeasPomId nvarchar(50)
		 ,AMLMeasIGCId nvarchar(50)		 
		 ,Refcode nvarchar(10)				 			 		
		 ,Sizecol nvarchar(10)	
		 ,POM_Row int
		 ,WSRowid int
		 ,Incr nvarchar(20)				
	)

	if @Keepsamplesizemeas=1
		begin
			INSERT INTO #tempsampleData(POMCompanyId, POMGuidId, POMAlternatesId, Refcode,  
			AMLMeasPomId, AMLMeasIGCId, POM_Row, WSRowid, SizeCol, Incr )
			(select p.GRPOMCompanyId, p.POMGuidId, p.POMAlternatesId, p.Refcode, 										
			p.AMLMeasPomId, i.AMLMeasIGCId, p.POM_Row, p.WSRowid, Sizecol , Grade										
			from pamlMeaspom p, pamlMeasigc i where p.pom_row=i.pom_row and
			p.AMLMeasPomId=i.AMLMeasPomId and p.amlmeashdrid=i.amlmeashdrid
			and p.POM_Row <= @MaxPOMRow and i.sizecol=@oldSampleCol and p.amlmeashdrid=@AMLMeasHdrId ) 
			
			--select * FROM #tempsampleData order by pom_row , sizecol
		end

	if @MaxOldSizecnt > @MaxNewSizecnt
		begin
			delete from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId and sizecol>=@MaxNewSizecnt		
		end
	else
		begin
		
			INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
			MUser, MDate)
			select p.AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid, t.sizecount -1 as sizecol  , 0 as incr ,
			@CUser, @CDate, @CUser, @CDate from pamlmeaspom p, pAMLMeasLbl l, pgrsizerangedetail t		
			where p.amlmeashdrid=@AMLMeasHdrId and p.amlmeashdrid=l.amlmeashdrid 
			and t.ClassRangeId = @SizeRangeID and t.sizecount > @MaxOldSizecnt and t.sizecount <= @MaxNewSizecnt and 
			l.sizecol not in (select sizecount from pgrsizerangedetail where ClassRangeId = @SizeRangeID ) 						
								
		end

	if @RemoveRules=1
		begin
			update pamlmeasigc set Incr = convert(decimal(18,4),0) from pamlmeasigc i inner join pamlmeaspom m on
			i.amlmeashdrid = m.amlmeashdrid and i.AMLMeasPomId=m.AMLMeasPomId and i.pom_row=m.pom_row								
			where i.amlmeashdrid=@AMLMeasHdrId and i.pom_row <= @MaxPOMRow and m.GRPOMCompanyId is null		
		end
		
	if @Keepsamplesizemeas=1
		begin
			if @oldSampleCol<>@SampleCol
				begin																				
					--select * FROM #tempsampleData order by pom_row , sizecol
					update pamlmeasigc set Incr = convert(decimal(18,4),t.Incr)								
					from pamlmeasigc i inner join #tempsampleData t on 
					i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row										 
					where i.amlmeashdrid=@AMLMeasHdrId 
					and i.sizecol=@samplecol and i.pom_row <= @MaxPOMRow

					update pamlmeasigc set Incr = convert(decimal(18,4),0)								
					from pamlmeasigc i inner join #tempsampleData t on 
					i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row										 
					where i.amlmeashdrid=@AMLMeasHdrId and  i.sizecol=@oldsamplecol and i.pom_row <= @MaxPOMRow																	
				end
				--select * FROM pamlmeasigc order by pom_row , sizecol
		end	

	If @KeepExistingPOM = 0
		begin        
			CREATE TABLE #tempIGCData (
				 POMCompanyId nvarchar(50)
				 ,POMGuidId nvarchar(50)
				 ,POMAlternatesId nvarchar(50)	
				 ,Alternatescode nvarchar(10)
				 ,AlternatesDesc nvarchar(100)
				 ,PomDesc nvarchar(200)
				 ,Refcode nvarchar(10)		
				 ,POM_Row int		 		
				 ,Sizecol nvarchar(10)		 
				 ,Incr nvarchar(20)				
			)

			SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Alternatescode, AlternatesDesc, PomDesc, Refcode , POM_Row, tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
			(SELECT v.POMCompanyId,  v. pomguidid, v.pomalternatesid, v.Alternatescode, v.AlternatesDesc, v.PomDesc, v.Refcode , t.Pom_Row, ' + @IncrNullCols + '			 
			FROM vwx_stylemeaspomdt_select v, pamlmeaspom t  where 
			(v.CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (v.SizeClassCompanyId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
			(v.ProductCompanyID = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (v.ClassrangeId = ''' + cast(@SizeRangeId as nvarchar(50)) + ''') AND 
			(v.POMCompanyId=t.GRPOMCompanyId) and (v.Refcode=t.Refcode) AND (t.AMLMeasHdrId = ''' + cast(@AMLMeasHdrId as nvarchar(50)) + ''') AND
			(t.POM_Row <= ''' + cast(@MaxPOMRow as nvarchar(5)) + ''')) vwx_stylemeaspomdt_select		
			UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'

			--select @query as igcqry

			INSERT #tempIGCData EXEC (@query) 

			--select  * FROM #tempIGCData order by POM_Row, sizecol

			SELECT @RowCounter = COUNT(*) FROM #tempIGCData
			
			--SELECT @RowCounter as rowcnt
			
			--hold existing data in the meas buubble
			CREATE TABLE #tempIGCOldData (
				 POMCompanyId nvarchar(50)
				 ,POMGuidId nvarchar(50)
				 ,POMAlternatesId nvarchar(50)	
				 ,AMLMeasPomId nvarchar(50)			 
				 ,Refcode nvarchar(10)	
				 ,PomDesc nvarchar(200)				 		
				 ,Sizecol nvarchar(10)	
				 ,POM_Row int
				 ,WSRowid int
				 ,Incr nvarchar(20)				
			)
			
			if @RowCounter>0	
				begin				
					--set @GRSampleSizeCol = (select top 1 SizeCol from #tempIGCData where Incr = 'B')			
					--set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
					Select @SizeCol = SizeCount from pGRSizeRangeDetail where ClassRangeId = @SizeRangeID and [Sample]=1
					set @SizeColcnt = @SizeCol
					set @SizeCol =	@SizeCol-1	  
	              				
					--select @SizeCol, @samplecol	
					--select count(*) as igccount3 from pamlmeasigc 

					INSERT INTO #tempIGCOldData(POMCompanyId, POMGuidId, POMAlternatesId, Refcode, PomDesc, 
					AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr )
					(select t.POMCompanyId, t.POMGuidId, t.POMAlternatesId, t.Refcode, 
					PomDesc = PomDesc + case AlternatesDesc when '' then '' when 'none' then '' else '--' + AlternatesDesc end ,
					p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,
					Incr =  case @IsNegative when 1 
					then
						(cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 						
							(case COALESCE(Incr,'0')
								when '' then  convert(decimal(18,4),-0)
								when 'B' then convert(decimal(18,4),0)							
								else
									(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
							 end)
						else
							dbo.fnx_Frac2Num(Incr)
						end) as decimal(18,4)))
					else
						cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))
					end			
					--cast((case Incr when 'B' then convert(decimal(18,4),0) else ( (case Incr when '' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,								
					from pamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMCompanyId and p.pomguidid=t.pomguidid
					and p.pomalternatesid=t.pomalternatesid and p.pom_row=t.pom_row and p.refcode=t.refcode and p.POM_Row <= @MaxPOMRow and p.amlmeashdrid=@AMLMeasHdrId ) 
									
					SELECT @oldRowCounter = COUNT(*) FROM #tempIGCOldData

					--select * FROM #tempIGCOldData order by pom_row , sizecol
					--SELECT @oldRowCounter as oldRowCounter
	 
					if @oldRowCounter>0
						begin
							if @OverrideDesc=1 
								begin
									update pamlmeaspom set Description = t.PomDesc						
									from pamlmeaspom p inner join #tempIGCOldData t on p.GRPOMCompanyId=t.POMCompanyId 
									and p.refcode=t.refcode	and p.pom_row=t.pom_row where  p.amlmeashdrid=@AMLMeasHdrId  and p.pom_row <= @MaxPOMRow											
								end						

							if @Keepsamplesizemeas=0
								begin
									update pamlmeasigc set Incr = convert(decimal(18,4),0) from pamlmeasigc i inner join #tempIGCOldData t on 
									i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row inner join 
									pamlmeaspom p on p.GRPOMCompanyId=t.POMCompanyId and p.refcode=t.refcode
									and p.AMLMeasPomId=t.AMLMeasPomId and p.pom_row=t.pom_row 
									where i.amlmeashdrid=@AMLMeasHdrId								 
									and i.sizecol=@samplecol and i.pom_row <= @MaxPOMRow
								end													

							if @OverrideRules=1
								begin
									update pamlmeasigc set Incr =  convert(decimal(18,4),t.Incr)								
									from pamlmeasigc i inner join #tempIGCOldData t on 
									i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pom_row inner join 
									pamlmeaspom p on p.GRPOMCompanyId=t.POMCompanyId and p.refcode=t.refcode
									and p.AMLMeasPomId=t.AMLMeasPomId and p.pom_row=t.pom_row 
									where i.amlmeashdrid=@AMLMeasHdrId 
									and i.sizecol<>@samplecol and i.pom_row <= @MaxPOMRow
								end	

								--select * FROM pamlmeasigc order by pom_row , sizecol
						end

					drop table #tempIGCData	
					drop table #tempIGCOldData
					drop table #tempsampleData									
		
			end		
		end	 
	end
	
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tempsampleData') AND type in (N'U'))
DROP TABLE #tempsampleData

delete from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId

insert into pamlmeaslbl(AMLMeasHdrId, SizeRangeID, SizeRangeDetailID, SizeCol, Measlbl, 
isvisible, issample, measdesc, CUser, CDate, Muser, MDate)
(Select  @AMLMeasHdrId, SizeRangeID, SizeRangeDetailID, SizeCount-1, SizeName, 1, 
issample = case when (cast(SizeCount as int) - 1 = @SampleCol) then 1 else 0 end,
sizedesc, @Cuser , @CDate, @Cuser, @CDate from pGRSizeRangeDetail where
ClassRangeId = @SizeRangeID)    
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03019', GetDate())
GO

SET NOCOUNT Off
GO
