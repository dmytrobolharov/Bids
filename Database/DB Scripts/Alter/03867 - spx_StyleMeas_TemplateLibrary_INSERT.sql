IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_TemplateLibrary_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_TemplateLibrary_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeas_TemplateLibrary_INSERT]
(	@AMLMeasHdrId uniqueidentifier,
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
DECLARE @AMLMeasPomId uniqueidentifier 
DECLARE @MaxSort int

SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxSort = ISNULL(MAX(SortId), 0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
Set @MaxPomRow=@MaxPomRow+1
set @SizeCnt = 0
Set @MaxSort = @MaxSort + 1

INSERT INTO pamlmeaspom(AMLMeasHdrId, POMGuidId, POMAlternatesId,  Refcode, Description, 
 Tolplus , TolMinus, How2MeasName, How2MeasText, ImageId, pom_row, wsrowid, Flag4QA, Critical, IsLinked, SortId, CUser, CDate, MUser, MDate)
SELECT @AMLMeasHdrId , POMId, POMAlternatesId, POMcode, 	
(PomDesc + case Alternatescode when '' then '' else '--' + AlternatesDesc end) as PomDesc, 0, 0, How2MeasName,		 
 How2MeasText, ImageId, @MaxPomRow, @MaxPomRow, 0, 0, 0, COALESCE(cast(pomSort as int),0), @CUser, @CDate , 
@CUser, @CDate  FROM  pGRMeasurementsPOMAlternates WITH (NOLOCK) where POMAlternatesId=@POMLibraryID   
order by POMSort, AlternateSort, POMcode, Alternatescode, PomDesc

select @AMLMeasPomId = AMLMeasPomId from pamlmeaspom where AMLMeasHdrId= @AMLMeasHdrId and POM_Row=@MaxPomRow 
and POMAlternatesId = @POMLibraryID 

SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Update pamlmeashdr set MeasRowCnt=@MaxPomRow where AMLMeasHdrId = @AMLMeasHdrId

if @MaxSizeCol>0
	begin
		WHILE @SizeCnt <= @MaxSizeCol-1	
			begin
				insert into pAMLMeasIGC (AMLMeasHdrId, AMLMeasPomId, pom_row, wsrowid, SizeCol, Incr, Grade, CUser, CDate, MUser, MDate)
				values (@AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxPomRow, @SizeCnt, 0, 0, @CUser, @CDate , @CUser, @CDate)
				SET @SizeCnt = @SizeCnt + 1
			end			
	end
		
UPDATE pAMLMeasPOM SET SortId = @MaxSort WHERE SortID = 0 And AMLMeasPOMId = @AMLMeasPomId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03867', GetDate())
GO
