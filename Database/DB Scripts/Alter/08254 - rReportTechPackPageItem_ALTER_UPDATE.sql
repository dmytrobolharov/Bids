IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'rReportTechPackPageItem' AND COLUMN_NAME = 'WorkflowID')
BEGIN
	ALTER TABLE rReportTechPackPageItem ADD WorkflowID UNIQUEIDENTIFIER
END
GO

UPDATE
	rReportTechPackPageItem
SET WorkflowID = rspi.ReportMapID
FROM
	rReportStylePageItem rspi
WHERE
	rReportTechPackPageItem.ReportFormName = rspi.ReportFormName
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08254', GetDate())
GO                      