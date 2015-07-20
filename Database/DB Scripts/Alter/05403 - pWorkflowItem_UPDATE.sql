UPDATE pWorkFlowItem SET WorkStatus = 6 WHERE WorkStatus IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05403', GetDate())
GO
