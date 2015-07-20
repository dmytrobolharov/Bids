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

CREATE TABLE bBatchQueueTechPackTeam(
	BatchQueueTechPackTeamID uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT DF_bBatchQueueTechPackTeam_BatchQueueTechPackTeamID DEFAULT (newid()),
	BatchQueueTechPackID uniqueidentifier NULL,
	BatchQueueID uniqueidentifier NOT NULL,
	TeamID uniqueidentifier NULL,
	FullName nvarchar(200) NOT NULL,
	BatchQueueTechPackTeamSort nvarchar(4) NULL,
	CDate datetime NOT NULL,
	CUser nvarchar(200) NOT NULL,
	MDate datetime NULL,
	MUser nvarchar(200) NULL,
	CONSTRAINT PK_bBatchQueueTechPackTeam PRIMARY KEY CLUSTERED (BatchQueueTechPackTeamID ASC)
)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '218', GetDate())
GO
