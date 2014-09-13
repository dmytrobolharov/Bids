-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 15 June 2010                                                                               */
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


CREATE PROCEDURE [dbo].[spx_BatchQueueRecordReset_UPDATE]
( 
	@BatchQueueID uniqueidentifier, 
	@BatchQueueStatusID uniqueidentifier, 
	@BatchQueueComments NVarChar(200), 
	@MUser NVarChar(25),
	@MDate datetime
) 
AS

UPDATE bBatchQueue 
SET BatchQueueStatusID = @BatchQueueStatusID, 
BatchQueueComments = @BatchQueueComments, 
MUser = @MUser, 
MDate = @MDate 
WHERE BatchQueueID = @BatchQueueID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '166', GetDate())
GO
