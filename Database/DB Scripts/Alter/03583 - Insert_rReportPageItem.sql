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


IF NOT EXISTS(SELECT ReportPageID FROM rReportPageItem WHERE ReportPageID='02DC5384-81E4-4170-89A4-1B54581D3C74')
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
				   '02DC5384-81E4-4170-89A4-1B54581D3C74'
				   ,'A6000000-0000-0000-0000-000000000000'
				   ,'00000000-0000-0000-0000-000000000000'
				   ,'ImageFolder_Header_PLT'
				   ,'Image Report with comments'
				   ,'Image Report with comments'
				   ,'SQL'
				   ,'ImageFolderComments_Body_PLT'
				   ,'/ImageReport.aspx?RPID=##RPID##&IHID='
				   ,'ImageHistoryId'
				   ,1
				   ,'PDF'
			   )

	END
GO

		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '5.0.0000', '03583', GetDate())

GO