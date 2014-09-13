
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 22 November 2011                                                                           */
-- * WorkItem #5775                                                                             */
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

--Measurement POM Template

IF NOT EXISTS(SELECT ReportPageID FROM rReportPageItem WHERE ReportPageID='98E52AF7-25F4-4666-A062-882D8C95BBF2')
	BEGIN
		INSERT INTO [rReportPageItem]
			   (
				   [ReportPageID]
				   ,[ReportMapID]
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
			   )
		 VALUES
			   (
				   '98E52AF7-25F4-4666-A062-882D8C95BBF2'
				   ,'A1110000-0000-0000-0000-000000000000'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'ControlPanel_MeasurementPOMTemplate_Header_LLT'
				   ,'Measurement POM Template'
				   ,'Measurement POM Template'
				   ,'SQL'
				   ,'ControlPanel_MeasurementPOMTemplate_Body_LLT'
				   ,'/MeasurementPomTemplateReport.aspx?RPID=##RPID##&PTID='
				   ,'PomTemplateId'
				   ,1
				   ,'PDF'
			   )

	END
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02207'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02207', GetDate())
	END
GO
