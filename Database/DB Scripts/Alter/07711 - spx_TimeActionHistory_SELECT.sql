IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TimeActionHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TimeActionHistory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TimeActionHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.TACalTemplateId, b.TACalTemplateName
	FROM pTimeActionHistory a
				INNER JOIN pTACalTemplate b on a.TACalTemplateID = b.TACalTemplateId
	WHERE a.TeamID = @TeamId
	ORDER BY a.CDate DESC

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07711', GetDate())
GO
