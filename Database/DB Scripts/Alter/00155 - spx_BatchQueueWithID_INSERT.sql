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

CREATE  PROCEDURE [dbo].[spx_BatchQueueWithID_INSERT]
(
	@BatchQueueID uniqueidentifier,
	@TeamID uniqueidentifier,
	@BatchQueueTypeID uniqueidentifier,
	@ItemID uniqueidentifier,
	@ItemDescription NVarChar(200),
	@BatchQueueXMLData Text,
	@BatchQueueStatusID uniqueidentifier,
	@BatchQueueComments NVarChar(200), 
	@CUser NVarChar(25),
	@CDate datetime
)
AS 

INSERT INTO bBatchQueue  (BatchQueueID, TeamID, BatchQueueTypeID, ItemID, ItemDescription, BatchQueueXMLData, BatchQueueStatusID, BatchQueueComments, CUser, CDate) 
                 VALUES  (@BatchQueueID, @TeamID, @BatchQueueTypeID, @ItemID, @ItemDescription, @BatchQueueXMLData, @BatchQueueStatusID, @BatchQueueComments, @CUser, @CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '155', GetDate())
GO
