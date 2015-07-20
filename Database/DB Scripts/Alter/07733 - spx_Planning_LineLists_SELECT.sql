IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineLists_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineLists_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineLists_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT CAST(LineSubFolder6 AS DATETIME) AS DueDate, lf.*
	FROM vwx_LineFolder_Header_SEL lf
	INNER JOIN sAccessLineFolder alf ON lf.LineListTypeID = alf.LineTypeID
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
		AND alf.TeamId = @TeamID AND (alf.AccessRoleId = 3 OR alf.AccessView = 1)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07733', GetDate())
GO
