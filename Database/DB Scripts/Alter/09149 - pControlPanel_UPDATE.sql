UPDATE pControlPanel
SET ControlPanelUrl = 'Control_PredefinedTechPack_List.aspx?CPID=' + CAST(ControlPanelID AS NVARCHAR(3))
WHERE ControlPanelName = N'Predefined Tech Pack'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09149', GetDate())
GO
