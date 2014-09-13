UPDATE pWorkFlowItem SET WorkflowItemMasterID = NULL, StyleSeasonYearID = NULL
WHERE WorkflowID <> '40000000-0000-0000-0000-000000000080'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05870', GetDate())
GO
