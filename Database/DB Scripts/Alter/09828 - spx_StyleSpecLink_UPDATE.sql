IF OBJECT_ID(N'[dbo].[spx_StyleSpecLink_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSpecLink_UPDATE]
GO

CREATE    PROCEDURE [dbo].[spx_StyleSpecLink_UPDATE]
(@StyleID uniqueidentifier,
@StyleSet int,
@POMTempID uniqueidentifier)
AS 
	
	--DECLARE @StyleID			uniqueidentifier
	--DECLARE @StyleSet			int
	--DECLARE @POM				nvarchar(5)
	DECLARE @POMTempGroupID		uniqueidentifier
	
	
	--SELECT @StyleID = StyleID, @StyleSet = StyleSet, @POM = POM FROM pStyleSpec WITH (NOLOCK) WHERE SpecID = @SpecID
	
	BEGIN

	CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDevelopmentItemID]	uniqueidentifier NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
	[StyleID]               	uniqueidentifier NULL,
	[SizeClass]             	nvarchar(400) NULL,
	[SizeRange]             	nvarchar(200) NULL,
	[Variation]             	int NULL,
	[POMTempID]    				uniqueidentifier NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
	)

	DECLARE @RowStyleLoop 			int
	DECLARE @RowStyleCount 			int
	DECLARE @tmpStyleID				uniqueidentifier
	DECLARE @SpecMasterID			uniqueidentifier
	DECLARE @tmpPOMTempID				uniqueidentifier
	DECLARE @tmpStyleVariation		int

	SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID

	DECLARE @StyleDevelopmentId uniqueidentifier
	SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

	BEGIN
	
		DECLARE @POMTempVersion nvarchar(3), @SizeClass nvarchar(400), @SizeRange nvarchar(200)
	
		SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion, @SizeClass = SizeClass , @SizeRange = SizeRange  
		FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempID = @POMTempID 
	
	
		IF @StyleSet = 1 UPDATE pStyleHeader SET POMTempID1 = @POMTempID, POMTempVersion1 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
		IF @StyleSet = 2 UPDATE pStyleHeader SET POMTempID2 = @POMTempID, POMTempVersion2 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
		IF @StyleSet = 3 UPDATE pStyleHeader SET POMTempID3 = @POMTempID, POMTempVersion3 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
		IF @StyleSet = 4 UPDATE pStyleHeader SET POMTempID4 = @POMTempID, POMTempVersion4 = @POMTempVersion, SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (StyleID = @StyleID)  
	
		
	END


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

	SELECT * FROM #tempStyleDevelopmentItem

	SET @RowStyleLoop = 1
	SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

	BEGIN
		SET @SpecMasterID = newid()
	END

	WHILE @RowStyleLoop <= @RowStyleCount 

		BEGIN

			SELECT @tmpStyleID = StyleID, @tmpPOMTempID = POMTempID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

					BEGIN
					UPDATE pStyleSpec SET   
					  pStyleSpec.POMTempID = @tmpPOMTempID,	
					  pStyleSpec.POMTempItemID = pPOMTemplateItem.POMTempItemID,	
                      pStyleSpec.TOL = pPOMTemplateItem.TOL, 
                      pStyleSpec.TOLN = pPOMTemplateItem.TOLN, 
					  pStyleSpec.Grade0 = pPOMTemplateItem.Grade0, 
                      pStyleSpec.Grade1 = pPOMTemplateItem.Grade1, 
                      pStyleSpec.Grade2 = pPOMTemplateItem.Grade2, 
                      pStyleSpec.Grade3 = pPOMTemplateItem.Grade3, 
                      pStyleSpec.Grade4 = pPOMTemplateItem.Grade4, 
                      pStyleSpec.Grade5 = pPOMTemplateItem.Grade5, 
                      pStyleSpec.Grade6 = pPOMTemplateItem.Grade6, 
                      pStyleSpec.Grade7 = pPOMTemplateItem.Grade7, 
                      pStyleSpec.Grade8 = pPOMTemplateItem.Grade8, 
                      pStyleSpec.Grade9 = pPOMTemplateItem.Grade9, 
                      pStyleSpec.Grade10 = pPOMTemplateItem.Grade10, 
                      pStyleSpec.Grade11 = pPOMTemplateItem.Grade11, 
                      pStyleSpec.Grade12 = pPOMTemplateItem.Grade12, 
                      pStyleSpec.Grade13 = pPOMTemplateItem.Grade13, 
                      pStyleSpec.Grade14 = pPOMTemplateItem.Grade14, 
                      pStyleSpec.Grade15 = pPOMTemplateItem.Grade15, 
                      pStyleSpec.Grade16 = pPOMTemplateItem.Grade16, 
					  pStyleSpec.Grade17 = pPOMTemplateItem.Grade17, 
					  pStyleSpec.Grade18 = pPOMTemplateItem.Grade18, 
                      pStyleSpec.Grade19 = pPOMTemplateItem.Grade19--, 
                      --pStyleSpec.Sort = pPOMTemplateItem.Sort  (Remove re-sorting upon re-linking)
					FROM pPOMTemplateItem INNER JOIN
						pStyleSpec ON pPOMTemplateItem.POM = pStyleSpec.POM AND
						pPOMTemplateItem.PointMeasur = pStyleSpec.PointMeasur
					WHERE 
						(pStyleSpec.StyleID = @tmpStyleID) AND 
						(pStyleSpec.StyleSet = @StyleSet) AND
						(pPOMTemplateItem.POMTempID = @tmpPOMTempID)
					END
					
					
					IF @StyleID = @tmpStyleID
					BEGIN
					UPDATE pSampleRequestSpecItem SET   
					  pSampleRequestSpecItem.POMTempID = @tmpPOMTempID,	
					  pSampleRequestSpecItem.POMTempItemID = pPOMTemplateItem.POMTempItemID,	
                      pSampleRequestSpecItem.TOL = pPOMTemplateItem.TOL, 
                      pSampleRequestSpecItem.TOLN = pPOMTemplateItem.TOLN, 
                      pSampleRequestSpecItem.Grade0 = pPOMTemplateItem.Grade0, 
                      pSampleRequestSpecItem.Grade1 = pPOMTemplateItem.Grade1, 
                      pSampleRequestSpecItem.Grade2 = pPOMTemplateItem.Grade2, 
                      pSampleRequestSpecItem.Grade3 = pPOMTemplateItem.Grade3, 
                      pSampleRequestSpecItem.Grade4 = pPOMTemplateItem.Grade4, 
                      pSampleRequestSpecItem.Grade5 = pPOMTemplateItem.Grade5, 
                      pSampleRequestSpecItem.Grade6 = pPOMTemplateItem.Grade6, 
                      pSampleRequestSpecItem.Grade7 = pPOMTemplateItem.Grade7, 
                      pSampleRequestSpecItem.Grade8 = pPOMTemplateItem.Grade8, 
                      pSampleRequestSpecItem.Grade9 = pPOMTemplateItem.Grade9, 
                      pSampleRequestSpecItem.Grade10 = pPOMTemplateItem.Grade10, 
                      pSampleRequestSpecItem.Grade11 = pPOMTemplateItem.Grade11, 
                      pSampleRequestSpecItem.Grade12 = pPOMTemplateItem.Grade12, 
                      pSampleRequestSpecItem.Grade13 = pPOMTemplateItem.Grade13, 
                      pSampleRequestSpecItem.Grade14 = pPOMTemplateItem.Grade14, 
                      pSampleRequestSpecItem.Grade15 = pPOMTemplateItem.Grade15, 
                      pSampleRequestSpecItem.Grade16 = pPOMTemplateItem.Grade16, 
					  pSampleRequestSpecItem.Grade17 = pPOMTemplateItem.Grade17, 
					  pSampleRequestSpecItem.Grade18 = pPOMTemplateItem.Grade18, 
                      pSampleRequestSpecItem.Grade19 = pPOMTemplateItem.Grade19--, 
                      --pSampleRequestSpecItem.Sort = pPOMTemplateItem.Sort  (Remove re-sorting upon re-linking)
					FROM pPOMTemplateItem INNER JOIN
						pSampleRequestSpecItem ON pPOMTemplateItem.POM = pSampleRequestSpecItem.POM AND
						pPOMTemplateItem.PointMeasur = pSampleRequestSpecItem.PointMeasur
					WHERE 
						(pSampleRequestSpecItem.StyleID = @tmpStyleID) AND 
						(pSampleRequestSpecItem.StyleSet = @StyleSet) AND
						(pPOMTemplateItem.POMTempID = @tmpPOMTempID)
					END
					

			SET @RowStyleLoop = @RowStyleLoop + 1
			
		END					

	END
							
	/*	
	BEGIN
	
		SELECT 'Linked : (' + POM + ') ' + PointMeasur  FROM pStyleSpec WITH (NOLOCK) WHERE (SpecID = @SpecID) 

	END	
	*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09828', GetDate())
GO
