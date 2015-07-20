IF NOT EXISTS (SELECT * FROM rReportPageMap WHERE ReportMapID = 'A1200000-0000-0000-0000-000000000000')
BEGIN
	INSERT INTO rReportPageMap (ReportMapID, ReportMapName)
	VALUES ('A1200000-0000-0000-0000-000000000000', 'SourcingQuoteFolder' )

	IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = 'A1252AF7-25F4-4666-A062-882D8C95BBA0')
	BEGIN
		INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
			ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
		VALUES ('A1252AF7-25F4-4666-A062-882D8C95BBA0', 'A1200000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_SourcingFolder_BigHeader_LLT',
			'Quotation by Style', 'Quotation by Style', 'SQL', 'v5_SourcingFolder_Style_Quotation', '/SourcingFolderReportRedirect.aspx?RPID=##RPID##&SHID=', 'SourcingHeaderID', 1, 'PDF')
	END

	IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = 'A1252AF7-25F4-4666-A062-882D8C95BBA1')
	BEGIN
		INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
			ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
		VALUES ('A1252AF7-25F4-4666-A062-882D8C95BBA1', 'A1200000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_SourcingFolder_Header_LLT',
			'Quote Summary by Country of Origin', 'Quote Summary by Country of Origin', 'SQL', 'v5_SourcingFolder_Quote_Summary_COO', '/SourcingFolderReportRedirect.aspx?RPID=##RPID##&SHID=', 'SourcingHeaderID', 1, 'PDF')
	END

	IF NOT EXISTS (SELECT * FROM rReportPageItem WHERE ReportPageID = 'A1252AF7-25F4-4666-A062-882D8C95BBA2')
	BEGIN
		INSERT INTO rReportPageItem (ReportPageID, ReportMapID, ReportPageTypeID, ReportTemplateName, 
			ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat)
		VALUES ('A1252AF7-25F4-4666-A062-882D8C95BBA2', 'A1200000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'v5_SourcingFolder_Header_LLT',
			'Quote Summary by Trade Partner', 'Quote Summary by Trade Partner', 'SQL', 'v5_SourcingFolder_Quote_Summary_TradePartner', '/SourcingFolderReportRedirect.aspx?RPID=##RPID##&SHID=', 'SourcingHeaderID', 1, 'PDF')
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05017', GetDate())
GO
