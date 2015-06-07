IF OBJECT_ID(N'[dbo].[spx_BodySpecLinkTemplate_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodySpecLinkTemplate_UPDATE]
GO

create PROCEDURE [dbo].[spx_BodySpecLinkTemplate_UPDATE] (
@POMTempID uniqueidentifier, 
@BodyID uniqueidentifier,
@BodySet nvarchar(5),
@ModifiedBy nvarchar(200),
@ModifiedDate datetime
)
AS 

CREATE TABLE [#tempBodyDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[DevelopmentItemID]	uniqueidentifier NULL,
	[DevelopmentID]    	uniqueidentifier NULL,
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
DECLARE @tmpSizeClass		varchar(400)
DECLARE @tmpSizeRange		varchar(200)
DECLARE @SpecMasterID		uniqueidentifier


DECLARE @POMTempGroupID	uniqueidentifier
DECLARE @POMTempVersion nvarchar(5)

SET @SpecMasterID = newid()

DECLARE @DevelopmentID uniqueidentifier
SELECT @DevelopmentID = DevelopmentID FROM pBody WHERE BodyId = @BodyId

BEGIN
	INSERT INTO #tempBodyDevelopmentItem
	      (DevelopmentItemID, DevelopmentID, BodyID,  SizeClass, SizeRange)
	SELECT  a.BodyDevelopmentItemID, a.BodyDevelopmentID, a.BodyID, 
	b.SizeClass, b.SizeRange
	FROM pBodyDevelopmentItem a INNER JOIN pBody b ON a.BodyID= b.BodyID
	WHERE a.BodyDevelopmentID = @DevelopmentID 
END

--SELECT * FROM #tempStyleDevelopmentItem 

SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WHERE POMTempID = @POMTempID

SET @RowBodyLoop = 1
SET @RowBodyCount = (SELECT COUNT(*) FROM #tempBodyDevelopmentItem)

WHILE @RowBodyLoop <= @RowBodyCount 
BEGIN

	--SELECT * FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

	SELECT @tmpBodyID = BodyID, @tmpSizeClass = SizeClass, @tmpSizeRange = SizeRange FROM #tempBodyDevelopmentItem WHERE RecID = @RowBodyLoop

	SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion 
	FROM pPOMTemplate 
	WHERE POMTempGroupID = @POMTempGroupID AND SizeRange = @tmpSizeRange AND SizeClass = @tmpSizeClass


	IF @BodySet = 1 UPDATE pBody SET POMTempID1 = @POMTempID WHERE BodyID = @tmpBodyID 
	IF @BodySet = 2 UPDATE pBody SET POMTempID2 = @POMTempID WHERE BodyID = @tmpBodyID 
	IF @BodySet = 3 UPDATE pBody SET POMTempID3 = @POMTempID WHERE BodyID = @tmpBodyID 
	IF @BodySet = 4 UPDATE pBody SET POMTempID4 = @POMTempID WHERE BodyID = @tmpBodyID 

	SET @RowBodyLoop = @RowBodyLoop + 1
	
END


/*
BEGIN

	DECLARE @POMTempVersion nvarchar(3), @SizeClass nvarchar(50), @SizeRange nvarchar(50)

	SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion, @SizeClass = SizeClass , @SizeRange = SizeRange  
	FROM pPOMTemplate WHERE POMTempID = @POMTempID 


	IF @StyleSet = 1 UPDATE pStyleHeader SET POMTempID1 = @POMTempID, POMTempVersion1 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	IF @StyleSet = 2 UPDATE pStyleHeader SET POMTempID2 = @POMTempID, POMTempVersion2 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	IF @StyleSet = 3 UPDATE pStyleHeader SET POMTempID3 = @POMTempID, POMTempVersion3 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	IF @StyleSet = 4 UPDATE pStyleHeader SET POMTempID4 = @POMTempID, POMTempVersion4 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  

	
END

*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09627', GetDate())
GO
