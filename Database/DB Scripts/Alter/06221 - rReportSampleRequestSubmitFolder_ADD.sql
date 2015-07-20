-- Design Sample (GroupID = 'D')

IF EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitFolder WHERE ReportSampleRequestSubmitGroup='D')
   BEGIN
        PRINT 'Sample Request Report already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportSampleRequestSubmitFolder (
			ReportSampleRequestSubmitFolderID, ReportSampleRequestSubmitName, ReportSampleRequestSubmitFormName, 
			ReportSampleRequestSubmitGroup, ReportSampleRequestSubmitFinal, ReportSampleRequestSubmitSort, Active, srmOn)
		VALUES ('F1000000-0000-0000-0000-000000000070', 'Sample Request Submit', 'Sample Submit', 'D', '1', '001', '1', '1')		
		
		IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem 
					  WHERE ReportSampleRequestSubmitPageID='AC8C28C5-DE90-489B-8293-A05AF0B49522')
		BEGIN
			INSERT INTO rReportSampleRequestSubmitItem (
				ReportSampleRequestSubmitPageID, ReportSampleRequestSubmitFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, 
				ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, 
				ReportPageFormat, ReportPageApproved, ReportPageSort)
			VALUES (
				'AC8C28C5-DE90-489B-8293-A05AF0B49522', 'F1000000-0000-0000-0000-000000000070', '00000000-0000-0000-0000-000000000000',
				'v5_SampleRequestSubmit_SpecImage_Header_LLT', 'Sample Header', 'Sample Request Header', 'SQL', 
				'v5_SampleRequestSubmit_Coversheet_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', 1, 'PDF', 0, '001')
		END
		-- attached images
		IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem 
					  WHERE ReportSampleRequestSubmitPageID='64C0D0BE-C113-4E43-8D1A-A17402E186BD')
		BEGIN
			INSERT INTO rReportSampleRequestSubmitItem (
				ReportSampleRequestSubmitPageID, ReportSampleRequestSubmitFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, 
				ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, 
				ReportPageFormat, ReportPageApproved, ReportPageSort)
			VALUES (
				'64C0D0BE-C113-4E43-8D1A-A17402E186BD', 'F1000000-0000-0000-0000-000000000070', '00000000-0000-0000-0000-000000000000',
				'v5_SampleRequestSubmit_SpecImage_Header_LLT', 'Sample Images', 'Sample Request Images', 'SQL', 
				'v5_SampleRequestSubmit_AttachedImages_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', 1, 'PDF', 0, '002')
		END
		-- fit photo comments
		IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem 
					  WHERE ReportSampleRequestSubmitPageID='13699236-AD19-45D9-A391-2FC8F36D2608')
		BEGIN
			INSERT INTO rReportSampleRequestSubmitItem (
				ReportSampleRequestSubmitPageID, ReportSampleRequestSubmitFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, 
				ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, 
				ReportPageFormat, ReportPageApproved, ReportPageSort)
			VALUES (
				'13699236-AD19-45D9-A391-2FC8F36D2608', 'F1000000-0000-0000-0000-000000000070', '00000000-0000-0000-0000-000000000000',
				'v5_SampleRequestSubmit_SpecImage_Header_LLT', 'Sample Fit Photos', 'Sample Request Fit Photos', 'SQL', 
				'v5_SampleRequestSubmit_FitPhotos_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', 1, 'PDF', 0, '003')
		END
		-- comments
		IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem 
					  WHERE ReportSampleRequestSubmitPageID='400355B7-3ABB-4790-A48C-93C29D9008F0')
		BEGIN
			INSERT INTO rReportSampleRequestSubmitItem (
				ReportSampleRequestSubmitPageID, ReportSampleRequestSubmitFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, 
				ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, 
				ReportPageFormat, ReportPageApproved, ReportPageSort)
			VALUES (
				'400355B7-3ABB-4790-A48C-93C29D9008F0', 'F1000000-0000-0000-0000-000000000070', '00000000-0000-0000-0000-000000000000',
				'v5_SampleRequestSubmit_SpecImage_VendorComments_Header_LLT', 'Sample Comments', 'Sample Request Comments', 'SQL', 
				'v5_SampleRequestSubmit_SpecImage_VendorComments_Body_LLT', '/StyleReportRedirect.aspx?RPID=##RPID##&SID=', 'StyleID', 1, 'PDF', 0, '004')
		END		
			
	END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06221', GetDate())
GO

