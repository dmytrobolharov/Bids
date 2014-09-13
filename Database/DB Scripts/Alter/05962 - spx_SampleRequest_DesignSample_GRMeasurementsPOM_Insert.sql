/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert]    Script Date: 07/02/2013 15:42:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert]    Script Date: 07/02/2013 15:42:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_GRMeasurementsPOM_Insert]
(
	@SampleRequestAMLMeasHdrId uniqueidentifier,
	@POMTempId uniqueidentifier,		
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


INSERT INTO pSampleRequestamlmeaspom(SampleRequestAMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId,  Refcode, Description, 
 Tolplus , TolMinus, How2MeasName, How2MeasText, ImageId, pom_row, wsrowid, Flag4QA, Critical, IsLinked, SortId, CUser, CDate, MUser, MDate)
SELECT @SampleRequestAMLMeasHdrId , POMTempItemID , POMId, POMAlternatesId, POMcode, 	
(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc, TolPlus, 		
(case left(TolMinus,1) when '-' then TolMinus else convert(decimal(18,4),('-' + cast(TolMinus as nvarchar(20)))) end)  as TolMinus , 
 How2MeasName, How2MeasText, ImageId, 0, 0, IsOnQA, Critical, IsLinked, COALESCE(cast(pomSort as int),0), @CUser, @CDate , 
@CUser, @CDate  FROM  pGRMeasurementsPOMTemplateItem WITH (NOLOCK) where POMTempID=@POMTempID   
order by POMSort, AlternatesSort, POMcode, Alternatescode, PomDesc

--SELECT * FROM pamlmeaspom   	 WHERE AMLMeasHdrId= @AMLMeasHdrId ORDER BY POM_Row, SortId, refcode, [Description]

begin
	WITH tempTable AS  (        
	 SELECT WSRowId, pom_row, ROW_NUMBER() OVER (ORDER BY SortId, refcode, [Description])-1 AS rn        
	 FROM pSampleRequestamlmeaspom   
	 WHERE SampleRequestAMLMeasHdrId= @SampleRequestAMLMeasHdrId )
	UPDATE tempTable SET WSRowId= rn, POM_Row= rn;  
end

select @TotalCount=count(pom_row) FROM pSampleRequestamlmeaspom WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
SELECT @MaxSizeCol = count(SizeCol) FROM pSampleRequestamlmeaslbl WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
select @samplecol = sizecol from pSampleRequestamlmeaslbl WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId and IsSample=1
SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric FROM pSampleRequestamlmeashdr WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

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
		POMTempID = ''' + cast(@POMTempID as nvarchar(50)) + ''') p 							  
		UNPIVOT (Incr For Sizecol In (' + @IncrCols + ')) as unpvt ;'		

		--select @query as query

		INSERT #tempIGCData EXEC (@query) 

		--select * from #tempIGCData order by POMcode, sizecol

        SELECT @RowCounter = COUNT(*) FROM #tempIGCData
        
		if @RowCounter>0	
			begin				
				
				if @IsNegative = 1
					begin
						INSERT INTO pSampleRequestamlmeasigc(SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @SampleRequestAMLMeasHdrId, p.SampleRequestAMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol))) as SizeCol,
						 Incr =  
							cast((case when (substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol))  < @samplecol) then 						
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
						@CUser, @CDate, @CUser, @CDate from pSampleRequestamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMTempItemID 
						and p.SampleRequestamlmeashdrid=@SampleRequestAMLMeasHdrId
						--and p.pomguidid=t.pomid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId and p.refcode=t.pomcode						
						)				
					end
				else
					begin
						INSERT INTO pSampleRequestamlmeasigc(SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPomId, POM_Row, WSRowid, SizeCol, Incr, CUser, CDate,
						MUser, MDate)
						(select @SampleRequestAMLMeasHdrId, p.SampleRequestAMLMeasPomId, p.POM_Row, p.WSRowid,(substring(cast(Sizecol as nvarchar(10)), 5, len(Sizecol))) as SizeCol,						
						cast(dbo.fnx_Frac2Num(Incr)  as decimal(18,4)) as Incr ,
						@CUser, @CDate, @CUser, @CDate from pSampleRequestamlMeaspom p, #tempIGCData t where p.GRPOMCompanyId=t.POMTempItemID 
						and p.SampleRequestamlmeashdrid=@SampleRequestAMLMeasHdrId
						--and p.pomguidid=t.pomid and p.pomalternatesid=t.pomalternatesid and p.amlmeashdrid=@AMLMeasHdrId  and p.refcode=t.pomcode
						)				
					end	
			end	

			--select * from pamlmeasigc order by pom_row, sizecol

			drop table #tempIGCData
			
	end

Update pSampleRequestamlmeashdr set MeasRowCnt=@TotalCount where SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

UPDATE pSampleRequestAMLMeasPOM set SortId = POM_Row WHERE SortId = 0 AND SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
--select * from pamlmeaslbl where AMLMeasHdrId = @AMLMeasHdrId order by sizecol

if @IsRelative=1 
	begin
		EXEC spx_SampleRequest_DesignSample_IMRelative_UPDATE	
		@SampleRequestAMLMeasHdrId		
	end
else
	begin
		EXEC spx_SampleRequest_DesignSample_IMIncrement_UPDATE	
		@SampleRequestAMLMeasHdrId		
	end	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05962', GetDate())
GO
