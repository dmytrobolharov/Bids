/****** Object:  StoredProcedure [dbo].[spx_SourcingHeaderStyleTypes_SELECT]    Script Date: 06/05/2014 14:58:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHeaderStyleTypes_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHeaderStyleTypes_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingHeaderStyleTypes_SELECT]    Script Date: 06/05/2014 14:58:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_SourcingHeaderStyleTypes_SELECT] (
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
	)
AS
BEGIN
	DECLARE @SourcingFolderDivisionID UNIQUEIDENTIFIER
	SELECT @SourcingFolderDivisionID = Division FROM pSourcingHeader WHERE SourcingHeaderID = @SourcingHeaderID
	
	SELECT DISTINCT dst.StyleTypeID, StyleTypeDescription, 
	IsChecked = CASE 
	WHEN shst.StyleTypeID IS NULL 
	THEN 'FALSE' ELSE 'TRUE' 
	END,
	IsEnabled = CASE
	WHEN EXISTS(SELECT * FROM pSourcingStyle ss INNER JOIN pStyleHeader sh ON ss.StyleID = sh.StyleID 
				WHERE sh.StyleType = dst.StyleTypeID AND ss.SourcingHeaderID = @SourcingHeaderID) 
	THEN 'FALSE' ELSE 'TRUE' 
	END
	FROM pStyleType st
	INNER JOIN pDivisionStyleType dst ON dst.StyleTypeID = st.StyleTypeID
	LEFT JOIN pSourcingHeaderToStyleType shst ON shst.StyleTypeID = dst.StyleTypeID AND shst.SourcingHeaderID = @SourcingHeaderID
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = st.StyleTypeID
	WHERE DivisionID = @SourcingFolderDivisionID AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
	ORDER BY st.StyleTypeDescription

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07924', GetDate())
GO