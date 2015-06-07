IF OBJECT_ID(N'[dbo].[spx_BodySpecTemplateTemp_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodySpecTemplateTemp_INSERT]
GO

CREATE  PROCEDURE [dbo].[spx_BodySpecTemplateTemp_INSERT] (
@POMTempID nvarchar(50),
@BodyID nvarchar(50),
@BodySet int,
@MUser nvarchar(50),
@MDate datetime
)
AS 

DECLARE @POMTempVersion nvarchar(5)
SET @POMTempVersion = (SELECT POMTempVersion FROM pPOMTemplate WHERE POMTempID = @POMTempID)

CREATE TABLE [#tempBodyDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[DevelopmentItemID]	uniqueidentifier NULL,
	[DevelopmentID]    	uniqueidentifier NULL,
	[POMTempID]               	uniqueidentifier NULL,
	[BodyID]               	uniqueidentifier NULL,
	[SizeClass]             	nvarchar(400) NULL,
	[SizeRange]             	nvarchar(200) NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
)

DECLARE @RowBodyLoop 		int
DECLARE @RowBodyCount 		int
DECLARE @tmpBodyID		uniqueidentifier
DECLARE @tmpPOMTempID		uniqueidentifier
DECLARE @tmpSizeClass		nvarchar(400)
DECLARE @tmpSizeRange		nvarchar(200)
DECLARE @SpecMasterID		uniqueidentifier
DECLARE @POMTempGroupID		uniqueidentifier

DECLARE @newSizeRange		nvarchar(400)
DECLARE @newSizeClass		nvarchar(200)

SET @SpecMasterID = newid()

DECLARE @DevelopmentId uniqueidentifier
SELECT @DevelopmentId = DevelopmentId FROM pBody WHERE BodyId = @BodyId

SELECT @POMTempGroupID = POMTempGroupID, @newSizeClass = SizeClass, @newSizeRange = SizeRange FROM pPOMTemplate WHERE (POMTempID = @POMTempID)

BEGIN

		INSERT INTO [#tempBodyDevelopmentItem]
		      (DevelopmentItemID, DevelopmentID, BodyID, SizeClass, SizeRange, POMTempID)
		SELECT  a.BodyDevelopmentItemID, a.BodyDevelopmentID, a.BodyID, 
		      b.SizeClass, b.SizeRange, b.POMTempID
		FROM  pBodyDevelopmentItem a INNER JOIN pBody c ON a.BodyID = c.BodyID 
		INNER JOIN  pPOMTemplate b ON c.SizeClass = b.SizeClass AND  c.SizeRange = b.SizeRange
		WHERE BodyDevelopmentID = @DevelopmentID 
		AND b.POMTempGroupID = @POMTempGroupID

END

SET @RowBodyLoop = 1
SET @RowBodyCount = (SELECT COUNT(*) FROM #tempBodyDevelopmentItem)


WHILE @RowBodyLoop <= @RowBodyCount 

BEGIN

	SELECT @tmpPOMTempID = POMTempID, @tmpBodyId = BodyID, @tmpSizeRange = SizeRange 
	FROM #tempBodyDevelopmentItem WHERE RecID = @RowBodyLoop	

	BEGIN
		INSERT INTO pBodySpec
			(BodyID, BodySet, POMLibraryID, POMTempID, Critical, POM, PointMeasur, TOLN, TOL, Spec, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, 
			Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, Grade19, Change, Proto0, 
			Proto1, Proto2, Proto3, Proto4, Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Proto12, Proto13, Proto19, Proto18, Proto17, Proto16, Proto15, 
			Proto14, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size19, Size18,
			Size17, HowToMeasurText, HowToMeasurImage, Sort, CDate, CUser, MDate, MUser)
		SELECT @tmpBodyID AS BodyID, @BodySet AS BodySet, POMLibraryID, POMTempID, Critical, POM, PointMeasur, TOLN, TOL, Spec, Grade0, Grade1, Grade2, 
			Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, Grade11, Grade12, Grade13, Grade14, Grade15, Grade16, Grade17, Grade18, 
			Grade19, Change, Spec AS Proto0, Spec AS Proto1, Spec AS Proto2, Spec AS Proto3, Spec AS Proto4, Spec AS Proto5, Spec AS Proto6, Spec AS Proto7, 
			Spec AS Proto8, Spec AS Proto9, Spec AS Proto10, Spec AS Proto11, Spec AS Proto12, Spec AS Proto13, Spec AS Proto19, Spec AS Proto18, 
			Spec AS Proto17, Spec AS Proto16, Spec AS Proto15, Spec AS Proto14, 0 AS Size0, 0 AS Size1, 0 AS Size2, 0 AS Size3, 0 AS Size4, 0 AS Size5, 
			0 AS Size6, 0 AS Size7, 0 AS Size8, 0 AS Size9, 0 AS Size10, 0 AS Size11, 0 AS Size12, 0 AS Size13, 0 AS Size14, 0 AS Size15, 0 AS Size16, 
			0 AS Size19, 0 AS Size18, 0 AS Size17, HowToMeasurText, HowToMeasurImage, Sort, CDate, CUser, @MDate AS MDate,  @MUser AS MUser 
		FROM  pPOMTemplateItem
		WHERE (POMTempID = @tmpPOMTempID) AND 
			POM NOT IN (SELECT POM FROM pBodySpec WHERE BodyID = @tmpBodyID AND BodySet = @BodySet) AND 
			POM IN (SELECT DISTINCT POM FROM pPOMTemplateItemTemp WHERE POMTempID = @POMTempID)
	END
	
	SET @RowBodyLoop = @RowBodyLoop + 1
	
END


BEGIN
	DELETE FROM pPOMTemplateItemTemp WHERE (POMTempID = @tmpPOMTempID)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09522', GetDate())
GO
