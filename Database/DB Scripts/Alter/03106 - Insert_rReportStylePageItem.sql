
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 10 Feb 2011																				*/
-- * WorkItem #6786																				*/
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

IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageName = 'Import')
   BEGIN
        PRINT 'Import Page already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportStylePageItem 
			(ReportPageID
			,ReportMapID
			,ReportPageTypeID
			,ReportTemplateName
			,ReportPageName
			,ReportPageDescription
			,ReportServerType
			,ReportFormName
			,ReportPageURL
			,ReportPKIField
			,ReportPageActive
			,ReportPageFormat
			,ReportSrmOn)
		VALUES 
			(NEWID()
			,'50000000-0000-0000-0000-000000000005'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Import'
			,'Import'
			,'SQL'
			,'Style_Costing_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,'1'
			,'PDF'
			,'1')
	END
	
	
IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageName = 'Domestic')
   BEGIN
        PRINT 'Domestic Page already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportStylePageItem 
			(ReportPageID
			,ReportMapID
			,ReportPageTypeID
			,ReportTemplateName
			,ReportPageName
			,ReportPageDescription
			,ReportServerType
			,ReportFormName
			,ReportPageURL
			,ReportPKIField
			,ReportPageActive
			,ReportPageFormat
			,ReportSrmOn)
		VALUES 
			(NEWID()
			,'50000000-0000-0000-0000-000000000005'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Domestic'
			,'Domestic'
			,'SQL'
			,'Style_Costing_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,'1'
			,'PDF'
			,'1')
	END
	
IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportPageName = 'Indirect')
   BEGIN
        PRINT 'Indirect Page already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportStylePageItem 
			(ReportPageID
			,ReportMapID
			,ReportPageTypeID
			,ReportTemplateName
			,ReportPageName
			,ReportPageDescription
			,ReportServerType
			,ReportFormName
			,ReportPageURL
			,ReportPKIField
			,ReportPageActive
			,ReportPageFormat
			,ReportSrmOn)
		VALUES 
			(NEWID()
			,'50000000-0000-0000-0000-000000000005'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Indirect'
			,'Indirect'
			,'SQL'
			,'Style_Costing_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,'1'
			,'PDF'
			,'1')
	END
	
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03106'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03106', GetDate())

END

GO