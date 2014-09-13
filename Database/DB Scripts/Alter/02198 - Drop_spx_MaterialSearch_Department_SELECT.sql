IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSearch_Department_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSearch_Department_SELECT]

GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialSearch_Department_SELECT]'))
DROP VIEW [dbo].[vwx_MaterialSearch_Department_SELECT]

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialDepartment_COMMA]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialDepartment_COMMA]

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02198'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02198', GetDate())
END	
GO