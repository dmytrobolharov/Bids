/************ F group ****************/
if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'3CB4EA80-C34C-4BBD-8F35-E1DBCAA76E18')
begin
	INSERT [rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'3CB4EA80-C34C-4BBD-8F35-E1DBCAA76E18', N'f1000000-0000-0000-0000-000000000003', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_Material_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_FitPhotos_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'101')
end
GO

if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'3CB4EA80-C34C-4BBD-8F35-E1DBCAA76E16')
begin
	INSERT [dbo].[rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'3CB4EA80-C34C-4BBD-8F35-E1DBCAA76E16', N'f1000000-0000-0000-0000-000000000003', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_Material_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_Coversheet_Body_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'000')
end	
GO

/******************** P group ***************************/
if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'4CB4EA80-C34C-4BBD-8F35-E1DBCAA76E19')
begin
	INSERT [rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'4CB4EA80-C34C-4BBD-8F35-E1DBCAA76E19', N'f1000000-0000-0000-0000-000000000004', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_Material_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_FitPhotos_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'101')
end
GO

if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'4CB4EA80-C34C-4BBD-8F35-E1DBCAA76E20')
begin
	INSERT [dbo].[rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'4CB4EA80-C34C-4BBD-8F35-E1DBCAA76E20', N'f1000000-0000-0000-0000-000000000004', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_Material_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_Coversheet_Body_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'000')
end	
GO

/******************** A group ***************************/
if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'3B259D16-7BCF-497E-8501-B25A144F45F6')
begin
	INSERT [rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'3B259D16-7BCF-497E-8501-B25A144F45F6', N'F1000000-0000-0000-0000-000000000011', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_SpecImage_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_FitPhotos_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'101')
end
GO

if NOT EXISTS(SELECT * FROM [rReportSampleRequestSubmitItem] WHERE [ReportSampleRequestSubmitPageID] = N'3B259D16-7BCF-497E-8501-B25A144F45F7')
begin
	INSERT [dbo].[rReportSampleRequestSubmitItem] ([ReportSampleRequestSubmitPageID], [ReportSampleRequestSubmitFolderID], [ReportPageTypeID], [ReportTemplateName], [ReportPageName], [ReportPageDescription], [ReportServerType], [ReportFormName], [ReportPageURL], [ReportPKIField], [ReportPageActive], [ReportPageFormat], [ReportPageApproved], [ReportPageSort]) VALUES (N'3B259D16-7BCF-497E-8501-B25A144F45F7', N'F1000000-0000-0000-0000-000000000011', N'00000000-0000-0000-0000-000000000000', N'SampleRequestSubmit_SpecImage_Header_LLT', N'Sample Header', N'Sample Request Header', N'SQL', N'SampleRequestSubmit_Coversheet_Body_LLT', N'/StyleReportRedirect.aspx?RPID=##RPID##&SID=', N'StyleID', 1, N'PDF', 0, N'000')
end	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04035', GetDate())
GO 