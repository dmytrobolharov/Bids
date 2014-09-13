if NOT EXISTS (SELECT * FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Style')
begin
	INSERT INTO rReportSrmFolder(ReportSrmFolderID, ReportSrmFolderName, ReportSrmFolderSort, ReportSrmFolderActive)
	VALUES (NEWID(), 'Style', '002', 1)
end
GO

if NOT EXISTS (SELECT * FROM rReportSrmFolderItem WHERE ReportSrmFolderItemName = 'Style Change Log')
begin
	INSERT INTO rReportSrmFolderItem(ReportSrmFolderItemID, ReportSrmFolderID, ReportSrmFolderItemName, ReportSrmFolderItemUrl, ReportSrmFolderItemIcon, ReportSrmFolderItemSort, ReportSrmFolderItemActive)
	VALUES (NEWID(), (SELECT TOP 1 ReportSrmFolderID FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Style'), 'Style Change Log', 'Dash_Style_Change', 'icon_filegrid.gif', '0001', 1)	
end
GO

if NOT EXISTS (SELECT * FROM rReportSrmFolderItem WHERE ReportSrmFolderItemName = 'Style Change Log Summary')
begin
	INSERT INTO rReportSrmFolderItem(ReportSrmFolderItemID, ReportSrmFolderID, ReportSrmFolderItemName, ReportSrmFolderItemUrl, ReportSrmFolderItemIcon, ReportSrmFolderItemSort, ReportSrmFolderItemActive)
	VALUES (NEWID(), (SELECT TOP 1 ReportSrmFolderID FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Style'), 'Style Change Log Summary', 'Dash_Style_Change_Summary', 'icon_filegrid.gif', '0002', 1)	
end
GO

if NOT EXISTS (SELECT * FROM rReportSrmFolderItem WHERE ReportSrmFolderItemName = 'New Sample Request Shared Comments')
begin
	INSERT INTO rReportSrmFolderItem(ReportSrmFolderItemID, ReportSrmFolderID, ReportSrmFolderItemName, ReportSrmFolderItemUrl, ReportSrmFolderItemIcon, ReportSrmFolderItemSort, ReportSrmFolderItemActive)
	VALUES (NEWID(), (SELECT TOP 1 ReportSrmFolderID FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Sample'), 'New Sample Request Shared Comments', 'Desktop_SampleRequestSubmit_SharedComments_Body_PLT', 'icon_filegrid.gif', '0002', 1)	
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04163', GetDate())
GO