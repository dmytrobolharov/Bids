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

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeas_POMTemplateLibrary_Add') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeas_POMTemplateLibrary_Add
GO


CREATE PROCEDURE spx_StyleMeas_POMTemplateLibrary_Add
(
	@AMLMeasHdrId uniqueidentifier,
	@POMTempId uniqueidentifier,
	@POMTempItemID uniqueidentifier,		
	@CUser nvarchar(200),
	@CDate datetime 
)
AS

declare @MaxSizeCol int
declare @TotalCount int
declare @RowCounter int
Declare @IncrCols nvarchar(2000)
Declare @SizeCnt  int
DECLARE @query NVARCHAR(max)
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
Declare @IncrNullCols nvarchar(2000)
Declare @IncrCol nvarchar(10)
declare @samplecol int
declare @sTemplatecol int
DECLARE @MaxPomRow int 
DECLARE @AMLMeasPomId uniqueidentifier

SELECT @MaxPomRow = isnull(MAX(pom_row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
Set @MaxPomRow=@MaxPomRow+1

set @AMLMeasPomId= NEWID()

INSERT INTO pamlmeaspom(AMLMeasHdrId, AMLMeasPomId, GRPOMCompanyId, POMGuidId, POMAlternatesId,  Refcode, Description, 
 Tolplus , TolMinus, How2MeasName, How2MeasText, ImageId, pom_row, wsrowid, Flag4QA, Critical, IsLinked, SortId, CUser, CDate, MUser, MDate)
SELECT @AMLMeasHdrId , @AMLMeasPomId, POMTempItemID , POMId, POMAlternatesId, POMcode, 	
(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc, TolPlus, 		
(case left(TolMinus,1) when '-' then TolMinus else convert(decimal(18,4),('-' + cast(TolMinus as nvarchar(20)))) end)  as TolMinus , 
 How2MeasName, How2MeasText, ImageId, @MaxPomRow, @MaxPomRow, IsOnQA, Critical, IsLinked, COALESCE(cast(pomSort as int),0), @CUser, @CDate , 
@CUser, @CDate  FROM  pGRMeasurementsPOMTemplateItem WITH (NOLOCK) where POMTempID=@POMTempID  and POMTempItemID=@POMTempItemID  
order by POMSort, AlternatesSort, POMcode, Alternatescode, PomDesc

--SELECT * FROM pamlmeaspom   	 WHERE AMLMeasHdrId= @AMLMeasHdrId ORDER BY POM_Row, SortId, refcode, [Description]

select @TotalCount=count(pom_row) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
select @samplecol = sizecol from pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId and IsSample=1
SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
Select @sTemplatecol = convert(int,samplesize) from pGRMeasurementsPOMTemplate where POMTempID = @POMTempId

--SELECT * FROM pamlmeaspom   	 WHERE AMLMeasHdrId= @AMLMeasHdrId ORDER BY POM_Row, SortId, refcode, [Description]

set @SizeCnt = 0
set @IncrCols = ''
set @IncrNullCols = '' 
set @IncrCol = ''

if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol-1
			--COALESCE(Incr1,'0') as Incr1
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
                set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
				set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '0' + ') AS ' + @IncrCol + ','
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
		if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
		
		--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols		

		CREATE TABLE #tempIGCData (
			 POMTempItemID uniqueidentifier
			 ,pomid UNIQUEIDENTIFIER
			 ,POMAlternatesId UNIQUEIDENTIFIER	
			 ,POMcode nvarchar(10)			
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)				
		)		


		SET @query = N'SELECT POMTempItemID, pomid, pomalternatesid,  POMcode , Sizecol, Incr FROM     
		(SELECT POMTempItemID,   pomid, pomalternatesid, POMcode , ' + @IncrNullCols + '			 
		FROM pGRMeasurementsPOMTemplateItem  where 
		POMTempID = ''' + cast(@POMTempID as nvarchar(50)) + '''
		and POMTempItemID = ''' + cast(@POMTempItemID as nvarchar(50)) + ''') p 							  
		UNPIVOT (Incr For Sizecol In (' + @IncrCols + ')) as unpvt ;'		

		--select @query as query

		INSERT #tempIGCData EXEC (@query) 

		--select * from #tempIGCData order by POMcode, sizecol

        SELECT @RowCounter = COUNT(*) FROM #tempIGCData
        
		if @RowCounter>0	
			begin								
				if @IsNegative = 1
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol))) as SizeCol,
						 Incr =  
							cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol))  < @sTemplatecol) then 						
								(case COALESCE(Incr,'0')									
									when '' then  convert(decimal(18,4),-0)
									--when 'B' then convert(decimal(18,4),0)	
									--when 'b' then convert(decimal(18,4),0)						
									else
										(case when left(Incr,1) = '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end)
								 end)
							else
								dbo.fnx_Frac2Num(Incr)
							end) as decimal(18,4)),				
						--cast((case Incr when 'B' then convert(decimal(18,4),0) else ( (case Incr when '' then convert(decimal(18,4),0) else (case left(Incr,1) when '-' then dbo.fnx_Frac2Num(Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),Incr)) end) end) end) as decimal(18,4)) else dbo.fnx_Frac2Num(Incr) end) as decimal(18,4))) as Incr,								
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMTempItemID 
						and p.amlmeashdrid=@AMLMeasHdrId and p.amlmeaspomid=@AMLMeasPomId and p.POM_Row=@MaxPomRow
						--and p.pomguidid=t.pomid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId and p.refcode=t.pomcode						
						)				
					end
				else
					begin
						INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @AMLMeasHdrId, p.AMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol)-4)-1) as SizeCol,						
						cast(dbo.fnx_Frac2Num(Incr)  as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMTempItemID 
						and p.amlmeashdrid=@AMLMeasHdrId and p.amlmeaspomid=@AMLMeasPomId and p.POM_Row=@MaxPomRow
						--and p.pomguidid=t.pomid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId  and p.refcode=t.pomcode
						)				
					end	
			end	

			--select * from pamlmeasigc order by pom_row, sizecol

			drop table #tempIGCData
			
	end

Update pamlmeashdr set MeasRowCnt=@TotalCount where AMLMeasHdrId = @AMLMeasHdrId


if @IsRelative=1 
	begin
		EXEC spx_StyleMeasTemplate_IMRelative_UPDATE	
		@AMLMeasHdrId,
		@sTemplatecol,
		@MaxPomRow		
	end
else
	begin
		EXEC spx_StyleMeasTemplate_IMIncrement_UPDATE	
		@AMLMeasHdrId,
		@sTemplatecol,
		@MaxPomRow		
	end	
	
if @samplecol<> @sTemplatecol
	begin
		if @IsRelative=1 
			begin
				EXEC spx_StyleMeas_TempSmpSizeRelative_Update
				@AMLMeasHdrId,
				@samplecol,				
				@MaxPomRow	
			end
		else
			begin
				EXEC spx_StyleMeas_TempSmpSizeIncrement_Update
				@AMLMeasHdrId,
				@samplecol,				
				@MaxPomRow
			end
		
	end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03033', GetDate())
GO

SET NOCOUNT Off
GO
