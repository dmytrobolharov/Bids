IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FlashEdit_QuickFill_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFill_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFill_SELECT]
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT qf.* FROM pPlanningFlashEditQuickFill qf
	INNER JOIN pStyleCategory sc ON sc.StyleCategoryID = qf.StyleCategoryID
	INNER JOIN pStyleType st ON st.StyleTypeID = qf.StyleTypeID
	WHERE qf.TeamID = @TeamID
	ORDER BY qf.MDate DESC
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06371', GetDate())
GO
