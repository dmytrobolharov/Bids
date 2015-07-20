IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_NewLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_NewLogic_UPDATE]
GO

CREATE procedure [dbo].[spx_Material_NewLogic_UPDATE] (
@MaterialID UNIQUEIDENTIFIER ,
@MUser NVARCHAR(200) ,
@MDate DATETIME 
) 
AS 

	-- Add a calendar reference
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	SELECT @TACalTemplateID = TACalTemplateId FROM pMaterial
	WHERE MaterialID = @MaterialID	
	
	IF @TACalTemplateID IS NOT NULL AND @TACalTemplateID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		EXEC spx_TACalReferenceFromMaterial_CREATE
			@TACalTemplateID = @TACalTemplateID,
			@MaterialID = @MaterialID,
			@CUser = @MUser,
			@CDate = @MDate			
	END
	
	DECLARE @EnableMaterialPages NVARCHAR(10)
	SELECT @EnableMaterialPages = UPPER(RTRIM(LTRIM(AppSettingValue)))
	FROM sAppSetting
	WHERE ConfigFileName = 'Material.config' AND AppSettingKey = 'EnableMaterialPages'
	
	UPDATE pMaterial 
	SET EnableProductPages = CASE WHEN @EnableMaterialPages = 'TRUE' THEN 1 ELSE 0 END
	WHERE MaterialID = @MaterialID
	
	EXEC spx_MaterialWorkflow_Logic_UPDATE
		@MaterialID = @MaterialID,
		@CUser = @MUser,
		@CDate = @MDate

	-- update workflow status if colors were added 
	IF EXISTS(SELECT * FROM pMaterialColor WHERE MaterialID = @MaterialID)
	BEGIN
		exec spx_MaterialWorkflowStatus_Logic_UPDATE 
			@MaterialID = @MaterialID,
			@MaterialTemplatePageID = '20000000-0000-0000-0000-000000000000',
			@PageChange = 1,
			@WorkStatus = 6
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08685', GetDate())
GO
