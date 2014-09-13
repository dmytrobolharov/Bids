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

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeas_ConvertToPOMTemplate') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeas_ConvertToPOMTemplate
GO


CREATE PROCEDURE spx_StyleMeas_ConvertToPOMTemplate
(
	@AMLMeasHdrId uniqueidentifier,	
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
DECLARE @POMTempId nvarchar(50)
DECLARE	@POMTempGroupID nvarchar(50)
DECLARE @SizeClassID nvarchar(50)
DECLARE	@SizeRangeID nvarchar(50)
DECLARE @classrangeId nvarchar(50)
DECLARE @SizeRange nvarchar(50)
DECLARE @sizeclass nvarchar(100)
Declare @POMRows nvarchar(2000)
	
SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @POMTempGroupID = ProductTypeID,
@SizeClassID = SizeClassID , @SizeRangeID = SizeRangeID , @POMTempId = CompanyID, 
@SizeRange = SizeRange, @sizeclass = sizeclass 
FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Select @classrangeId = classrangeId, @sTemplatecol=convert(int,COALESCE(samplesize,'0')) from pGRMeasurementsPOMTemplate 
where POMTempID = @POMTempId

Select @SampleCol = sizecol from pamlmeaslbl where issample=1 and amlmeashdrid=@AMLMeasHdrId

SELECT @MaxPOMRow = COALESCE(max(POM_Row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

set @SizeCnt = 0
set @IncrCols = ''
set @IncrNullCols = '' 
set @IncrCol = ''

--Get only Incr cols for Sizecols present
if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol-1
			BEGIN
				set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
				set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
				set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '0' + ') AS ' + @IncrCol + ','
				SET @SizeCnt = @SizeCnt + 1
			END

	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
	if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
	--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols
end


If @MaxPOMRow > 0
	begin
	
		CREATE TABLE #tempIGCData (
			 POMTempItemID nvarchar(50)
			 ,AMLMeasHdrId nvarchar(50)
			 ,AMLMeasPomId nvarchar(50)		
			 ,POMId nvarchar(50)
			 ,POMAlternatesId nvarchar(50)
			 ,POMCode nvarchar(10)		
			 ,Alternatescode nvarchar(10)
			 ,AlternatesDesc nvarchar(100)
			 ,PomDesc nvarchar(200)
			 ,IsOnQA int
			 ,IsLinked int
			 ,Critical int
			 ,TolPlus decimal(18,4)
			 ,TolMinus decimal(18,4)	
			 ,How2MeasText nvarchar(4000)
			 ,How2MeasName nvarchar(200)
			 ,SortId int			 	
			 ,ImageId uniqueidentifier	
			 ,POMRow int			 	 		
			 ,Sizecol nvarchar(10)		 
			 ,Incr nvarchar(20)	
			
		)
		SET @query = N'SELECT POMTempItemID, AMLMeasHdrId, AMLMeasPomId, pomid, pomalternatesid,  POMcode , Alternatescode, AlternatesDesc,
		PomDesc, IsOnQA, IsLinked, Critical, TolPlus, TolMinus, How2MeasText, How2MeasName, POMSort, ImageId,		
		POMRow, Sizecol, Incr FROM     
		(SELECT t.POMTempItemID, p.AMLMeasHdrId, p.AMLMeasPomId,  t.pomid, t.pomalternatesid,  t.POMcode , t.Alternatescode, t.AlternatesDesc,
		t.PomDesc, t.IsOnQA, t.IsLinked, t.Critical, t.TolPlus, t.TolMinus, t.How2MeasText, t.How2MeasName, t.POMSort, t.ImageId, p.POM_Row as POMRow,
		' + @IncrNullCols + '	FROM pGRMeasurementsPOMTemplateItem t, pamlmeaspom p				
		 where t.POMTempItemID = p.GRPOMCompanyId and t.POMTempID = ''' + cast(@POMTempID as nvarchar(50)) + '''
		and  p.amlmeashdrid=''' + convert(nvarchar(50),@AMLMeasHdrId) + ''' and p.GRPOMCompanyId is not null ) p1 							  
		UNPIVOT (Incr For Sizecol In (' + @IncrCols + ')) as unpvt ;'		
		
        select @query as igcqry

		INSERT #tempIGCData EXEC (@query)                 
       
        select  * FROM #tempIGCData order by POMRow, sizecol

		SELECT @RowCounter = COUNT(*) FROM #tempIGCData
		

		if @RowCounter>0	
			begin			
				--select @SizeCol, @samplecol	
				--select count(*) as igccount3 from pamlmeasigc 
				update pamlmeaspom set [Description] = (t.PomDesc + case t.AlternatesDesc when '' then '' when 'none' then '' else '--' + t.AlternatesDesc end) ,  
				Refcode=t.pomcode, SortId = t.SortId, How2MeasText = t.How2MeasText, ImageId = t.ImageId, Flag4QA = t.IsOnQA, Tolplus = t.Tolplus ,
				TolMinus = (case left(t.TolMinus,1) when '-' then t.TolMinus else convert(decimal(18,4),('-' + cast(t.TolMinus as nvarchar(20)))) end)  					
				from pamlmeaspom p inner join #tempIGCData t on p.amlmeashdrid=t.amlmeashdrid and
				p.GRPOMCompanyId=t.POMTempItemID and p.AMLMeasPomId=t.AMLMeasPomId and p.POM_Row=t.POMRow
				--and p.POMAlternatesId=t.POMAlternatesId	and p.AMLMeasHdrId =t.AMLMeasHdrId  
				where p.amlmeashdrid=@AMLMeasHdrId and p.GRPOMCompanyId is not null
				
				update pamlmeasigc set Incr =  case @IsNegative when 1 
				then
					(cast((case when (substring(cast(t.Sizecol as nvarchar(10)), 5, len(t.Sizecol))  < @sTemplatecol) then 						
						(case COALESCE(t.Incr,'0')
							when '' then  convert(decimal(18,4),-0)
							--when 'B' then convert(decimal(18,4),0)							
							else
								(case when left(t.Incr,1) = '-' then dbo.fnx_Frac2Num(t.Incr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(20),t.Incr)) end)
						 end)
					else
						dbo.fnx_Frac2Num(t.Incr)
					end) as decimal(18,4)))
				else
					dbo.fnx_Frac2Num(t.Incr) 
				end							
				from pamlmeasigc i inner join #tempIGCData t on i.amlmeashdrid=t.amlmeashdrid and
				i.AMLMeasPomId=t.AMLMeasPomId and i.pom_row=t.pomrow and i.sizecol=convert(int,(cast(substring(cast(t.Sizecol as nvarchar(10)), 5, len(t.Sizecol)) as int)))  inner join 
				pamlmeaspom p on p.GRPOMCompanyId=t.POMTempItemID 
				and p.AMLMeasPomId=t.AMLMeasPomId and p.pom_row=t.pomrow 
				where i.amlmeashdrid=@AMLMeasHdrId 																			
			end	
	
	--declare @columns nvarchar(2000)	
	--SELECT @columns = COALESCE(@columns + ',', '') + cast(pomrow as nvarchar(20))
	--FROM #tempIGCData order by pomrow	
	--SELECT @columns			
	
	 SELECT  @POMRows =       
	   STUFF(  
		(SELECT DISTINCT ','  + convert(nvarchar(20),pomrow) FROM  
		  #tempIGCData where amlmeashdrid=@AMLMeasHdrId		  
		FOR XML PATH('') ) , 1, 1 ,'')  
		 
	  SELECT  @POMRows   	    	   
	
	select * from pamlmeaspom where amlmeashdrid=@AMLMeasHdrId  order by pom_row
	select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId  order by pom_row, sizecol
	
	DROP TABLE #tempIGCData				       		

	if @IsRelative=1 
		begin
			EXEC spx_StyleMeasTempConv_IMRelative_UPDATE	
			@AMLMeasHdrId,
			@sTemplatecol,
			@POMRows		
		end
	else
		begin
			EXEC spx_StyleMeasTempConv_IMIncrement_UPDATE
			@AMLMeasHdrId,
			@sTemplatecol,
			@POMRows		
		end	
		
	 SELECT  @POMRows as ss
	 select @samplecol smpcol
	if @samplecol<> @sTemplatecol
		begin
			if @IsRelative=1 
				begin
					EXEC spx_StyleMeasSampleSizeRelative_Update
					@AMLMeasHdrId,
					@samplecol										
				end
			else
				begin
					EXEC spx_StyleMeasSampleSizeIncrement_Update
					@AMLMeasHdrId,
					@samplecol									
				end
			
		end
		
	
end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03030', GetDate())
GO

SET NOCOUNT Off
GO
