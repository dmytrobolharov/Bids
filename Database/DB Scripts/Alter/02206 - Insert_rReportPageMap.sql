
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 25 November 2011                                                                           */
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
IF EXISTS(SELECT ReportMapID FROM rReportPageMap WHERE ReportMapID='A1110000-0000-0000-0000-000000000000')
   BEGIN
        PRINT 'Measurement POM Template already exists'
   END
ELSE
	BEGIN
		INSERT INTO rReportPageMap
		(
		ReportMapID,
		ReportMapName,
		ReportMapURL,
		Sort
		)
		VALUES 
		(
		'A1110000-0000-0000-0000-000000000000',
		'MeasurementPOMTemplate',
		null,
		null
		)
	END
	
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02206'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02206', GetDate())
	END
GO