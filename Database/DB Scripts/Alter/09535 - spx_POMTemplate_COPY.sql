IF OBJECT_ID(N'[dbo].[spx_POMTemplate_COPY]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_POMTemplate_COPY]
GO

CREATE PROCEDURE [dbo].[spx_POMTemplate_COPY]
(
@POMTempID uniqueidentifier,
@NewPOMTempID uniqueidentifier,
@POMTempGroupID uniqueidentifier,
@SizeClass nvarchar(400),
@SizeRange nvarchar(200),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(100)
)
AS 

DECLARE 
@recCount as int, 
@rowCount int, 
@POMTempItemID nvarchar(50),	
@SizeRangeCode nvarchar(200),
@Size0 nvarchar(200),
@Size1 nvarchar(200),
@Size2 nvarchar(200),
@Size3 nvarchar(200),
@Size4 nvarchar(200),
@Size5 nvarchar(200),
@Size6 nvarchar(200),
@Size7 nvarchar(200),
@Size8 nvarchar(200),
@Size9 nvarchar(200),
@Size10 nvarchar(200),
@Size11 nvarchar(200),
@Size12 nvarchar(200),
@Size13 nvarchar(200),
@Size14 nvarchar(200),
@Size15 nvarchar(200),
@Size16 nvarchar(200),
@Size17 nvarchar(200),
@Size18 nvarchar(200),
@Size19 nvarchar(200),
@Sel0 nvarchar(50),
@Sel1 nvarchar(50),
@Sel2 nvarchar(50),
@Sel3 nvarchar(50),
@Sel4 nvarchar(50),
@Sel5 nvarchar(50),
@Sel6 nvarchar(50),
@Sel7 nvarchar(50),
@Sel8 nvarchar(50),
@Sel9 nvarchar(50),
@Sel10 nvarchar(50),
@Sel11 nvarchar(50),
@Sel12 nvarchar(50),
@Sel13 nvarchar(50),
@Sel14 nvarchar(50),
@Sel15 nvarchar(50),
@Sel16 nvarchar(50),
@Sel17 nvarchar(50),
@Sel18 nvarchar(50),
@Sel19 nvarchar(50)

SET @recCount = 1
SET NOCOUNT ON

		SELECT  @SizeRangeCode = SizeRangeCode, @Size0 = Size0, @Size1 = Size1, @Size2 = Size2, @Size3 = Size3, @Size4 = Size4, @Size5 = Size5, 
			@Size6 = Size6, @Size7 = Size7, @Size8 = Size8, @Size9 = Size9, @Size10 = Size10, @Size11 = Size11, @Size12 = Size12, @Size13 = Size13, @Size14 = Size14, @Size15 = Size15, 
			@Size16 = Size16, @Size17 = Size17, @Size18 = Size18, @Size19 = Size19, @Sel0 = Sel0, @Sel1 = Sel1, 
			@Sel2 = Sel2, @Sel3 = Sel3, @Sel4 = Sel4, @Sel5 = Sel5, @Sel6 = Sel6, @Sel7 = Sel7, @Sel8 = Sel8, @Sel9 = Sel9, @Sel10 = Sel10, @Sel11 = Sel11,
			@Sel12 = Sel12, @Sel13 = Sel13, @Sel14 = Sel14, @Sel15 = Sel15, @Sel16 = Sel16, @Sel17 = Sel17, @Sel18 = Sel18, @Sel19 = Sel19
		FROM  dbo.pSizeRange WITH (NOLOCK)
		WHERE SizeRangeCode = @SizeRange

		BEGIN
			INSERT INTO dbo.pPOMTemplate
				(POMTempID, POMTempGroupID, POMTempVersion, POMType, POMTypeDescription, SpecSketchID, SpecSketchVersion, SizeClass, SizeRange, CustomField1, 
				CustomField2, CustomField3, CustomField4, CustomField5, Sort, POMTempActive, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, 
				Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, CUser, CDate, MUser, MDate)
			SELECT @NewPOMTempID, @POMTempGroupID, POMTempVersion, POMType, POMTypeDescription, SpecSketchID, SpecSketchVersion, @SizeClass, @SizeRange, 
				CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, Sort, POMTempActive, @Size0, @Size1, @Size2, @Size3, @Size4, 
				@Size5, @Size6, @Size7, @Size8, @Size9, @Size10, @Size11, @Size12, @Size13, @Size14, @Size15, @Size16, @Size17, @Size18, @Size19, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
			FROM  dbo.pPOMTemplate WITH (NOLOCK)
			WHERE (POMTempID = @POMTempID)
		END
		
		IF (SELECT COUNT(*)  AS CountSizeRage FROM  dbo.pPOMTemplateGroup WITH (NOLOCK) WHERE  (POMTempID = @PomTempID) AND (SizeRange = @SizeRange))  = 0 
		BEGIN
				INSERT INTO dbo.pPOMTemplateGroup (POMTempGroupID, POMTempID, SizeRange, CUser, CDate, MUser, MDate)
				VALUES (@POMTempGroupID, @NewPOMTempID, @SizeRange, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
		END

		BEGIN
			SELECT IDENTITY(int, 1,1) AS ID_Num, POMTempItemID, POMTempID, POMTempGroupID, POMLibraryID, FitComID, Critical, POM, PointMeasur, HowToMeasurText, HowToMeasurImage, 
			TOL, TOLN, Spec, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19,
			CDate, CUser, MDate, MUser, Change, Sort, CopyPOMTempItemID
			INTO #TempPOMTempItemp FROM pPOMTemplateItem WITH (NOLOCK) WHERE POMTempID = @POMTempID 
			
			SET @rowCount = (SELECT COUNT(*) FROM #TempPOMTempItemp)
			
			WHILE @recCount <= @rowCount 
				BEGIN

				--SELECT @POMTempItemID = POMTempItemID FROM #TempPOMTempItemp WHERE ID_Num = @recCount

				INSERT INTO dbo.pPOMTemplateItem
					(POMTempID, POMTempGroupID, POMLibraryID, Critical, POM, PointMeasur, HowToMeasurText, HowToMeasurImage, TOL, TOLN, Spec, Grade0, 
					Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, 
					Grade17, Grade18, Grade19, CDate, CUser, MDate, MUser, Change, Sort, CopyPOMTempItemID)
				SELECT     @NewPOMTempID, @POMTempGroupID, POMLibraryID, Critical, POM, PointMeasur, HowToMeasurText, HowToMeasurImage, TOL, TOLN, Spec, 
					Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, 
					Grade16, Grade17, Grade18, Grade19, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy, Change, Sort, CopyPOMTempItemID
				FROM #TempPOMTempItemp
				WHERE ID_Num = @recCount
				
				SET @recCount = @recCount + 1
				END
		END
		
		
		SET NOCOUNT OFF
		RETURN

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09535', GetDate())
GO
