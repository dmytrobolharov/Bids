-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 June 2010                                                                               */
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

CREATE PROCEDURE spx_BatchQueueTechPackTeam_SELECT
(
	@BatchQueueID uniqueidentifier
)
AS 
	SELECT BatchQueueTechPackTeamID, BatchQueueTechPackID, BatchQueueID, TeamID, FullName, BatchQueueTechPackTeamSort, CUser, CDate, MUser, MDate
	FROM bBatchQueueTechPackTeam
	WHERE BatchQueueID = @BatchQueueID
	ORDER BY BatchQueueTechPackTeamSort, FullName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '225', GetDate())
GO
