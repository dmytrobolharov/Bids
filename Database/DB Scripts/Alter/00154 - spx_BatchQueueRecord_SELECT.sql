-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 June 2010                                                                               */
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

CREATE PROCEDURE [dbo].[spx_BatchQueueRecord_SELECT]
(
@BatchQueueID UNIQUEIDENTIFIER
)
AS 

SELECT bBatchQueue.BatchQueueID, bBatchQueue.TeamID, Users.UserName, bBatchQueue.BatchQueueTypeID, bBatchQueueType.BatchQueueTypeDescription, 
       bBatchQueue.ItemID, bBatchQueue.ItemDescription, bBatchQueue.BatchQueueXMLData, 
       bBatchQueue.BatchQueueStatusID, bBatchQueueStatus.BatchQueueStatusDescription,
       bBatchQueue.BatchQueueComments, bBatchQueue.CUser, bBatchQueue.CDate, 
       bBatchQueue.MUser, bBatchQueue.MDate

FROM bBatchQueue 
INNER JOIN Users ON bBatchQueue.TeamID = Users.TeamID
INNER JOIN bBatchQueueType ON bBatchQueue.BatchQueueTypeID = bBatchQueueType.BatchQueueTypeID
INNER JOIN bBatchQueueStatus ON bBatchQueue.BatchQueueStatusID = bBatchQueueStatus.BatchQueueStatusID

WHERE bBatchQueue.BatchQueueID = @BatchQueueID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '154', GetDate())
GO
