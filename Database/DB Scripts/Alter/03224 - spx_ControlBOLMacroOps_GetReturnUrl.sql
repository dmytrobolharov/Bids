IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlBOLMacroOps_GetReturnUrl]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlBOLMacroOps_GetReturnUrl]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ControlBOLMacroOps_GetReturnUrl] (
	@catId nvarchar(50)
)
AS 

DECLARE @ReturnUrl nvarchar(100) = ''

IF (SELECT COUNT(*) FROM pBOLMacroCategory WHERE CategoryId = @catId) > 0
BEGIN
	SET @ReturnUrl = 'Category_Edit'
END

IF (SELECT COUNT(*) FROM pBOLMacroSubCategory WHERE SubCategoryId = @catId) > 0
BEGIN
	SET @ReturnUrl = 'Subcategory_Edit'
END

IF (SELECT COUNT(*) FROM pBOLMacroType WHERE TypeId = @catId) > 0
BEGIN
	SET @ReturnUrl = 'Type_Edit'
END

IF @ReturnUrl <> ''
BEGIN
	SELECT @ReturnUrl as ReturnUrl
END
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03224'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03224', GetDate())

END
GO 