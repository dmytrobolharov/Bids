DECLARE @SourcingDashFolderID UNIQUEIDENTIFIER

IF (SELECT COUNT(*) FROM rDashFolder WHERE DashFolderName = 'Sourcing') = 0
BEGIN
	UPDATE rDashFolder SET DashFolderSort = '007' WHERE DashFolderSort = '006'
	UPDATE rDashFolder SET DashFolderSort = '006' WHERE DashFolderSort = '005'

	INSERT INTO rDashFolder (DashFolderID, DashFolderName, DashFolderSort, DashFolderActive)
	VALUES (NEWID(), 'Sourcing', '005', 1)
	
	SET @SourcingDashFolderID = (SELECT DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sourcing')
	UPDATE rDashFolderItem SET DashFolderID = @SourcingDashFolderID WHERE DashFolderItemName LIKE '%Quote%' OR DashFolderItemName LIKE '%Quotation%'
END
ELSE
BEGIN
	SET @SourcingDashFolderID = (SELECT DashFolderID FROM rDashFolder WHERE DashFolderName = 'Sourcing')
	UPDATE rDashFolderItem SET DashFolderID = @SourcingDashFolderID WHERE DashFolderItemName LIKE '%Quote%' OR DashFolderItemName LIKE '%Quotation%'
END

DECLARE @SourcingFolderID UNIQUEIDENTIFIER 

IF (SELECT COUNT(*) FROM rReportFolder WHERE ReportFolderName = 'Sourcing Folder') = 0
BEGIN
	UPDATE rReportFolder SET ReportFolderSort = '00001' WHERE ReportFolderName = 'Material Folder'
	UPDATE rReportFolder SET ReportFolderSort = '00002' WHERE ReportFolderName = 'Image Folder'
	UPDATE rReportFolder SET ReportFolderSort = '00003' WHERE ReportFolderName = 'Style Folder'
	UPDATE rReportFolder SET ReportFolderSort = '00005' WHERE ReportFolderName = 'Administrative Reports'
	UPDATE rReportFolder SET ReportFolderSort = '00006' WHERE ReportFolderName = 'Line List Folder'
	UPDATE rReportFolder SET ReportFolderSort = '00007' WHERE ReportFolderName = 'Sample Folder'

	INSERT INTO rReportFolder (ReportFolderID, ReportFolderName, ReportFolderSort)
	VALUES (NEWID(), 'Sourcing Folder', '00004')
	
	SET @SourcingFolderID = (SELECT ReportFolderID FROM rReportFolder WHERE ReportFolderName = 'Sourcing Folder')
	UPDATE rReportFolderItem SET ReportFolderID = @SourcingFolderID WHERE ReportItemName LIKE '%Quotation%'
END
ELSE
BEGIN
	SET @SourcingFolderID = (SELECT ReportFolderID FROM rReportFolder WHERE ReportFolderName = 'Sourcing Folder')
	UPDATE rReportFolderItem SET ReportFolderID = @SourcingFolderID WHERE ReportItemName LIKE '%Quotation%'
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04990', GetDate())
GO
