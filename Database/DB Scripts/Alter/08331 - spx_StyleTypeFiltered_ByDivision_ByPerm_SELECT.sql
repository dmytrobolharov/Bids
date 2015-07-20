IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTypeFiltered_ByDivision_ByPerm_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTypeFiltered_ByDivision_ByPerm_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleTypeFiltered_ByDivision_ByPerm_SELECT]
	@DivisionID NVARCHAR(50)
	, @IsSilhouette INT
	, @FolderTypeID INT
	, @TeamID NVARCHAR(50)
	, @OrderBy NVARCHAR(200)
AS
BEGIN

	DECLARE @sqlQuery NVARCHAR(MAX)
	
	SET @sqlQuery = 'SELECT a.StyleTypeID, b.StyleTypeDescription FROM pDivisionStyleType a ' +
					'INNER JOIN pStyleType b on b.StyleTypeID = a.StyleTypeID ' +
					'INNER JOIN pStyleTypeTemplate c ON b.StyleTypeTemplateID = c.StyleTypeTemplateID ' + 
					'WHERE c.IsSilhouette = @IsSilhouette AND b.Active = 1 AND DivisionID = @DivisionID ' +
						'AND a.StyleTypeID IN (SELECT ProductTypeID FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, @FolderTypeID) WHERE PermissionRoleId = 3 OR PermissionView = 1) '
						
	IF @OrderBy IS NOT NULL AND @OrderBy <> ''
	BEGIN
		SET @sqlQuery = @sqlQuery + 'ORDER BY ' + 'b.' + REPLACE(@OrderBy, ',', ', b.')
	END
	ELSE
	BEGIN
		SET @sqlQuery = @sqlQuery + 'ORDER BY b.StyleTypeDescription'
	END
	
	exec sp_executesql @sqlQuery,
		N'@TeamID nvarchar(50), @FolderTypeID int, @DivisionID nvarchar(50), @IsSilhouette int',
		@TeamID = @TeamID,
		@FolderTypeID = @FolderTypeID,
		@DivisionID = @DivisionID,
		@IsSilhouette = @IsSilhouette	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08331', GetDate())
GO
