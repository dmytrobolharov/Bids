IF OBJECT_ID(N'[dbo].[spx_StyleSpecTemplateTemp_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSpecTemplateTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSpecTemplateTemp_INSERT]
(
@POMTempID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@ModifiedDate nvarchar(50),
@ModifiedBy nvarchar(50)
)
AS 

DECLARE @POMTempVersion nvarchar(5)
SET @POMTempVersion = (SELECT POMTempVersion FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID)

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDevelopmentItemID]	uniqueidentifier NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
	[POMTempID]               	uniqueidentifier NULL,
	[StyleID]               	uniqueidentifier NULL,
	[SizeClass]             	nvarchar(400) NULL,
	[SizeRange]             	nvarchar(200) NULL,
	[Variation]             	int NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
)

DECLARE @RowStyleLoop 		int
DECLARE @RowStyleCount 		int
DECLARE @tmpStyleID		uniqueidentifier
DECLARE @tmpPOMTempID		uniqueidentifier
DECLARE @tmpSizeClass		nvarchar(400)
DECLARE @tmpSizeRange		nvarchar(200)
DECLARE @SpecMasterID		uniqueidentifier
DECLARE @tmpStyleVariation	int
DECLARE @POMTempGroupID		uniqueidentifier

DECLARE @newSizeRange		nvarchar(400)
DECLARE @newSizeClass		nvarchar(200)

SET @SpecMasterID = newid()

DECLARE @StyleDevelopmentId uniqueidentifier
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

SELECT @POMTempGroupID = POMTempGroupID, @newSizeClass = SizeClass, @newSizeRange = SizeRange FROM pPOMTemplate WITH (NOLOCK) WHERE (POMTempID = @POMTempID)

BEGIN

		INSERT INTO [#tempStyleDevelopmentItem]
		      (StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeClass, SizeRange, Variation, POMTempID)
		SELECT  pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleDevelopmentItem.StyleDevelopmentID, pStyleDevelopmentItem.StyleID, 
		      pPOMTemplate.SizeClass, pPOMTemplate.SizeRange, pStyleDevelopmentItem.Variation, pPOMTemplate.POMTempID
		FROM  pStyleDevelopmentItem WITH (NOLOCK) INNER JOIN
		      pStyleHeader WITH (NOLOCK) ON pStyleDevelopmentItem.StyleID = pStyleHeader.StyleID INNER JOIN
		      pPOMTemplate WITH (NOLOCK) ON pStyleHeader.SizeClass = pPOMTemplate.SizeClass AND 
		      pStyleHeader.SizeRange = pPOMTemplate.SizeRange
		WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
		AND pPOMTemplate.POMTempGroupID = @POMTempGroupID

END

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)


WHILE @RowStyleLoop <= @RowStyleCount 

BEGIN

	SELECT @tmpPOMTempID = POMTempID, @tmpStyleId = StyleID, @tmpSizeRange = SizeRange 
	FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop	

	BEGIN
		INSERT INTO pStyleSpec
			(StyleID, StyleSet, POMLibraryID, POMTempID, Critical, POM, PointMeasur, TOLN, TOL, Spec, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, 
			Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Change, Proto0, 
			Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto19, Proto18, Proto17, Proto16, Proto15, 
			Proto14, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size19, Size18,
			Size17, HowToMeasurText, HowToMeasurImage, Sort, CDate, CUser, MDate, MUser)
		SELECT @tmpStyleID AS StyleID, @StyleSet AS StyleSet, POMLibraryID, POMTempID, Critical, POM, PointMeasur, TOLN, TOL, Spec, Grade0, Grade1, Grade2, 
			Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, 
			Grade19, Change, Spec AS Proto0, Spec AS Proto1, Spec AS Proto2, Spec AS Proto3, Spec AS Proto4, Spec AS Proto5, Spec AS Proto6, Spec AS Proto7, 
			Spec AS Proto8, Spec AS Proto9, Spec AS Proto10, Spec AS Proto11, Spec AS Proto12, Spec AS Proto13, Spec AS Proto19, Spec AS Proto18, 
			Spec AS Proto17, Spec AS Proto16, Spec AS Proto15, Spec AS Proto14, 0 AS Size0, 0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 
			0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11, 0 AS Size12, 0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 
			0 AS Size19, 0 AS Size18, 0 AS Size17, HowToMeasurText, HowToMeasurImage, Sort, CDate, CUser, @ModifiedDate AS MUser, 
			@ModifiedBy AS MDate
		FROM  pPOMTemplateItem WITH (NOLOCK)
		WHERE (POMTempID = @tmpPOMTempID) AND 
			POM NOT IN (SELECT POM FROM pStyleSpec WITH (NOLOCK) WHERE StyleID = @tmpStyleID AND StyleSet = @StyleSet) AND 
			POM IN (SELECT DISTINCT POM FROM pPOMTemplateItemTemp WITH (NOLOCK) WHERE POMTempID = @POMTempID)
	END
	
	SET @RowStyleLoop = @RowStyleLoop + 1
	
END


BEGIN
	DELETE FROM pPOMTemplateItemTemp WHERE (POMTempID = @tmpPOMTempID)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09833', GetDate())
GO
