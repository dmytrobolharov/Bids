DECLARE @SrmReportFolderID UNIQUEIDENTIFIER
SET @SrmReportFolderID = NEWID()

IF NOT EXISTS (SELECT * FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Sourcing')
BEGIN
	INSERT INTO rReportSrmFolder (ReportSrmFolderID, ReportSrmFolderName, ReportSrmFolderActive, ReportSrmFolderSort)
	VALUES (@SrmReportFolderID, 'Sourcing', 1, '004')
END
ELSE
BEGIN
	SELECT @SrmReportFolderID = ReportSrmFolderID FROM rReportSrmFolder WHERE ReportSrmFolderName = 'Sourcing'
END

IF NOT EXISTS (SELECT * FROM rReportSrmFolderItem WHERE ReportSrmFolderItemName = 'Commitment Shared Comments Summary')	
BEGIN
	INSERT INTO rReportSrmFolderItem (ReportSrmFolderItemID, ReportSrmFolderID, ReportSrmFolderItemName, ReportSrmFolderItemUrl, ReportSrmFolderItemIcon, ReportSrmFolderItemSort, ReportSrmFolderItemActive)
	VALUES (NEWID(), @SrmReportFolderID, 'Commitment Shared Comments Summary', 'Dash_Commitment_SharedComments_srmOn', 'icon_filegrid.gif', '0002', 1)
END
ELSE
BEGIN
	UPDATE rReportSrmFolderItem SET ReportSrmFolderID = @SrmReportFolderID WHERE ReportSrmFolderItemName = 'Commitment Shared Comments Summary'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06821', GetDate())
GO
