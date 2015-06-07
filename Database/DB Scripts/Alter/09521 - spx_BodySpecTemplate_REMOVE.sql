IF OBJECT_ID(N'[dbo].[spx_BodySpecTemplate_REMOVE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodySpecTemplate_REMOVE]
GO

create PROCEDURE [dbo].[spx_BodySpecTemplate_REMOVE] (
@BodyID uniqueidentifier,
@BodySet int)
AS 

	
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

DECLARE @POMTempID uniqueidentifier
IF @BodySet = 1 SET @POMTempID = (SELECT POMTempID1 FROM pBody WHERE BodyID = @BodyID)
IF @BodySet = 2 SET @POMTempID = (SELECT POMTempID2 FROM pBody WHERE BodyID = @BodyID)
IF @BodySet = 3 SET @POMTempID = (SELECT POMTempID3 FROM pBody WHERE BodyID = @BodyID)
IF @BodySet = 4 SET @POMTempID = (SELECT POMTempID4 FROM pBody WHERE BodyID = @BodyID)

DECLARE @DevelopmentId uniqueidentifier
SELECT @DevelopmentId = DevelopmentId FROM pBody WHERE BodyId = @BodyId


SELECT @POMTempGroupID = POMTempGroupID, @newSizeClass = SizeClass, @newSizeRange = SizeRange FROM pPOMTemplate WHERE (POMTempID = @POMTempID)

BEGIN

		INSERT INTO [#tempBodyDevelopmentItem]
		      (DevelopmentItemID, DevelopmentID, BodyID, SizeClass, SizeRange,  POMTempID)
		SELECT  a.BodyDevelopmentItemID, a.BodyDevelopmentID, a.BodyID, 
		      b.SizeClass, b.SizeRange, b.POMTempID
		FROM  pBodyDevelopmentItem a INNER JOIN pBody c ON a.BodyID = c.BodyID 
		INNER JOIN  pPOMTemplate b ON c.SizeClass = b.SizeClass AND   c.SizeRange = b.SizeRange
		WHERE BodyDevelopmentID = @DevelopmentId 
		AND b.POMTempGroupID = @POMTempGroupID

END

SET @RowBodyLoop = 1
SET @RowBodyCount = (SELECT COUNT(*) FROM #tempBodyDevelopmentItem)

--select * from #tempBodyDevelopmentItem 


WHILE @RowBodyLoop <= @RowBodyCount 

BEGIN

	SELECT @tmpPOMTempID = POMTempID, @tmpBodyId = BodyID, @tmpSizeRange = SizeRange 
	FROM #tempBodyDevelopmentItem WHERE RecID = @RowBodyLoop	
	
	--SELECT @tmpPOMTempID, @tmpBodyID, @tmpSizeRange		


	IF (SELECT COUNT(*) AS CountTemplate FROM dbo.pBodySpec WHERE (BodyID = @tmpBodyID) AND (BodySet = @BodySet) AND (POMTempID = @tmpPOMTempID)) = 0
	BEGIN
		IF @BodySet = 1 UPDATE pBody SET POMTempID1 = NULL WHERE BodyID = @tmpBodyID
		IF @BodySet = 2 UPDATE pBody SET POMTempID2 = NULL WHERE BodyID = @tmpBodyID
		IF @BodySet = 3 UPDATE pBody SET POMTempID3 = NULL WHERE BodyID = @tmpBodyID
		IF @BodySet = 4 UPDATE pBody SET POMTempID4 = NULL WHERE BodyID = @tmpBodyID
	END

	SET @RowBodyLoop = @RowBodyLoop + 1
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09521', GetDate())
GO
