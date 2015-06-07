IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]') AND type in (N'P', N'PC'))
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
	  Cuser, Cdate, Mdate, MUser,
	  Incr0, Incr1, Incr2, Incr3, Incr4, 
	  Incr5, Incr6, Incr7, Incr8, Incr9, 
	  Incr10, Incr11, Incr12, Incr13, Incr14, 
	  Incr15, Incr16, Incr17, Incr18, Incr19, 
	  Incr20, Incr21, Incr22, Incr23, Incr24, 
	  Incr25, Incr26, Incr27, Incr28, Incr29, 
	  Incr30, Incr31, Incr32, Incr33, Incr34, 
	  Incr35, Incr36, Incr37, Incr38, Incr39, 
	  Incr40, Incr41, Incr42, Incr43, Incr44, 
	  Incr45, Incr46, Incr47, Incr48, Incr49,
	  TolPlus, TolMinus)
	SELECT	@POMTempGroupId, @SourcePOMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId, pa.ImageId, 
			@POMTempItemGroupID, pa.POMID, pa.AlternatesId, pa.POMAlternatesId, 1, 1, pa.POMCode, pa.POMDesc, pa.AlternatesCode, 
			pa.AlternatesDesc, pa.How2MeasText, pa.How2MeasName, pa.POMSort, RIGHT('0000' + CAST(pa.POMSort AS NVARCHAR(4)), 4), 
			pa.AlternateSort, pa.Active, 1, @CUser, @CDate, @CDate , @CUser,
			CASE WHEN pt.Size0 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size1 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size2 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size3 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size4 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size5 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size6 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size7 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size8 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size9 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size10 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size11 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size12 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size13 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size14 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size15 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size16 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size17 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size18 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size19 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size20 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size21 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size22 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size23 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size24 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size25 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size26 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size27 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size28 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size29 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size30 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size31 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size32 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size33 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size34 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size35 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size36 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size37 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size38 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size39 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size40 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size41 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size42 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size43 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size44 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size45 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size46 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size47 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size48 != '' THEN 0 ELSE NULL END, 
			CASE WHEN pt.Size49 != '' THEN 0 ELSE NULL END,
			0, 0
	FROM pGRMeasurementsPOMAlternates pa
	INNER JOIN pGRMeasurementsPOMTemplate pt ON pt.POMTempID = @SourcePOMTempID
	WHERE POMAlternatesId = @POMAlternatesId       
    
    FETCH NEXT FROM POMTemplateSizesList
    INTO @SizeClassId, @SizeRangeId, @ClassRangeId, @SourcePOMTempID 
  END
  CLOSE POMTemplateSizesList
  DEALLOCATE POMTemplateSizesList

END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09965', GetUTCDate())
GO
