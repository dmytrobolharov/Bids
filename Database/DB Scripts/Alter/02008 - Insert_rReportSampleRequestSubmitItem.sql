
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 13 Oct 2011                                                                                */
-- * WorkItem #3474                                                                             */
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

--QA Meas WorkSheet

IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F0')
	BEGIN
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
					'3B259D16-7BCF-497E-8501-B25A144F45F0'
					,'F1000000-0000-0000-0000-000000000011'
					,'00000000-0000-0000-0000-000000000000'
					,'SampleRequestSubmit_QAImage_Header_LLT'
					,'Sample Header'
					,'Sample Request Header'
					,'SQL'
					,'SampleRequestSubmit_QAMeas_Body_LLT'
					,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
					,'StyleID'
					,1
					,'PDF'
					,0
					,'001'
				)
	END
		
		
--Fit Comments
IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F2')
	BEGIN
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
					'3B259D16-7BCF-497E-8501-B25A144F45F2'
					,'F1000000-0000-0000-0000-000000000011'
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
	END
		
		
--Attached Images
IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F3')
	BEGIN
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
				'3B259D16-7BCF-497E-8501-B25A144F45F3'
				,'F1000000-0000-0000-0000-000000000011'
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
	END
		
		
--Material
IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F4')
	BEGIN
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
					'3B259D16-7BCF-497E-8501-B25A144F45F4'
					,'F1000000-0000-0000-0000-000000000011'
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
	END
		
		
--Care Information
IF NOT EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F5')
	BEGIN
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
					'3B259D16-7BCF-497E-8501-B25A144F45F5'
					,'F1000000-0000-0000-0000-000000000011'
					,'00000000-0000-0000-0000-000000000000'
					,'SampleRequestSubmit_SpecImage_Header_LLT'
					,'Style Care'
					,'Style Care Instruction'
					,'SQL'
					,'SampleRequestSubmit_Care_Body_LLT'
					,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
					,'StyleID'
					,1
					,'PDF'
					,0
					,'005'
				)
	END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02008'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02008', GetDate())
	END
GO
