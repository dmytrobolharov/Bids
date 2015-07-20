IF OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplate_COPY]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_COPY]
GO

/************************************************************************************************
* Name  : spx_pGRMeasurementsPOMTemplate_COPY
* Author: Andrey Dmitrienko
* Creation date: 01/19/2015
* Description :	Create a new copy of the measurement templates group
*
*           
* Change History:                  
* 
* Comment#		Date				Author						Comment
*    01			01/21/2015			Andrey Dmitrienko			Added to copy data from a table pGRMPOMTemplateDivisions
*    02			01/22/2015			Andrey Dmitrienko			Added copying of information from the field POMTempItemGroupID 
*																to the table pGRMeasurementsPOMTemplateItem
*
*************************************************************************************************/

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_COPY]
(
	@SourcePOMTempID		UNIQUEIDENTIFIER,
	@SourcePOMTempGroupId	UNIQUEIDENTIFIER,
	@TargetPOMType			NVARCHAR(200),
	@TargetPOMDesc			NVARCHAR(400),
	@CUser					NVARCHAR(400),
	@CDate					DATETIME,
	@TargetPOMTempID		UNIQUEIDENTIFIER = NULL OUTPUT,
	@TargetPOMTempGroupId	UNIQUEIDENTIFIER = NULL OUTPUT
)
AS
  DECLARE @POMTempID UNIQUEIDENTIFIER
  DECLARE @NewPOMTempID UNIQUEIDENTIFIER
  DECLARE SourceTemplates CURSOR LOCAL FAST_FORWARD READ_ONLY FOR
   SELECT POMTempID
   FROM pGRMeasurementsPOMTemplate
   WHERE POMTempGroupID = @SourcePOMTempGroupId
