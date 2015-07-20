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

CREATE  PROCEDURE spx_BatchQueueTechPackTeam_INSERT
(
	@BatchQueueTechPackID uniqueidentifier,
	@BatchQueueID uniqueidentifier,
	@TeamID uniqueidentifier,
	@FullName nvarchar(200),
	@BatchQueueTechPackTeamSort nvarchar(4),
	@CUser nvarchar(200),
	@CDate datetime
)
AS 
	INSERT INTO bBatchQueueTechPackTeam (BatchQueueTechPackID, BatchQueueID, TeamID, FullName, BatchQueueTechPackTeamSort, CUser, CDate)
                                 VALUES (@BatchQueueTechPackID, @BatchQueueID, @TeamID, @FullName, @BatchQueueTechPackTeamSort, @CUser, @CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '223', GetDate())
GO
