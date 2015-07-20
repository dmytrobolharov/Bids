-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
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

IF (SELECT COUNT(*) FROM rReportFolderItem WHERE ReportFolderItemID = 'ADBF2711-777D-4B23-91B8-6A05665AAAC4') = 0
BEGIN

	INSERT INTO rReportFolderItem (ReportFolderItemID, ReportFolderID, ReportFormName, ReportItemName, ReportItemDescription, ReportItemURL, ReportItemSort, ReportItemXML, ReportPageFormat, ReportHeaderItemName, ReportHeaderItemXML)
	VALUES ('ADBF2711-777D-4B23-91B8-6A05665AAAC4', '3EEBF141-9D0D-427E-9375-7A50A012E82F', 'Desktop_Agent_Sample_SharedComments_Body_LLT', 'PD Shared Comment Summary', 'PD Shared Comment Summary', 'Report_Main.aspx?R=/plmOnReports/Desktop_Agent_Sample_SharedComments_Body_LLT', '013', 'Report_Desktop_Agent_Sample_SharedComments.xml', 'PDF', NULL, NULL)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02986', GetDate())
GO

SET NOCOUNT Off
GO
