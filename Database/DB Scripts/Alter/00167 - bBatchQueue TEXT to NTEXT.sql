-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 June 2010                                                                               */
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

ALTER TABLE bBatchQueue DROP CONSTRAINT DF_bBatchQueue_BatchQueueID
GO 

ALTER TABLE bBatchQueue DROP CONSTRAINT PK_bBatchQueue
GO 

EXECUTE sp_rename  bBatchQueue ,bBatchQueueOld
GO


CREATE TABLE bBatchQueue
(
	BatchQueueID uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT DF_bBatchQueue_BatchQueueID DEFAULT (newid()),
	TeamID uniqueidentifier NOT NULL,
	BatchQueueTypeID uniqueidentifier NOT NULL,
	ItemID uniqueidentifier NOT NULL,
	ItemDescription nvarchar(200) NOT NULL,
	BatchQueueXMLData ntext NULL,
	BatchQueueStatusID uniqueidentifier NOT NULL,
	BatchQueueComments nvarchar(200) NULL,
	CUser nvarchar(25) NOT NULL,
	CDate datetime NOT NULL,
	MUser nvarchar(25) NULL,
	MDate datetime NULL,
	CONSTRAINT PK_bBatchQueue PRIMARY KEY CLUSTERED (BatchQueueID ASC)
)
GO


INSERT INTO bBatchQueue(BatchQueueID,TeamID,BatchQueueTypeID,ItemID,ItemDescription,BatchQueueXMLData,BatchQueueStatusID,BatchQueueComments
           ,CUser,CDate,MUser,MDate)
SELECT BatchQueueID,TeamID,BatchQueueTypeID,ItemID,ItemDescription,BatchQueueXMLData,BatchQueueStatusID,BatchQueueComments
           ,CUser,CDate,MUser,MDate
FROM bBatchQueueOld
GO


DROP TABLE bBatchQueueOld
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '167', GetDate())
GO
