

/****** Object:  Table [dbo].[rReportStylePageItem]    Script Date: 12/06/2011 17:07:03 ******/
IF NOT EXISTS(SELECT [ReportPageID] FROM  [rReportStylePageItem] WHERE [ReportPageID]=N'0a380b00-764b-4963-b016-11f691254276')
BEGIN
	INSERT [dbo].[rReportStylePageItem] ([ReportPageID], [ReportMapID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportSrmOn]) VALUES (N'0a380b00-764b-4963-b016-11f691254276', N'40000000-0000-0000-0000-000000000077', N'00000000-0000-0000-0000-000000000000', N'Style_Header_LLT', N'Style BOL Operation Bulletin', N'Style BOL Operation Bulletin', N'SQL', N'Style_BOL_Operation_Bulletin', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleId', 1, N'PDF', 1)
END
IF NOT EXISTS(SELECT [ReportPageID] FROM  [rReportStylePageItem] WHERE [ReportPageID]=N'0a380b00-764b-4963-b016-11f691254277')
BEGIN
	INSERT [dbo].[rReportStylePageItem] ([ReportPageID], [ReportMapID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportSrmOn]) VALUES (N'0a380b00-764b-4963-b016-11f691254277', N'40000000-0000-0000-0000-000000000077', N'00000000-0000-0000-0000-000000000000', N'Style_Header_LLT', N'Style BOL Operation Bulletin With Comments', N'Style BOL Operation Bulletin With Comments', N'SQL', N'Style_BOL_Operation_Bulletin_With_Comments', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleId', 1, N'PDF', 1)
END
IF NOT EXISTS(SELECT [ReportPageID] FROM  [rReportStylePageItem] WHERE [ReportPageID]=N'0a380b00-764b-4963-b016-11f691254278')
BEGIN
	INSERT [dbo].[rReportStylePageItem] ([ReportPageID], [ReportMapID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportSrmOn]) VALUES (N'0a380b00-764b-4963-b016-11f691254278', N'40000000-0000-0000-0000-000000000077', N'00000000-0000-0000-0000-000000000000', N'Style_Header_LLT', N'Style BOL Operation Routing With Images', N'Style BOL Operation Routing With Images', N'SQL', N'Style_BOL_Operation_ Routing_With_Images', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleId', 1, N'PDF', 1)
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02301'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02301', GetDate())
	END
GO	