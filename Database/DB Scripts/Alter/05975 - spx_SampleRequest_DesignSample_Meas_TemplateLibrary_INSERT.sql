/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_TemplateLibrary_INSERT]    Script Date: 07/02/2013 15:46:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_TemplateLibrary_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_TemplateLibrary_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_TemplateLibrary_INSERT]    Script Date: 07/02/2013 15:46:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_TemplateLibrary_INSERT]
(	@SampleRequestAMLMeasHdrId uniqueidentifier,
	@POMLibraryID uniqueidentifier,
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
DECLARE @MaxPomRow int 
DECLARE @SampleRequestAMLMeasPomId uniqueidentifier 
DECLARE @MaxSort int

SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxSort = ISNULL(MAX(SortId), 0) FROM pSampleRequestamlmeaspom WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
Set @MaxPomRow=@MaxPomRow+1
set @SizeCnt = 0
Set @MaxSort = @MaxSort + 1

INSERT INTO pSampleRequestamlmeaspom(SampleRequestAMLMeasHdrId, POMGuidId, POMAlternatesId,  Refcode, Description, 
 Tolplus , TolMinus, How2MeasName, How2MeasText, ImageId, pom_row, wsrowid, Flag4QA, Critical, IsLinked, SortId, CUser, CDate, MUser, MDate)
SELECT @SampleRequestAMLMeasHdrId , POMId, POMAlternatesId, POMcode, 	
(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc, 0, 0, How2MeasName,		 
 How2MeasText, ImageId, @MaxPomRow, @MaxPomRow, 0, 0, 0, COALESCE(cast(pomSort as int),0), @CUser, @CDate , 
@CUser, @CDate  FROM  pGRMeasurementsPOMAlternates WITH (NOLOCK) where POMAlternatesId=@POMLibraryID   
order by POMSort, AlternateSort, POMcode, Alternatescode, PomDesc

select @SampleRequestAMLMeasPomId = SampleRequestAMLMeasPomId from pSampleRequestamlmeaspom where SampleRequestAMLMeasHdrId= @SampleRequestAMLMeasHdrId and POM_Row=@MaxPomRow 
and POMAlternatesId = @POMLibraryID 

SELECT @MaxSizeCol = count(SizeCol) FROM pSampleRequestamlmeaslbl WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

Update pSampleRequestamlmeashdr set MeasRowCnt=@MaxPomRow where SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol-1	
			begin
				insert into pSampleRequestAMLMeasIGC (SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPomId, pom_row, wsrowid, SizeCol, Incr, Grade, CUser, CDate, MUser, MDate)
				values (@SampleRequestAMLMeasHdrId, @SampleRequestAMLMeasPomId, @MaxPomRow, @MaxPomRow, @SizeCnt, 0, 0, @CUser, @CDate , @CUser, @CDate)
				SET @SizeCnt = @SizeCnt + 1
			end			
	end
		
UPDATE pSampleRequestAMLMeasPOM SET SortId = @MaxSort WHERE SortID = 0 And SampleRequestAMLMeasPOMId = @SampleRequestAMLMeasPomId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05975', GetDate())
GO