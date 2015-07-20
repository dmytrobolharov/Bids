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

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasPom_Insert') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasPom_Insert
GO


CREATE PROCEDURE spx_StyleMeasPom_Insert
(
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,	
	@ProductTypeID uniqueidentifier,
	@PrimaryKeysOnly int,	
	@samplecol int,
	@CUser nvarchar(200),
	@CDate datetime 
)
AS

DECLARE @AMLMeasPomId uniqueidentifier 
Declare @Refcode nvarchar(10)
declare @Maxcount int
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
declare @cntZero  nvarchar(2)
Declare @IncrNullCols nvarchar(2000)
Declare  @IncrCol nvarchar(10)
Declare @SizeRange uniqueidentifier

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @SizeRange = pGRSizeRange.SizeRangeGuidId
FROM pGRSizeRange INNER JOIN pGRClassRange ON pGRSizeRange.SizeRangeGuidId = pGRClassRange.SizeRangeGuidId 
WHERE  (pGRClassRange.ClassRangeId = @SizeRangeID)

--drop table #tempIGCData
--drop table #temp_measpoms

/*Create temp table.	*/
/************************/

CREATE TABLE #temp_measpoms
	(
	TableRow int NOT NULL IDENTITY (1, 1)	
	,POMCompanyId UNIQUEIDENTIFIER
	,POMGuidId UNIQUEIDENTIFIER
	,POMAlternatesId UNIQUEIDENTIFIER	
	,Refcode nvarchar(10)
	,Alternatescode nvarchar(10)
	,AlternatesDesc nvarchar(100)
	,PomDesc nvarchar(200)
	,How2MeasText nvarchar(500)
	,SortField int
	,GTSortField int
	,ImageId nvarchar(50)
	,TolPlus decimal(18,4)
	,TolMinus decimal(18,4)
	,IsOnQA int
	)  



if @PrimaryKeysOnly=1
	begin
		select @Maxcount= count(pomcompanyid) from vwx_StyleMeasPOMDT_select  WHERE   
		 (CompanyGuidID = @CompanyID) AND (SizeClassCompanyId = @SizeClassID) AND 
		 (ClassRangeId = @SizeRangeID) AND (ProductCompanyId = @ProductTypeID) AND (IsPrimaryKeyMeas=1)
	end
else
	begin
		select @Maxcount= count(pomcompanyid) from vwx_StyleMeasPOMDT_select  WHERE   
		 (CompanyGuidID = @CompanyID) AND (SizeClassCompanyId = @SizeClassID) AND 
		 (ClassRangeId = @SizeRangeID) AND (ProductCompanyId = @ProductTypeID)
	end

if @Maxcount>0
	begin
		if @PrimaryKeysOnly=1
			begin
				insert into #temp_measpoms(POMCompanyId, POMGuidId, POMAlternatesId, Refcode,
				Alternatescode, AlternatesDesc, PomDesc, How2MeasText, SortField, GTSortField, ImageId, IsOnQA, 
				TolPlus, TolMinus) 
				select POMCompanyId,POMGuidId,POMAlternatesId, Refcode, Alternatescode, AlternatesDesc, PomDesc,
				How2MeasText,SortField, GTSortField, ImageId, IsOnQA , 
				Tolplus, TolMinus
				from vwx_StyleMeasPOMDT_select  WHERE   
				(CompanyGuidID = @CompanyID) AND (SizeClassCompanyId = @SizeClassID) AND 
				(ClassRangeId = @SizeRangeID) AND (ProductCompanyId = @ProductTypeID) AND (IsPrimaryKeyMeas=1)	
			end
		else
			begin
				insert into #temp_measpoms(POMCompanyId, POMGuidId, POMAlternatesId, Refcode,
				Alternatescode, AlternatesDesc, PomDesc, How2MeasText, SortField, GTSortField, ImageId,IsOnQA, 
				TolPlus, TolMinus) 
				select POMCompanyId,POMGuidId,POMAlternatesId, Refcode, Alternatescode, AlternatesDesc, PomDesc,
				How2MeasText,SortField, GTSortField, ImageId, IsOnQA ,
				Tolplus, TolMinus
				from vwx_StyleMeasPOMDT_select  WHERE   
				(CompanyGuidID = @CompanyID) AND (SizeClassCompanyId = @SizeClassID) AND 
				(ClassRangeId = @SizeRangeID) AND (ProductCompanyId = @ProductTypeID)
			end
	end

SELECT @TotalCount = COUNT(*) FROM #temp_measpoms

--SELECT @TotalCount as tempcnt
--select * from #temp_measpoms


