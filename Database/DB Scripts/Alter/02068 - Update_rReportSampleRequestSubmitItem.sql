
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 22 Oct 2011                                                                                */
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

IF EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitItem WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F0' AND ReportFormName='SampleRequestSubmit_QAMeas_Body_LLT')
	BEGIN
	
		UPDATE rReportSampleRequestSubmitItem SET ReportFormName='SampleRequestSubmit_QAMeasurement_Body_LLT'  WHERE ReportSampleRequestSubmitPageID='3B259D16-7BCF-497E-8501-B25A144F45F0' 
		
	END
	
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02068'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02068', GetDate())
	END
GO