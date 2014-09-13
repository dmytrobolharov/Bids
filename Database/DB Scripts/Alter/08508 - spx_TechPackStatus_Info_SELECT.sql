IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackStatus_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackStatus_Info_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackStatus_Info_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS

SELECT *
	, sh.StyleType AS StyleTypeID
	, '~/System/Icons/' + ISNULL(ws.WorkflowStatusImage, 'icon_ball_gray.gif') AS StatusIconUrl
FROM pStyleTechPackStatus stps
INNER JOIN pStyleSeasonYear ssy ON stps.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN pStyleHeader sh ON stps.StyleID = sh.StyleID
LEFT JOIN pWorkflowStatus ws ON stps.WorkStatus = ws.WorkflowStatusID
LEFT JOIN vwx_UserGroupDropDown_SEL ug ON stps.WorkAssignedTo = ug.UserID
WHERE stps.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08508', GetDate())
GO
