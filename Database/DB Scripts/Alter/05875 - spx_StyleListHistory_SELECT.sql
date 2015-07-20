IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleListHistory_SELECT]
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
	WHERE
		pStyleHistory.TeamID = @TeamID
		AND EXISTS (SELECT StyleTypeID FROM sAccessStyleFolder WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND  TeamId = @TeamID  )
		AND pStyleTypeTemplate.IsSilhouette = @IsSilhouette
	ORDER BY
		pStyleHistory.CDate DESC

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05875', GetDate())
GO
