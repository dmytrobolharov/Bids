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

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasLibrary_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasLibrary_INSERT
GO


CREATE PROCEDURE spx_StyleMeasLibrary_INSERT
(
	@POMLibraryID uniqueidentifier,
	@AMLMeasHdrId uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime
)
AS

DECLARE @MaxPomRow int 
DECLARE @MaxWSRowid	int 
DECLARE @MaxSizeCol int
DECLARE @SizeColcnt int
DECLARE @AMLMeasPomId uniqueidentifier 
DECLARE @CompanyId nvarchar(50) 
DECLARE @SizeClassId nvarchar(50)
DECLARE @SizeRangeId nvarchar(50)
DECLARE @GarmentID nvarchar(50)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
Declare @Refcode nvarchar(10)
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt  int
Declare @SizeCol  int
Declare @samplecol  int
Declare @GRSampleSizeCol nvarchar(10)
DECLARE @query NVARCHAR(4000)
declare @cntZero nvarchar(2)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)
Declare @SizeRange uniqueidentifier

SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxWSRowId = COALESCE(max(WSRowid),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @CompanyId = CompanyId, @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId, 
@GarmentID = ProductTypeId, @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric 
FROM pamlmeasHdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @samplecol = sizecol from pamlmeaslbl WITH (NOLOCK) where AMLMeasHdrId = @AMLMeasHdrId and IsSample=1

Set @MaxPomRow=@MaxPomRow+1

Set @MaxWSRowid = @MaxWSRowid+1

INSERT INTO pamlmeaspom(AMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, Refcode, Description, TolPlus, TolMinus, 
Flag4QA, SortId, ImageId, How2MeasText, WSRowid, CUser, CDate, 	MUser, MDate)
SELECT @AMLMeasHdrId, @POMLibraryID, POMGuidId, POMAlternatesId, @MaxPomRow, Refcode, 
(PomDesc + case AlternatesDesc when '' then '' when 'none' then '' else '--' + AlternatesDesc end) as PomDesc , 
TolPlus, 
(case left(TolMinus,1) when '-' then TolMinus else convert(decimal(18,4),('-' + cast(TolMinus as nvarchar(20)))) end)  as TolMinus ,
IsOnQA, SortField,
ImageId, How2MeasText, @MaxWSRowid,  @CUser, @CDate , 
		@CUser, @CDate FROM  vwx_StyleMeasPOMDT_Select WITH (NOLOCK)
		WHERE (POMCompanyId = @POMLibraryID) and (CompanyGuidID = @CompanyId)
		and (SizeClassCompanyId = @SizeClassId) and (ClassRangeId = @SizeRangeId)
		and (ProductCompanyId = @GarmentID)

select @AMLMeasPomId = AMLMeasPomId from pamlmeaspom where AMLMeasHdrId= @AMLMeasHdrId and POM_Row=@MaxPomRow and WSRowid=@MaxWSRowid 
and GRPOMCompanyId = @POMLibraryID 

--select @AMLMeasPomId
--select * from pamlmeaspom order by pom_row

set @SizeCnt = 1
set @IncrCols = ''
set @SizeCol= 0
set @SizeColcnt=0
set @cntZero='0'
set @IncrNullCols = '' 
set @IncrCol = ''

if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
				set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
				set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '''' + @cntZero + ''') AS ' + @IncrCol + ','
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
		if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
		--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols
		
		CREATE TABLE #tempLibIGCData (
			 POMCompanyId uniqueidentifier
			 ,POMGuidId UNIQUEIDENTIFIER
			 ,POMAlternatesId UNIQUEIDENTIFIER	
			 ,Refcode nvarchar(10)			
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)				
		)

		SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Refcode , tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
		(SELECT POMCompanyId,   pomguidid, pomalternatesid, Refcode , ' + @IncrNullCols + '			 
		FROM vwx_stylemeaspomdt_select  where 
		(POMCompanyId = ''' + cast(@POMLibraryID	as nvarchar(50)) + ''') AND 
		(CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (SizeClassCompanyId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
		(ProductCompanyId = ''' + cast(@GarmentID as nvarchar(50))+ ''') AND 
		(ClassRangeId = ''' + cast(@SizeRangeId as nvarchar(50)) + ''')
		) vwx_stylemeaspomdt_select
		UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'

		INSERT  #tempLibIGCData EXEC (@query) 
		
		--select @query
		--select * from #tempLibIGCData
		
        SELECT @RowCounter = COUNT(*) FROM #tempLibIGCData     

		if @RowCounter>0	
			begin
				--set @GRSampleSizeCol = (select top 1 SizeCol from #tempLibIGCData where Incr = 'B')			
				--set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
				Select @SizeCol = SizeCount from pGRSizeRangeDetail where ClassRangeId = @SizeRangeID and [Sample]=1				
				set @SizeColcnt = @SizeCol
				set @SizeCol =	@SizeCol-1	
		
				--select @SizeCol, @samplecol

				if @IsNegative = 1
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxWSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,
						Incr =  
							cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 						
								(case COALESCE(Incr,'0')
									when '' then  convert(decimal(18,4),0)
									when 'B' then convert(decimal(18,4),0)							
									else
										(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
								 end)
							else
								dbo.fnx_Frac2Num(Incr)
							end) as decimal(18,4)),	
						--(cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 
						--cast((case Incr when 'B' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, #tempLibIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.refcode=t.refcode and p.amlmeashdrid=@AMLMeasHdrId 
						and p.GRPOMCompanyId = @POMLibraryID and p.POM_Row=@MaxPomRow and p.WSRowid=@MaxWSRowid )				
					end
				else
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxWSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,						
						cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, #tempLibIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.refcode=t.refcode and p.amlmeashdrid=@AMLMeasHdrId
						and p.GRPOMCompanyId = @POMLibraryID and p.POM_Row=@MaxPomRow and p.WSRowid=@MaxWSRowid )				
					end	
			end

        --select * from #tempLibIGCData
		--select * from pamlmeasigc order by pom_row, sizecol
        drop table #tempLibIGCData
        
        Update pamlmeashdr set MeasRowCnt=@MaxPomRow where AMLMeasHdrId = @AMLMeasHdrId
        
		if @SizeCol<>@samplecol
			begin		
				EXEC spx_StyleMeasLibraryIGC_Insert
				@AMLMeasHdrId,
				@AMLMeasPomId,
				@MaxPomRow,	
				@samplecol,	
				@SizeCol,
				@IsNegative		
			end

		

		if @IsRelative=1 
			begin
				EXEC spx_StyleMeasPOMIMRelative_UPDATE	
				@AMLMeasHdrId,
				@AMLMeasPomId, 
				@MaxPomRow	
			end
		else
			begin
				EXEC spx_StyleMeasPOMIMIncrement_UPDATE	
				@AMLMeasHdrId,
				@AMLMeasPomId,
				@MaxPomRow
			end

	end

return @samplecol
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03011', GetDate())
GO

SET NOCOUNT Off
GO
