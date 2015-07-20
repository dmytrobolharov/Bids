
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
IF EXISTS(SELECT ReportSampleRequestSubmitFolderID FROM rReportSampleRequestSubmitFolder WHERE ReportSampleRequestSubmitGroup='A')
   BEGIN
        PRINT 'Sample Request for Measurement already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportSampleRequestSubmitFolder
		(
		ReportSampleRequestSubmitFolderID,
		ReportSampleRequestSubmitName,
		ReportSampleRequestSubmitFormName,
		ReportSampleRequestSubmitGroup,
		ReportSampleRequestSubmitFinal,
		ReportSampleRequestSubmitSort,
		Active,
		srmOn
		)
		VALUES 
		(
		'F1000000-0000-0000-0000-000000000011',
		'Sample Request Submit',
		'Sample Submit',
		'A',
		'1',
		'001',
		'1',
		'1'
		)
	END
	
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02007'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02007', GetDate())
	END
GO