if @TotalCount>0 	
	begin
		INSERT INTO pamlmeaspom(AMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, Refcode, Description, 
		 Tolplus , TolMinus, WSRowid, How2MeasText, ImageId, Flag4QA, SortId, CUser, CDate, MUser, MDate)
		SELECT @AMLMeasHdrId , POMCompanyId , POMGuidId, POMAlternatesId, TableRow, Refcode, 	
		--PomDesc + (case Alternatescode when '' then '' else (case AlternatesDesc when '' then '' else '--' + AlternatesDesc end) end) as PomDesc, 
		(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc, TolPlus, 		
		--case left(Tolplus,1) when '+' then substring(Tolplus, 2, len(Tolplus)-1) else Tolplus end as Tolplus,
		(case left(TolMinus,1) when '-' then TolMinus else convert(decimal(18,4),('-' + cast(TolMinus as nvarchar(20)))) end)  as TolMinus , 
		TableRow,  How2MeasText, ImageId, IsOnQA, SortField, @CUser, @CDate , 
		@CUser, @CDate  FROM  #temp_measpoms 
	end

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
			--COALESCE(Incr1,'0') as Incr1
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
                set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
				set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '''' + @cntZero + ''') AS ' + @IncrCol + ','
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
		if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
		
		--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols

		CREATE TABLE #tempIGCData (
			 POMCompanyId uniqueidentifier
			 ,POMGuidId UNIQUEIDENTIFIER
			 ,POMAlternatesId UNIQUEIDENTIFIER	
			 ,Refcode nvarchar(10)			
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)				
		)
		if @PrimaryKeysOnly=1
			begin
				SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Refcode , tblPivot.Property as Sizecol,  tblPivot.Value as Incr FROM     
				(SELECT POMCompanyId,   pomguidid, pomalternatesid, Refcode , ' + @IncrNullCols + '			 
				FROM vwx_stylemeaspomdt_select  where 
				(CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (SizeClassCompanyId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
									  (ProductCompanyId = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (ClassRangeId = ''' + cast(@SizeRangeId as nvarchar(50)) +''')
				AND (IsPrimaryKeyMeas = 1)) vwx_stylemeaspomdt_select
				UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'
			end
		else
			begin
				SET @query = N'SELECT POMCompanyId, pomguidid, pomalternatesid,  Refcode , tblPivot.Property as Sizecol, tblPivot.Value as Incr FROM     
				(SELECT POMCompanyId,   pomguidid, pomalternatesid, Refcode , ' + @IncrNullCols + '			 
				FROM vwx_stylemeaspomdt_select  where 
				(CompanyGuidID = ''' + cast(@CompanyID as nvarchar(50)) + ''') AND (SizeClassCompanyId = ''' + cast(@SizeClassId as nvarchar(50)) + ''') AND 
									  (ProductCompanyId = ''' + cast(@ProductTypeID as nvarchar(50))+ ''') AND (ClassRangeId = ''' + cast(@SizeRangeId as nvarchar(50)) +''')
				) vwx_stylemeaspomdt_select
				UNPIVOT (Value For Property In (' + @IncrCols + ')) as tblPivot'
			end

		--select @query as query

		INSERT #tempIGCData EXEC (@query) 

		--select * from #tempIGCData order by refcode, sizecol

        SELECT @RowCounter = COUNT(*) FROM #tempIGCData
        
		if @RowCounter>0	
			begin
				--set @GRSampleSizeCol = (select top 1 SizeCol from #tempIGCData where Incr = 'B')			
				--set @SizeCol = convert(int, substring(@GRSampleSizeCol,5,len(@GRSampleSizeCol)-4))
				Select @SizeCol = SizeCount from pGRSizeRangeDetail where ClassRangeId = @SizeRangeID and [Sample]=1
				set @SizeColcnt = @SizeCol
				set @SizeCol =	@SizeCol-1			
				--select @SizeCol, @samplecol
				if @IsNegative = 1
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,
						 Incr =  
							cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)  <= @SizeColcnt) then 						
								(case COALESCE(Incr,'0')									
									when '' then  convert(decimal(18,4),-0)
									when 'B' then convert(decimal(18,4),0)	
									--when 'b' then convert(decimal(18,4),0)						
									else
										(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
								 end)
							else
								dbo.fnx_Frac2Num(Incr)
							end) as decimal(18,4)),				
						--cast((case Incr when 'B' then convert(decimal(18,4),0) else ( (case Incr when '' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,								
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId and p.refcode=t.refcode						
						)				
					end
				else
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,						
						cast((case Incr when 'B' then convert(decimal(18,4),0) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMCompanyId
						and p.pomguidid=t.pomguidid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId  and p.refcode=t.refcode
						)				
					end	
			end	

			--select * from pamlmeasigc order by pom_row, sizecol

			drop table #tempIGCData
			drop table #temp_measpoms
	end

Update pamlmeashdr set MeasRowCnt=@TotalCount where AMLMeasHdrId = @AMLMeasHdrId

if @SizeCol<>@samplecol
	begin		
		EXEC spx_StyleMeasIGC_Insert
		@AMLMeasHdrId,
		@samplecol,	
		@SizeCol,
		@IsNegative		
	end
		
Update pamlmeaslbl set IsSample=0 where AMLMeasHdrId = @AMLMeasHdrId and IsSample=1
Update pamlmeaslbl set IsSample=1 where AMLMeasHdrId = @AMLMeasHdrId and sizecol = @samplecol

--select * from pamlmeaslbl

if @IsRelative=1 
	begin
		EXEC spx_StyleMeasIMRelative_UPDATE	
		@AMLMeasHdrId		
	end
else
	begin
		EXEC spx_StyleMeasIMIncrement_UPDATE	
		@AMLMeasHdrId		
	end	
	
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#temp_measpoms') AND type in (N'U'))
DROP TABLE #temp_measpoms

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tempIGCData') AND type in (N'U'))
DROP TABLE #tempIGCData
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03013', GetDate())
GO

SET NOCOUNT Off
GO
