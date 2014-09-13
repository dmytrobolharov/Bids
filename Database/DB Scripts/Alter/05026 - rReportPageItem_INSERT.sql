IF NOT EXISTS (SELECT * FROM rReportPageMap WHERE ReportMapID = 'A1300000-0000-0000-0000-000000000000')
BEGIN
	INSERT INTO rReportPageMap (ReportMapID, ReportMapName)
	VALUES ('A1300000-0000-0000-0000-000000000000', 'SourcingCommitFolder' )

	IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = 'A1352AF7-25F4-4666-A062-882D8C95BBA0')
	BEGIN
		INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
			ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
		VALUES ('A1352AF7-25F4-4666-A062-882D8C95BBA0', 'A1300000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_SourcingFolder_BigHeader_LLT',
			'Commitment by Style', 'Commitment by Style', 'SQL', 'v5_SourcingFolder_Style_Commitment', '/SourcingFolderReportRedirect.aspx?RPID=##RPID##&SHID=', 'SourcingHeaderID', 1, 'PDF')
	END

	IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = 'A1352AF7-25F4-4666-A062-882D8C95BBA1')
	BEGIN
		INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
			ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
		VALUES ('A1352AF7-25F4-4666-A062-882D8C95BBA1', 'A1300000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_SourcingFolder_Header_LLT',
			'Commitment Summary by Country of Origin', 'Commitment Summary by Country of Origin', 'SQL', 'v5_SourcingFolder_Commitment_Summary_COO', '/SourcingFolderReportRedirect.aspx?RPID=##RPID##&SHID=', 'SourcingHeaderID', 1, 'PDF')
	END

	IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = 'A1352AF7-25F4-4666-A062-882D8C95BBA2')
	BEGIN
		INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
			ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
		VALUES ('A1352AF7-25F4-4666-A062-882D8C95BBA2', 'A1300000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_SourcingFolder_Header_LLT',
			'Commitment Summary by Trade Partner', 'Commitment Summary by Trade Partner', 'SQL', 'v5_SourcingFolder_Commitment_Summary_TradePartner', '/SourcingFolderReportRedirect.aspx?RPID=##RPID##&SHID=', 'SourcingHeaderID', 1, 'PDF')
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05026', GetDate())
GO
