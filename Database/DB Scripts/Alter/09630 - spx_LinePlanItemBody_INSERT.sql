IF OBJECT_ID(N'[dbo].[spx_LinePlanItemBody_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanItemBody_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemBody_INSERT]
(
@LinePlanItemID nvarchar(50),
@LinePlanID nvarchar(50),
@StyleID nvarchar(50),
@BodyID nvarchar(50),
@CUser nvarchar(200),
@CDate datetime
)

AS 

--DECLARE @DesignSketchId AS nVARCHAR(40)
--DECLARE @DesignSketchVersion INT
DECLARE @POMTempID1 UNIQUEIDENTIFIER
DECLARE @POMTempID2 UNIQUEIDENTIFIER
DECLARE @POMTempID3 UNIQUEIDENTIFIER
DECLARE @POMTempID4 UNIQUEIDENTIFIER
DECLARE @SizeClass nVARCHAR(400)
DECLARE @SizeClassId UNIQUEIDENTIFIER
DECLARE @SizeRange nVARCHAR(200)
DECLARE @SizeRangeId UNIQUEIDENTIFIER

SELECT 
--	 @DesignSketchID = ImageID
--	,@DesignSketchVersion = ImageVersion, 
	@POMTempID1 = b.POMTempID1 
	,@POMTempID2 = b.POMTempID2 
	,@POMTempID3 = b.POMTempID3 
	,@POMTempID4 = b.POMTempID4 
	,@SizeClass = b.SizeClass
	,@SizeClassId = sc.CustomID
	,@SizeRange = b.SizeRange
	,@SizeRangeId = sr.CustomId
FROM pBody b
LEFT JOIN pSizeClass sc ON sc.Custom = b.SizeClass
LEFT JOIN pSizeRange sr ON sr.SizeRangeCode = b.SizeRange
WHERE b.BodyID = @BodyID

SELECT * FROM pBody

BEGIN
	UPDATE pStyleHeader SET
		BodyID = @BodyID,
		--DesignSketchID = @DesignSketchID,
		--DesignSketchVersion = @DesignSketchversion, 
		LinePlanID = @LinePlanID,
		LinePlanItemID = @LinePlanItemID,
		SizeClass = @SizeClass,
		SizeClassId = @SizeClassId,
		SizeRange = @SizeRange,
		SizeRangeId = @SizeRangeId,
		POMTempID1 = @POMTempID1,
		POMTempID2 = @POMTempID2,
 		POMTempID3 = @POMTempID3,
		POMTempID4 = @POMTempID4,
		POMTempVersion1 = 0,
		POMTempVersion2 = 0,
 		POMTempVersion3 = 0,
		POMTempVersion4 = 0
	WHERE StyleID = @StyleID
END

BEGIN
	DELETE FROM  pStyleSpec WHERE StyleID = @StyleID

	INSERT INTO pStyleSpec (StyleID, StyleSet, BodyID, BodySpecID, POMLibraryID, POMTempID, Critical, 
		POM, PointMeasur, TOL, TOLN, InitialSpec, 
		Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, 
		Proto19, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, 
		Grade17, Grade18, Grade19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, 
		Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, HowToMeasurText, HowToMeasurImage, Conv)
	SELECT @StyleID, BodySet, BodyID, SpecID, POMLibraryID, POMTempID, Critical,  
		POM, PointMeasur, TOL, TOLN, InitialSpec, 
		Spec, Proto0, Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto14, Proto15, Proto16, Proto17, Proto18, 
		Proto19, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, 
		Grade17, Grade18, Grade19, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, 
		Size18, Size19, CDate, CUser, MDate, MUser, Change, Sort, HowToMeasurText, HowToMeasurImage, Conv  
	FROM pBodySpec
	WHERE BodyID = @BodyID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09630', GetDate())
GO
