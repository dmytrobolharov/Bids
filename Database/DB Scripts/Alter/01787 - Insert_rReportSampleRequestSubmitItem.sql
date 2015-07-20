-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 August 2010                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

INSERT INTO [rReportSampleRequestSubmitItem](
			[ReportSampleRequestSubmitPageID]
			,[ReportSampleRequestSubmitFolderID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportPageApproved]
			,[ReportPageSort]
		)
		VALUES(
			'0004EA80-C34C-4BBD-8F35-E1DBCAA76002'
			,'F1000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'SampleRequestSubmit_SpecImage_VendorComments_Header_LLT'
			,'Sample Header'
			,'Sample Request Header'
			,'SQL'
			,'SampleRequestSubmit_SpecImage_VendorComments_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleID'
			,1
			,'PDF'
			,0
			,'002'
		)
		
		--Attached Images
		
		INSERT INTO [rReportSampleRequestSubmitItem](
			[ReportSampleRequestSubmitPageID]
			,[ReportSampleRequestSubmitFolderID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportPageApproved]
			,[ReportPageSort]
		)
		VALUES(
			'0004EA80-C34C-4BBD-8F35-E1DBCAA76003'
			,'F1000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'SampleRequestSubmit_SpecImage_Header_LLT'
			,'Sample Header'
			,'Sample Request Header'
			,'SQL'
			,'SampleRequestSubmit_AttachedImages_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleID'
			,1
			,'PDF'
			,0
			,'003'
		)
		--Material
		
		INSERT INTO [rReportSampleRequestSubmitItem](
			[ReportSampleRequestSubmitPageID]
			,[ReportSampleRequestSubmitFolderID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportPageApproved]
			,[ReportPageSort]
		)
		VALUES(
			'0004EA80-C34C-4BBD-8F35-E1DBCAA76004'
			,'F1000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'SampleRequestSubmit_Style_Material_Header_LLT'
			,'Material List XML'
			,'Style Material List'
			,'ASPX'
			,'Style_Component.aspx'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleID'
			,1
			,'PDF'
			,0
			,'004'
		)
		--Care Information
		INSERT INTO [rReportSampleRequestSubmitItem](
			[ReportSampleRequestSubmitPageID]
			,[ReportSampleRequestSubmitFolderID]
			,[ReportPageTypeID]
			,[ReportTemplateName]
			,[ReportPageName]
			,[ReportPageDescription]
			,[ReportServerType]
			,[ReportFormName]
			,[ReportPageURL]
			,[ReportPKIField]
			,[ReportPageActive]
			,[ReportPageFormat]
			,[ReportPageApproved]
			,[ReportPageSort]
		)
		VALUES(
			'0004EA80-C34C-4BBD-8F35-E1DBCAA76005'
			,'F1000000-0000-0000-0000-000000000050'
			,'00000000-0000-0000-0000-000000000000'
			,'SampleRequestSubmit_SpecImage_Header_LLT'
			,'Style Care'
			,'Style Care Instruction'
			,'SQL'
			,'SampleRequestSubmit_Care_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,1
			,'PDF'
			,0
			,'010'
		)

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01787'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '01787', GetDate())
	END
GO
