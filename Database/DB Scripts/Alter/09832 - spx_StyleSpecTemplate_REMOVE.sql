IF OBJECT_ID(N'[dbo].[spx_StyleSpecTemplate_REMOVE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSpecTemplate_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSpecTemplate_REMOVE]
(@StyleID uniqueidentifier,
@StyleSet int)
AS 

	
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

DECLARE @POMTempID uniqueidentifier
IF @StyleSet = 1 SET @POMTempID = (SELECT POMTempID1 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID)
IF @StyleSet = 2 SET @POMTempID = (SELECT POMTempID2 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID)
IF @StyleSet = 3 SET @POMTempID = (SELECT POMTempID3 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID)
IF @StyleSet = 4 SET @POMTempID = (SELECT POMTempID4 FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID)

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

select * from #tempStyleDevelopmentItem 


WHILE @RowStyleLoop <= @RowStyleCount 

BEGIN

	SELECT @tmpPOMTempID = POMTempID, @tmpStyleId = StyleID, @tmpSizeRange = SizeRange 
	FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop	
	SELECT @tmpPOMTempID, @tmpStyleID, @tmpSizeRange		


	IF (SELECT COUNT(*) AS CountTemplate FROM dbo.pStyleSpec WITH (NOLOCK) WHERE (StyleID = @tmpStyleID) AND (StyleSet = @StyleSet) AND (POMTempID = @tmpPOMTempID)) = 0
	BEGIN
		IF @StyleSet = 1 UPDATE pStyleHeader SET POMTempGroupID1 = NULL, POMTempID1 = NULL, POMTempVersion1 = 0 WHERE (StyleID = @tmpStyleID)  
		IF @StyleSet = 2 UPDATE pStyleHeader SET POMTempGroupID2 = NULL, POMTempID2 = NULL, POMTempVersion2 = 0 WHERE (StyleID = @tmpStyleID)  
		IF @StyleSet = 3 UPDATE pStyleHeader SET POMTempGroupID3 = NULL, POMTempID3 = NULL, POMTempVersion3 = 0 WHERE (StyleID = @tmpStyleID)  
		IF @StyleSet = 4 UPDATE pStyleHeader SET POMTempGroupID4 = NULL, POMTempID4 = NULL, POMTempVersion4 = 0 WHERE (StyleID = @tmpStyleID)  
	END

	SET @RowStyleLoop = @RowStyleLoop + 1
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09832', GetDate())
GO
