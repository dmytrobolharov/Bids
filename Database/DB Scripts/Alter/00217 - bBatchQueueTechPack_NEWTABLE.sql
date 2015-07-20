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

CREATE TABLE bBatchQueueTechPack(
	BatchQueueTechPackID uniqueidentifier ROWGUIDCOL NOT NULL CONSTRAINT DF_bBatchQueueTechPack_BatchQueueTechPackID DEFAULT (newid()),
	BatchQueueID uniqueidentifier NOT NULL,
	StyleID uniqueidentifier NOT NULL,
	StyleDevelopmentID uniqueidentifier NOT NULL,
	StyleSourcingID uniqueidentifier NOT NULL,
	SeasonYearID uniqueidentifier NOT NULL,
	StyleVersion int NOT NULL,
	FinalTechPack int NOT NULL,
	TechPackRedirect nvarchar(2000) NOT NULL,
	TechPackOnTheFly int NOT NULL,
	CDate datetime NOT NULL,
	CUser nvarchar(200) NOT NULL,
	MDate datetime NULL,
	MUser nvarchar(200) NULL,
	CONSTRAINT PK_uBatchQueueTechPack PRIMARY KEY CLUSTERED (BatchQueueTechPackID ASC)
)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '217', GetDate())
GO
