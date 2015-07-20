IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItemAssignedTo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItemAssignedTo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItemAssignedTo_SELECT]
	@MilestoneItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT a.*, CASE WHEN ma.AssignedToID IS NULL THEN 'False' ELSE 'True' END AS Checked 
	FROM (SELECT TeamID, ISNULL(FirstName, '') + ' ' + ISNULL(LastName, '') AS Name, 0 AS Sort 
		FROM Users WHERE Active = 1
		UNION ALL
		SELECT GroupID AS TeamID, GroupName AS Name, 1 AS Sort 
		FROM uGroup WHERE Active = 1) a
	LEFT JOIN pMilestoneItemAssignedTo ma ON a.TeamID = ma.AssignedToID
		AND ma.MilestoneItemID = @MilestoneItemID
	ORDER BY Sort
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07140', GetDate())
GO
