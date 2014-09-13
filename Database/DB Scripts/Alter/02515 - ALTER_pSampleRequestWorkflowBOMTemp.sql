
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
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

IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pSampleRequestWorkflowBOMTemp'
and COLUMN_NAME = N'SampleRequestWorkflowID' AND COLUMN_DEFAULT='(newid())'
)
BEGIN
     
      ALTER TABLE pSampleRequestWorkflowBOMTemp
      ADD CONSTRAINT SRW_SampleRequestWorkflowID
      DEFAULT (newid()) FOR SampleRequestWorkflowID

END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02515'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02515', GetDate())
END

GO


