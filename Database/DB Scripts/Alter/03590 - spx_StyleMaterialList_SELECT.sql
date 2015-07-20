IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialList_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleMaterialList_SELECT] (@MaterialNo nvarchar(100), @MaterialName nvarchar(200) = '')  
AS

IF @MaterialName = ''  -- search by MaterialNo
BEGIN
	SELECT MaterialNo,  
		MaterialNo + ' (' + ISNULL(MaterialName,'') + ')' AS Code_Name,
		MaterialName + ' (' + ISNULL(MaterialNo,'') + ')' AS Name_Code
	FROM pMaterial WHERE MaterialNo LIKE '%'+@MaterialNo+'%' ORDER BY MaterialNo ASC
END
ELSE   -- search by MaterialName
BEGIN
	SELECT MaterialNo,  
		MaterialNo + ' (' + ISNULL(MaterialName,'') + ')' AS Code_Name,
		MaterialName + ' (' + ISNULL(MaterialNo,'') + ')' AS Name_Code
	FROM pMaterial WHERE MaterialName LIKE '%'+@MaterialName+'%' ORDER BY MaterialName ASC
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03590', GetDate())
GO