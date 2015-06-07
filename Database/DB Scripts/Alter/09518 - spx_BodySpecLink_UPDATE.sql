IF OBJECT_ID(N'[dbo].[spx_BodySpecLink_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodySpecLink_UPDATE]
GO

create PROCEDURE [dbo].[spx_BodySpecLink_UPDATE] (
@BodyID uniqueidentifier,
@BodySet int,
@POMTempID uniqueidentifier)
AS 
	

	DECLARE @POMTempGroupID		uniqueidentifier
	
	
	BEGIN

	CREATE TABLE [#tempDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[DevelopmentItemID]	uniqueidentifier NULL,
	[DevelopmentID]    	uniqueidentifier NULL,
	[BodyID]               	uniqueidentifier NULL,
	[SizeClass]             	nvarchar(400) NULL,
	[SizeRange]             	nvarchar(200) NULL,
	[POMTempID]    				uniqueidentifier NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
	)

	DECLARE @RowLoop 			int
	DECLARE @RowCount 			int
	DECLARE @tmpBodyID				uniqueidentifier
	DECLARE @SpecMasterID			uniqueidentifier
	DECLARE @tmpPOMTempID				uniqueidentifier
	

	SELECT @POMTempGroupID = POMTempGroupID FROM pPOMTemplate WHERE POMTempID = @POMTempID

	DECLARE @DevelopmentId uniqueidentifier
	SELECT @DevelopmentID = DevelopmentId FROM pBody WHERE BodyID = @BodyID

	BEGIN
	
		DECLARE @POMTempVersion nvarchar(3), @SizeClass nvarchar(400), @SizeRange nvarchar(200)
	
		SELECT @POMTempID = POMTempID, @POMTempVersion = POMTempVersion, @SizeClass = SizeClass , @SizeRange = SizeRange  
		FROM pPOMTemplate WHERE POMTempID = @POMTempID 
	
	
		IF @BodySet = 1 UPDATE pBody SET POMTempID1 = @POMTempID,  SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (BodyID = @BodyID)  
		IF @BodySet = 2 UPDATE pBody SET POMTempID2 = @POMTempID,  SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (BodyID = @BodyID)  
		IF @BodySet = 3 UPDATE pBody SET POMTempID3 = @POMTempID,  SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (BodyID = @BodyID)  
		IF @BodySet = 4 UPDATE pBody SET POMTempID4 = @POMTempID,  SizeClass = @SizeClass, SizeRange = @SizeRange WHERE (BodyID = @BodyID)  
		
	END


	BEGIN
		INSERT INTO [#tempDevelopmentItem]
		      (DevelopmentItemID, DevelopmentID, BodyID, SizeClass, SizeRange,  POMTempID)
		SELECT  a.BodyDevelopmentItemID, a.BodyDevelopmentID, a.BodyID, 
		      c.SizeClass, c.SizeRange, c.POMTempID
		FROM  pBodyDevelopmentItem  a INNER JOIN pBody b ON a.BodyID = b.BodyID 
		INNER JOIN pPOMTemplate c ON b.SizeClass = c.SizeClass AND b.SizeRange = c.SizeRange
		WHERE a.BodyDevelopmentID = @DevelopmentID 
		AND c.POMTempGroupID = @POMTempGroupID
		
	END

	SELECT * FROM #tempDevelopmentItem

	SET @RowLoop = 1
	SET @RowCount = (SELECT COUNT(*) FROM #tempDevelopmentItem)

	BEGIN
		SET @SpecMasterID = newid()
	END

	WHILE @RowLoop <= @RowCount 

		BEGIN

			SELECT @tmpBodyID = BodyID, @tmpPOMTempID = POMTempID FROM #tempDevelopmentItem WHERE RecID = @RowLoop

					BEGIN
					UPDATE pBodySpec SET   
					  pBodySpec.POMTempID = @tmpPOMTempID,	
					  pBodySpec.POMTempItemID = pPOMTemplateItem.POMTempItemID,	
                      pBodySpec.TOL = pPOMTemplateItem.TOL, 
                      pBodySpec.TOLN = pPOMTemplateItem.TOLN, 
					  pBodySpec.Grade0 = pPOMTemplateItem.Grade0, 
                      pBodySpec.Grade1 = pPOMTemplateItem.Grade1, 
                      pBodySpec.Grade2 = pPOMTemplateItem.Grade2, 
                      pBodySpec.Grade3 = pPOMTemplateItem.Grade3, 
                      pBodySpec.Grade4 = pPOMTemplateItem.Grade4, 
                      pBodySpec.Grade5 = pPOMTemplateItem.Grade5, 
                      pBodySpec.Grade6 = pPOMTemplateItem.Grade6, 
                      pBodySpec.Grade7 = pPOMTemplateItem.Grade7, 
                      pBodySpec.Grade8 = pPOMTemplateItem.Grade8, 
                      pBodySpec.Grade9 = pPOMTemplateItem.Grade9, 
                      pBodySpec.Grade10 = pPOMTemplateItem.Grade10, 
                      pBodySpec.Grade11 = pPOMTemplateItem.Grade11, 
                      pBodySpec.Grade12 = pPOMTemplateItem.Grade12, 
                      pBodySpec.Grade13 = pPOMTemplateItem.Grade13, 
                      pBodySpec.Grade14 = pPOMTemplateItem.Grade14, 
                      pBodySpec.Grade15 = pPOMTemplateItem.Grade15, 
                      pBodySpec.Grade16 = pPOMTemplateItem.Grade16, 
					  pBodySpec.Grade17 = pPOMTemplateItem.Grade17, 
					  pBodySpec.Grade18 = pPOMTemplateItem.Grade18, 
                      pBodySpec.Grade19 = pPOMTemplateItem.Grade19--, 
                      --pStyleSpec.Sort = pPOMTemplateItem.Sort  (Remove re-sorting upon re-linking)
					FROM pPOMTemplateItem INNER JOIN
						pBodySpec ON pPOMTemplateItem.POM = pBodySpec.POM AND
						pPOMTemplateItem.PointMeasur = pBodySpec.PointMeasur
					WHERE 
						(pBodySpec.BodyID = @tmpBodyID) AND 
						(pBodySpec.BodySet = @BodySet) AND
						(pPOMTemplateItem.POMTempID = @tmpPOMTempID)
					END
					

					-- NO SAMPLE 
					/*					

					IF @BodyID = @tmpBodyID
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
					*/

			SET @RowLoop = @RowLoop + 1
			
		END					

	END
							
	/*	
	BEGIN
	
		SELECT 'Linked : (' + POM + ') ' + PointMeasur  FROM pStyleSpec WHERE (SpecID = @SpecID) 

	END	
	*/

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09518', GetDate())
GO
