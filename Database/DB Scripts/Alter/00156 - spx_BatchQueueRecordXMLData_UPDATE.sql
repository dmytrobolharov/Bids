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

CREATE PROCEDURE [dbo].[spx_BatchQueueRecordXMLData_UPDATE]
( 
	@BatchQueueID uniqueidentifier, 
	@BatchQueueXMLData Text, 
	@MUser NVarChar(25),
	@MDate datetime
) 
AS

UPDATE bBatchQueue
SET BatchQueueXMLData = @BatchQueueXMLData, 
MUser = @MUser, 
MDate = @MDate 
WHERE BatchQueueID = @BatchQueueID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '156', GetDate())
GO
