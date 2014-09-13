UPDATE rDashFolderItem
SET DashFolderItemUrl = '/plmOnDashboards/Dash_SampleRequestSubmit_SharedComments', 
	DashFolderItemServerReportName = 'Dash_SampleRequestSubmit_SharedComments'
WHERE DashFolderItemName = 'New Sample Request Shared Comments'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05262', GetDate())
GO
