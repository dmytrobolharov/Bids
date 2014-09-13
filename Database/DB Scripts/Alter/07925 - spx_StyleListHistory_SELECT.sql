/****** Object:  StoredProcedure [dbo].[spx_StyleListHistory_SELECT]    Script Date: 06/05/2014 12:16:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleListHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleListHistory_SELECT]    Script Date: 06/05/2014 12:16:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleListHistory_SELECT]
(
	@TeamID UNIQUEIDENTIFIER
	, @IsSilhouette INT = 0
)
AS
BEGIN
	SELECT *
	FROM
		pStyleHeader
		INNER JOIN pStyleHistory ON pStyleHeader.StyleID = pStyleHistory.StyleID
		INNER JOIN pStyleType ON pStyleHeader.StyleType = pStyleType.StyleTypeID
		INNER JOIN pStyleTypeTemplate ON pStyleType.StyleTypeTemplateID = pStyleTypeTemplate.StyleTypeTemplateID
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON pStyleType.StyleTypeID = access.ProductTypeId
	WHERE
		pStyleHistory.TeamID = @TeamID
		AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
		AND pStyleTypeTemplate.IsSilhouette = @IsSilhouette
	ORDER BY
		pStyleHistory.CDate DESC

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07925', GetDate())
GO