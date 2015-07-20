UPDATE rReportSrmFolderItem SET ReportSrmFolderItemUrl='Dash_SampleRequestSubmit_SharedComments_SrmON' 
WHERE ReportSrmFolderItemName='New Sample Request Shared Comments'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05284', GetDate())
GO
