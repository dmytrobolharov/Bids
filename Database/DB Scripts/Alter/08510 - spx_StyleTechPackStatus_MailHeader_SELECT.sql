IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPackStatus_MailHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTechPackStatus_MailHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleTechPackStatus_MailHeader_SELECT]
	@StyleTechPackStatusID UNIQUEIDENTIFIER
AS

SELECT 'Style ' + ISNULL(sh.StyleNo, '') + ' (Tech Pack Status) Notification'
FROM pStyleTechPackStatus stps
INNER JOIN pStyleHeader sh ON stps.StyleID = sh.StyleID
LEFT JOIN pWorkflowStatus ws ON stps.WorkStatus = ws.WorkflowStatusID
WHERE stps.StyleTechPackStatusID = @StyleTechPackStatusID




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08510', GetDate())
GO
