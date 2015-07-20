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

CREATE  PROCEDURE spx_BatchQueueTechPackRecord_SELECT
(
	@BatchQueueID uniqueidentifier
)
AS 
	SELECT BatchQueueTechPackID, BatchQueueID, StyleID, StyleDevelopmentID, StyleSourcingID, SeasonYearID, 
	       StyleVersion, FinalTechPack, TechPackRedirect, TechPackOnTheFly, CUser, CDate, MUser, MDate
	FROM bBatchQueueTechPack
	WHERE BatchQueueID = @BatchQueueID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '221', GetDate())
GO
