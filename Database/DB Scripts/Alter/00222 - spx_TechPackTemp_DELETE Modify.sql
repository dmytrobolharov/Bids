-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 June 2010                                                                               */
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

ALTER PROCEDURE [dbo].[spx_TechPackTemp_DELETE]
(@ReportTechPackID uniqueidentifier,
 @OnTheFly integer)
AS 

IF @OnTheFly = 0
BEGIN
	DELETE FROM rReportStyleTemp WHERE (DataXmlId = @ReportTechPackID)
	DELETE FROM rReportTable WHERE (DataXmlId = @ReportTechPackID)
END

ELSE IF @OnTheFly = 1
BEGIN
	DELETE FROM rReportStylePageItemTemp WHERE (ReportTechPackID = @ReportTechPackID)
	DELETE FROM rReportTable WHERE (DataXmlId = @ReportTechPackID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '222', GetDate())
GO
