DELETE FROM rReportFolderItem WHERE ReportFormName = 'Dash_BusinessUsersGroup_ActivityTracking_Chart_PLT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05648', GetDate())
GO
