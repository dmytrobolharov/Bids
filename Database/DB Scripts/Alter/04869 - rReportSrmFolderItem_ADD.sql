IF NOT EXISTS (SELECT * FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Material')
BEGIN
	INSERT INTO rReportSrmFolder (
		ReportSrmFolderID
		, ReportSrmFolderName
		, ReportSrmFolderSort
		, ReportSrmFolderActive) 
	VALUES (
		NEWID()
		, 'Material'
		, '003'
		, 1)
END
GO


IF NOT EXISTS (SELECT * FROM rReportSrmFolderItem WHERE ReportSrmFolderItemUrl = 'Dash_MaterialRequestSubmit_SharedComments_SrmOn')
BEGIN

	DECLARE @rReportSrmFolderID UNIQUEIDENTIFIER = (SELECT TOP 1 ReportSrmFolderID FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Material')
		

	INSERT INTO [dbo].[rReportSrmFolderItem] 
	(
		[ReportSrmFolderItemID], 
		[ReportSrmFolderID], 
		[ReportSrmFolderItemName], 
		[ReportSrmFolderItemUrl], 
		[ReportSrmFolderItemIcon], 
		[ReportSrmFolderItemSort], 
		[ReportSrmFolderItemActive]
	) 
	VALUES 
	(
		NEWID(),
		@rReportSrmFolderID, 
		N'Material Request Shared Comment Summary', 
		N'Dash_MaterialRequestSubmit_SharedComments_SrmOn', 
		N'icon_filegrid.gif', 
		'0001', 
		1
	)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04869', GetDate())
GO
