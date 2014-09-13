-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 August 2011                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
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

SET NOCOUNT ON
GO


--POM Library - Text Only
UPDATE rReportPageItem
SET ReportPageURL = '/PomTemplateReport.aspx?RPID=##RPID##&PTID='
WHERE ReportPageName = 'POM Library - Text Only'
GO

--POM Library
UPDATE rReportPageItem
SET ReportPageURL = '/PomTemplateReport.aspx?RPID=##RPID##&PTID='
WHERE ReportPageName = 'POM Library'
GO

--POM Library - List View
UPDATE rReportPageItem
SET ReportPageURL = '/PomTemplateReport.aspx?RPID=##RPID##&PTID='
WHERE ReportPageName = 'POM Library - List View'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01761', GetDate())
GO

SET NOCOUNT Off
GO
