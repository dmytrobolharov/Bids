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
UPDATE bBatchQueueStatus
SET BatchQueueStatusIcon = '../System/Icons/3.gif'
WHERE BatchQueueStatusDescription = 'In Progress'
GO


UPDATE bBatchQueueStatus
SET BatchQueueStatusIcon = '../System/Icons/4.gif'
WHERE BatchQueueStatusDescription = 'Complete'
GO


INSERT INTO bBatchQueueStatus (BatchQueueStatusDescription, BatchQueueStatusIcon, CUser, CDate)
VALUES ('Submitted', '../System/Icons/2.gif', 'System', GetDate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '174', GetDate())
GO
