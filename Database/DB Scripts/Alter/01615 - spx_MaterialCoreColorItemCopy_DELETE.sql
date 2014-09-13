IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreColorItemCopy_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCoreColorItemCopy_DELETE]
GO

CREATE PROCEDURE dbo.spx_MaterialCoreColorItemCopy_DELETE(
@MaterialCoreID UNIQUEIDENTIFIER,
@MaterialCoreColorID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME
)
AS

	DECLARE @ColorPaletteID UNIQUEIDENTIFIER 

	SELECT @ColorPaletteID = ColorPaletteID
	FROM pMaterialCoreColor 
	WHERE MaterialCoreColorID = @MaterialCoreColorID 


	DELETE FROM pMaterialCoreColorItem 
	WHERE MaterialCoreColorID IN (
		SELECT MaterialCoreColorID FROM pMaterialCoreColor 
		WHERE MaterialCoreID = @MaterialCoreID
		AND ColorPaletteID = @ColorPaletteID

	)

	DELETE FROM pMaterialCoreColor 
	WHERE MaterialCoreID = @MaterialCoreID
	AND ColorPaletteID = @ColorPaletteID





GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01615'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01615', GetDate())
END	

GO



