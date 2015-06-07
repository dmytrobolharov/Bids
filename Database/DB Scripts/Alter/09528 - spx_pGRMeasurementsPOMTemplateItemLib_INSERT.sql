IF OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]
(	@POMTempID  UNIQUEIDENTIFIER,
	@POMTempGroupId  UNIQUEIDENTIFIER,
	@POMAlternatesId UNIQUEIDENTIFIER,	
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS
  DECLARE @SizeClassId UNIQUEIDENTIFIER
  DECLARE @SizeRangeId UNIQUEIDENTIFIER
  DECLARE @ClassRangeId UNIQUEIDENTIFIER
  DECLARE @SourcePOMTempID UNIQUEIDENTIFIER
  DECLARE @POMTempItemGroupID UNIQUEIDENTIFIER
  
  DECLARE POMTemplateSizesList CURSOR LOCAL FAST_FORWARD READ_ONLY FOR
	SELECT SizeClassId, SizeRangeId, ClassRangeId, POMTempID 
	FROM pGRMeasurementsPOMTemplate 
	WHERE POMTempGroupId = @POMTempGroupId 
	ORDER BY POMTempID	
BEGIN

  SET @POMTempItemGroupID = NEWID()
  
  OPEN POMTemplateSizesList
  FETCH NEXT FROM POMTemplateSizesList
  INTO @SizeClassId, @SizeRangeId, @ClassRangeId, @SourcePOMTempID 
  WHILE @@FETCH_STATUS = 0 
  BEGIN
	INSERT INTO pGRMeasurementsPOMTemplateItem(
	  POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, ImageId, POMTempItemGroupID,
	  POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, POMCode, POMDesc, AlternatesCode, 
	  AlternatesDesc, How2MeasText, How2MeasName, POMSort, Sort, AlternatesSort, Active, bKey,
	  Cuser, Cdate, Mdate, MUser)
	SELECT @POMTempGroupId, @SourcePOMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId, ImageId, 
		   @POMTempItemGroupID, POMID, AlternatesId, POMAlternatesId, 1, 1, POMCode, POMDesc, AlternatesCode, 
		   AlternatesDesc, How2MeasText, How2MeasName, POMSort, RIGHT('0000' + CAST(POMSort AS NVARCHAR(4)), 4), 
		   AlternateSort, Active, 1, @CUser, @CDate, @CDate , @CUser  
	FROM pGRMeasurementsPOMAlternates 
	WHERE POMAlternatesId = @POMAlternatesId       
    
    FETCH NEXT FROM POMTemplateSizesList
    INTO @SizeClassId, @SizeRangeId, @ClassRangeId, @SourcePOMTempID 
  END
  CLOSE POMTemplateSizesList
  DEALLOCATE POMTemplateSizesList

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09528', GetDate())
GO
