
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Dec 2011																				*/
-- * WorkItem #5300                                                                             */
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

IF EXISTS(SELECT ReportPageID FROM rReportStylePageItem WHERE ReportFormName = 'Style_mBOM_Body_LLT')
   BEGIN
        PRINT 'Style_mBOM_Body_LLT already exists'
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
			,'40000000-0000-0000-0000-000000000080'
			,'00000000-0000-0000-0000-000000000000'
			,'Style_Header_LLT'
			,'Multi Dimensional BOM'
			,'Multi Dimensional BOM'
			,'SQL'
			,'Style_mBOM_Body_LLT'
			,'/StyleReportRedirect.aspx?RPID=##RPID##&SID='
			,'StyleId'
			,'1'
			,'PDF'
			,'1')
	END
	
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02321'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02321', GetDate())

END

GO