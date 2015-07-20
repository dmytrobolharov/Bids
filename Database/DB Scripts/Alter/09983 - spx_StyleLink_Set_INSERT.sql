IF OBJECT_ID(N'[dbo].[spx_StyleLink_Set_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleLink_Set_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleLink_Set_INSERT](
	@StyleID nvarchar(50),
	@NewStyleID nvarchar(50),
	@StyleSet INT ,
	@PomTempId nvarchar(50),
	@CreatedBy nvarchar(200),
	@StyleSpecConversion nvarchar(10),
	@CreatedDate datetime	
)
AS

SET NOCOUNT ON 

DECLARE @SizeRangeId nvarchar(100)
DECLARE @SizeClassId nvarchar(100)
 
SELECT @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId 
FROM pPOMTemplate WHERE POMTempId = @POMTempId

SELECT * FROM pPOMTemplate WHERE POMTempId = @POMTempId

IF @StyleSet = 1 
BEGIN 
	EXEC('spx_StyleHeaderLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @SizeClassId + ''',''' + @SizeRangeId + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleMaterialLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleImageItemLink_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleCareCopy_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	EXEC('spx_StyleCostingCopy_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''' ')
	
END 


	EXEC('spx_StyleDevelopmentSpecLinkSet_INSERT ''' + @StyleID + ''',''' + @NewStyleID + ''',''' + @SizeClassId + ''',''' + @SizeRangeId + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''',''' + @StyleSet + ''' ')
	EXEC('spx_StyleSpecSize_SELECT ''' + @NewStyleID + '''')



	IF LOWER(@StyleSpecConversion) = 'true'
	BEGIN 
		EXEC('spx_StyleSpecReconvert_UPDATE ''' +  @NewStyleID + ''',''' + @StyleSet + ''' ')

/*
		--IF (SELECT TOP 1 SpecConversion FROM pSizeClass WHERE (Custom IN (SELECT SizeClass FROM  pStyleHeader WHERE Styleid = @StyleId))) = 1

		IF ( SELECT TOP 1 SpecConversion FROM pSizeClass WHERE Custom = @SizeClass ) = 1
		BEGIN
			
			UPDATE pStyleSpec SET Spec = 0 WHERE StyleId  = @NewStyleID AND StyleSet = @StyleSet 
					
			UPDATE pStyleSpec SET pStyleSpec.Spec = pStyleSpec_1.Spec 
			FROM pStyleSpec INNER JOIN
			pStyleSpec pStyleSpec_1 ON pStyleSpec.POM = pStyleSpec_1.POM AND pStyleSpec.StyleSet = pStyleSpec_1.StyleSet
			WHERE   pStyleSpec.StyleID = @NewStyleId
			AND pStyleSpec_1.StyleID = @StyleId 
			AND pStyleSpec_1.POMTempID IS NOT NULL
			AND pStyleSpec.StyleSet  = @StyleSet 


			UPDATE pStyleSpec SET 
			pStyleSpec.Spec = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0))
			FROM   pStyleSpec INNER JOIN  pPOMTemplateItem ON pStyleSpec.POM = pPOMTemplateItem.POM
			WHERE pStyleSpec.StyleID = @StyleId 
			AND pStyleSpec.StyleSet = @StyleSet 
			AND pPOMTemplateItem.POMTempID = @POMTempId

		END
*/	
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09983', GetUTCDate())
GO
