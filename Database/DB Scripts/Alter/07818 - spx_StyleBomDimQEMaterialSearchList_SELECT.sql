/****** Object:  StoredProcedure [dbo].[spx_StyleBomDimQEMaterialSearchList_SELECT]    Script Date: 06/02/2014 14:09:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBomDimQEMaterialSearchList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBomDimQEMaterialSearchList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBomDimQEMaterialSearchList_SELECT]    Script Date: 06/02/2014 14:09:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleBomDimQEMaterialSearchList_SELECT] (
@SearchFilter NVARCHAR(MAX),
@DisplayText NVarchar(50),
@TeamId uniqueidentifier
)  
AS
if @DisplayText=''
	begin
		set @DisplayText='MaterialNo'
	end
	
If @SearchFilter <> '' 
	begin
		SET @SearchFilter = '%' + @SearchFilter + '%'
		if @DisplayText='MaterialNo'
			begin
				SELECT MaterialNo,  
					MaterialNo + ' (' + ISNULL(MaterialName,'') + ')' AS Code_Name,
					MaterialName + ' (' + ISNULL(MaterialNo,'') + ')' AS Name_Code
				FROM pMaterial INNER JOIN
				fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) access 
				ON access.ProductTypeId = pMaterial.MaterialType
				WHERE 
				(MaterialNo LIKE @SearchFilter OR MaterialName LIKE @SearchFilter)
				--MaterialNo LIKE '%'+@MaterialNo+'%' 
				AND access.PermissionRoleId <> 0
				ORDER BY MaterialNo ASC
			end
		else if @DisplayText='MaterialName'
			begin
				SELECT MaterialNo,  
					MaterialNo + ' (' + ISNULL(MaterialName,'') + ')' AS Code_Name,
					MaterialName + ' (' + ISNULL(MaterialNo,'') + ')' AS Name_Code
				FROM pMaterial INNER JOIN 
				fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) access 
				ON access.ProductTypeId = pMaterial.MaterialType
				WHERE 
				(MaterialNo LIKE @SearchFilter OR MaterialName LIKE @SearchFilter)
				--MaterialNo LIKE '%'+@MaterialNo+'%' 
				AND access.PermissionRoleId <> 0 
				ORDER BY MaterialName ASC
			end	
	end



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07818', GetDate())
GO
