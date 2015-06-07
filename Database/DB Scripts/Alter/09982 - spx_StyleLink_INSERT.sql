IF OBJECT_ID(N'[dbo].[spx_StyleLink_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleLink_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleLink_INSERT]

	(
		@StyleID nvarchar(50),
		@NewStyleID nvarchar(50),
		@PomTempId nvarchar(50),
		@CreatedBy nvarchar(200),
		@StyleSpecConversion nvarchar(10),
		@CreatedDate datetime	
	)

AS
	SET NOCOUNT ON 

DECLARE @SizeRangeId nvarchar(50)
DECLARE @SizeClassId nvarchar(50)

 
SELECT @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId 
FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempId = @POMTempId

SELECT * FROM pPOMTemplate WITH (NOLOCK) WHERE POMTempId = @POMTempId

	EXEC('spx_StyleHeaderLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @SizeClassId + ''',''' + @SizeRangeId + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleMaterialLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleImageItemLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleCareCopy_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleCostingCopy_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleDevelopmentSpecLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @SizeClassId + ''',''' + @SizeRangeId + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleSpecSize_SELECT ''' + @NewStyleID + '''')


	if @StyleSpecConversion = 'TRUE'
	BEGIN
	
		IF (SELECT TOP 1 SpecConversion FROM pSizeClass WITH (NOLOCK) WHERE (Custom IN (SELECT SizeClass FROM  pStyleHeader WITH (NOLOCK) WHERE Styleid = @StyleId))) = 1
	
		BEGIN
			UPDATE pStyleSpec SET Spec = 0 WHERE StyleId  = @NewStyleID 
		
			UPDATE pStyleSpec SET pStyleSpec.Spec = pStyleSpec_1.Spec 
			FROM pStyleSpec INNER JOIN
			pStyleSpec pStyleSpec_1 ON pStyleSpec.POM = pStyleSpec_1.POM AND pStyleSpec.StyleSet = pStyleSpec_1.StyleSet
			WHERE     (pStyleSpec.StyleID = @NewStyleId) AND (pStyleSpec_1.StyleID = @StyleId) AND (pStyleSpec_1.POMTempID IS NOT NULL)

			UPDATE pStyleSpec SET pStyleSpec.Spec = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pStyleSpec.Conv,0))
			FROM   pStyleSpec INNER JOIN
			pPOMTemplateItem ON pStyleSpec.POM = pPOMTemplateItem.POM
			WHERE pStyleSpec.StyleId  = @NewStyleId AND pStyleSpec.StyleSet = '1' AND 
			pPOMTemplateItem.POMTempID IN (SELECT POMtempId FROM pPOMTemplateItem WITH (NOLOCK) WHERE (POMTempID IN (SELECT PomTempId1 FROM  pStyleHeader WITH (NOLOCK) WHERE Styleid = @StyleId))) AND
			(pStyleSpec.Spec <> 0 AND pStyleSpec.Spec IS NOT NULL)
		END
	
	END


RETURN

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09982', GetUTCDate())
GO
