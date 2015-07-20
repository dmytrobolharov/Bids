IF OBJECT_ID(N'[dbo].[spx_StyleSpecLinkTemplate_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSpecLinkTemplate_UPDATE]
GO

CREATE  PROCEDURE [dbo].[spx_StyleSpecLinkTemplate_UPDATE]
(
@POMTempID uniqueidentifier, 
@StyleID uniqueidentifier,
@StyleSet nvarchar(5),
@ModifiedBy nvarchar(200),
@ModifiedDate datetime
)
AS 

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDevelopmentItemID]	uniqueidentifier NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
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
DECLARE @tmpSizeClass		varchar(400)
DECLARE @tmpSizeRange		varchar(200)
DECLARE @SpecMasterID		uniqueidentifier
DECLARE @tmpStyleVariation		int

DECLARE @POMTempGroupID	uniqueidentifier
DECLARE @POMTempVersion nvarchar(5)

SET @SpecMasterID = newid()

DECLARE @StyleDevelopmentId uniqueidentifier
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

BEGIN
	INSERT INTO #tempStyleDevelopmentItem
	      (StyleDevelopmentItemID, StyleDevelopmentID, StyleID, Variation, SizeClass, SizeRange)
	SELECT pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleDevelopmentItem.StyleDevelopmentID, 
	       pStyleDevelopmentItem.StyleID, pStyleDevelopmentItem.Variation, 
		   COALESCE(sc.Custom, sh.SizeClass), COALESCE(sr.SizeRangeCode, sh.SizeRange)
	FROM pStyleDevelopmentItem WITH (NOLOCK) 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pStyleDevelopmentItem.StyleID = sh.StyleID
    LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
    LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
	WHERE pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentId AND pStyleDevelopmentItem.Variation = @tmpStyleVariation
END

SELECT * FROM #tempStyleDevelopmentItem 

SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

WHILE @RowStyleLoop <= @RowStyleCount 

BEGIN

	SELECT * FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

	SELECT @tmpStyleID = StyleID, @tmpSizeClass = SizeClass, @tmpSizeRange = SizeRange FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

	SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempGroupID = @POMTempGroupID AND SizeRange = @tmpSizeRange AND SizeClass = @tmpSizeClass

	IF @StyleSet = 1 UPDATE pStyleHeader SET POMTempID1 = @POMTempID, POMTempVersion1 = @POMTempVersion WHERE (StyleID = @tmpStyleID)  
	IF @StyleSet = 2 UPDATE pStyleHeader SET POMTempID2 = @POMTempID, POMTempVersion2 = @POMTempVersion WHERE (StyleID = @tmpStyleID)  
	IF @StyleSet = 3 UPDATE pStyleHeader SET POMTempID3 = @POMTempID, POMTempVersion3 = @POMTempVersion WHERE (StyleID = @tmpStyleID)  
	IF @StyleSet = 4 UPDATE pStyleHeader SET POMTempID4 = @POMTempID, POMTempVersion4 = @POMTempVersion WHERE (StyleID = @tmpStyleID)  

	SET @RowStyleLoop = @RowStyleLoop + 1
	
END


/*
BEGIN

	DECLARE @POMTempVersion nvarchar(3), @SizeClass nvarchar(50), @SizeRange nvarchar(50)

	SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion, @SizeClass = SizeClass , @SizeRange = SizeRange  
	FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID 


	IF @StyleSet = 1 UPDATE pStyleHeader SET POMTempID1 = @POMTempID, POMTempVersion1 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	IF @StyleSet = 2 UPDATE pStyleHeader SET POMTempID2 = @POMTempID, POMTempVersion2 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	IF @StyleSet = 3 UPDATE pStyleHeader SET POMTempID3 = @POMTempID, POMTempVersion3 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	IF @StyleSet = 4 UPDATE pStyleHeader SET POMTempID4 = @POMTempID, POMTempVersion4 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  

	
END

*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09829', GetDate())
GO
