if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'a0b4ea80-c34c-4bbd-8f35-e1dbcaa76e18')
begin
	INSERT [rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'a0b4ea80-c34c-4bbd-8f35-e1dbcaa76e18', N'f1000000-0000-0000-0000-000000000001', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_SpecImage_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_FitPhotos_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'101')
end
GO

if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'a0b4ea80-c34c-4bbd-8f35-e1dbcaa76e19')
begin
	INSERT [rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'a0b4ea80-c34c-4bbd-8f35-e1dbcaa76e19', N'f1000000-0000-0000-0000-000000000050', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_SpecImage_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_FitPhotos_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'101')
end
GO

if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'0004EA80-C34C-4BBD-8F35-E1DBCAA76001')
begin
	INSERT [dbo].[rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'0004EA80-C34C-4BBD-8F35-E1DBCAA76001', N'f1000000-0000-0000-0000-000000000050', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_SpecImage_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_Coversheet_Body_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'001')
end	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04025', GetDate())
GO