BEGIN
  OPEN SourceTemplates
  FETCH NEXT FROM SourceTemplates INTO @POMTempID
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @NewPOMTempID = NEWID()
    IF @SourcePOMTempID = @POMTempID SET @TargetPOMTempID = @NewPOMTempID
    IF @TargetPOMTempGroupId IS NULL SET @TargetPOMTempGroupId = NEWID()
    
	-- copy data from pGRMeasurementsPOMTemplate
    INSERT INTO pGRMeasurementsPOMTemplate(
     POMTempID, POMTempGroupID, POMTempVersion, POMType, POMTypeDescription, SpecSketchID, SpecSketchVersion, 
 	 SizeClassId, SizeRangeId, ClassRangeId, SizeClass, SizeRange, ClassRange, SampleSize, CustomField1,
	 CustomField2, CustomField3, CustomField4, CustomField5, Size0, Size1, Size2, Size3, Size4, Size5, Size6, 
	 Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Size20, 
	 Size21, Size22, Size23, Size24, Size25, Size26, Size27, Size28, Size29, Size30, Size31, Size32, Size33, Size34, 
	 Size35, Size36, Size37, Size38, Size39, Size40, Size41, Size42, Size43, Size44, Size45, Size46, Size47, Size48, 
	 Size49, CUser, CDate, MUser, MDate, Sort, Active, Linked)
    SELECT @NewPOMTempID, @TargetPOMTempGroupId, POMTempVersion, @TargetPOMType, @TargetPOMDesc, SpecSketchID, SpecSketchVersion, 
 		   SizeClassId, SizeRangeId, ClassRangeId, SizeClass, SizeRange, ClassRange, SampleSize, CustomField1,
		   CustomField2, CustomField3, CustomField4, CustomField5, Size0, Size1, Size2, Size3, Size4, Size5, Size6, 
		   Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, Size20, 
		   Size21, Size22, Size23, Size24, Size25, Size26, Size27, Size28, Size29, Size30, Size31, Size32, Size33, Size34, 
		   Size35, Size36, Size37, Size38, Size39, Size40, Size41, Size42, Size43, Size44, Size45, Size46, Size47, Size48, 
	       Size49, @CUser, @CDate, @CUser, @CDate, Sort, Active, Linked
    FROM pGRMeasurementsPOMTemplate
	WHERE POMTempID = @POMTempID
	
	-- copy data from pGRMeasurementsPOMTemplateGroup
	INSERT INTO pGRMeasurementsPOMTemplateGroup(
	  POMTempGroupID, POMTempID, POMType, POMTypeDescription, SizeClassId, SizeRangeId, ClassRangeId, SizeClass, 
	  SizeRange, ClassRange, Relative, Negative, Metric, Active, Sort, CUser, CDate, MUser, MDate)
	SELECT @TargetPOMTempGroupId, @NewPOMTempID, @TargetPOMType, @TargetPOMDesc, SizeClassId, SizeRangeId, ClassRangeId, 
		   SizeClass, SizeRange, ClassRange, Relative, Negative, Metric, Active, Sort, @CUser, @CDate, @CUser, @CDate
	FROM pGRMeasurementsPOMTemplateGroup
	WHERE POMTempID = @POMTempID
	
	-- copy data from pGRMeasurementsPOMTemplateItem
	INSERT INTO pGRMeasurementsPOMTemplateItem(
	   POMTempID, POMTempGroupID, POMID, AlternatesId, POMAlternatesID, SizeclassID, SizeRangeID, ClassRangeID, ImageId, 
	   SampleSizeRangeID, FitComID, Critical, IsOnQA, IsLinked, POMCode, POMDesc, AlternatesCode, AlternatesDesc, How2MeasText, 
	   How2MeasName, POMSort, AlternatesSort, Active, TolPlus, TolMinus, Incr0, Incr1, Incr2, Incr3, Incr4, Incr5, Incr6, Incr7, 
	   Incr8, Incr9, Incr10, Incr11, Incr12, Incr13, Incr14, Incr15, Incr16, Incr17, Incr18, Incr19, Incr20, Incr21, Incr22, Incr23,
	   Incr24, Incr25, Incr26, Incr27, Incr28, Incr29, Incr30, Incr31, Incr32, Incr33, Incr34, Incr35, Incr36, Incr37, Incr38, 
	   Incr39, Incr40, Incr41, Incr42, Incr43, Incr44, Incr45, Incr46, Incr47, Incr48, Incr49, CDate, CUser, MDate, MUser, 
	   Change, Sort, CopyPOMTempItemID, Conv, TempCopyPOMTempItemID, NonWashTolPlus, NonWashTolMinus, POMTempItemGroupID)
    SELECT @NewPOMTempID, @TargetPOMTempGroupId, POMID, AlternatesId, POMAlternatesID, SizeclassID, SizeRangeID, ClassRangeID, ImageId, 
		   SampleSizeRangeID, FitComID, Critical, IsOnQA, IsLinked, POMCode, POMDesc, AlternatesCode, AlternatesDesc, How2MeasText, 
	       How2MeasName, POMSort, AlternatesSort, Active, TolPlus, TolMinus, Incr0, Incr1, Incr2, Incr3, Incr4, Incr5, Incr6, Incr7, 
	       Incr8, Incr9, Incr10, Incr11, Incr12, Incr13, Incr14, Incr15, Incr16, Incr17, Incr18, Incr19, Incr20, Incr21, Incr22, Incr23,
	       Incr24, Incr25, Incr26, Incr27, Incr28, Incr29, Incr30, Incr31, Incr32, Incr33, Incr34, Incr35, Incr36, Incr37, Incr38, 
	       Incr39, Incr40, Incr41, Incr42, Incr43, Incr44, Incr45, Incr46, Incr47, Incr48, Incr49, @CDate, @CUser, @CDate, @CUser, 
		   Change, Sort, CopyPOMTempItemID, Conv, TempCopyPOMTempItemID, NonWashTolPlus, NonWashTolMinus, POMTempItemGroupID
    FROM pGRMeasurementsPOMTemplateItem
	WHERE POMTempID = @POMTempID
	
	-- copy data from pGRMPOMTemplateDivisions
	INSERT INTO pGRMPOMTemplateDivisions(GRMPOMTemplateID, DivisionID)
	SELECT @NewPOMTempID, DivisionID
	FROM pGRMPOMTemplateDivisions
	WHERE GRMPOMTemplateID = @POMTempID
	
	FETCH NEXT FROM SourceTemplates INTO @POMTempID
  END
  CLOSE SourceTemplates
  DEALLOCATE SourceTemplates
  IF @TargetPOMTempID IS NULL
   SELECT TOP 1 @TargetPOMTempID = POMTempID
   FROM pGRMeasurementsPOMTemplateItem
   WHERE POMTempGroupID = @TargetPOMTempGroupId
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09268', GetDate())

GO


