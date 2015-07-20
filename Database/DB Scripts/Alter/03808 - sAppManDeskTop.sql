-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 August 2012                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAppManDeskTop_DeskTopRepId]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sAppManDeskTop] DROP CONSTRAINT [DF_sAppManDeskTop_DeskTopRepId]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAppManDeskTop_DeskRow]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sAppManDeskTop] DROP CONSTRAINT [DF_sAppManDeskTop_DeskRow]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAppManDeskTop_DeskCol]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sAppManDeskTop] DROP CONSTRAINT [DF_sAppManDeskTop_DeskCol]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAppManDeskTop]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sAppManDeskTop]
END
GO

CREATE TABLE [dbo].[sAppManDeskTop](
	[DeskTopID] [int] NOT NULL,
	[DeskName] [nvarchar](100) NULL,
	[DeskDescription] [nvarchar](4000) NULL,
	[DeskIcon] [varchar](200) NULL,
	[DeskLabel1] [nvarchar](25) NULL,
	[DeskLabel2] [nvarchar](25) NULL,
	[DeskUrl] [varchar](400) NULL,
	[DeskSort] [varchar](4) NULL,
	[DeskActive] [int] NOT NULL,
	[DeskTopRepId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DeskButtonName] [nvarchar](200) NULL,
	[DeskRow] [int] NOT NULL,
	[DeskCol] [int] NOT NULL,
 CONSTRAINT [PK_sAppManDeskTop] PRIMARY KEY CLUSTERED 
(
	[DeskTopID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAppManDeskTop] ADD  CONSTRAINT [DF_sAppManDeskTop_DeskTopRepId]  DEFAULT (newid()) FOR [DeskTopRepId]
GO

ALTER TABLE [dbo].[sAppManDeskTop] ADD  CONSTRAINT [DF_sAppManDeskTop_DeskRow]  DEFAULT ((1)) FOR [DeskRow]
GO

ALTER TABLE [dbo].[sAppManDeskTop] ADD  CONSTRAINT [DF_sAppManDeskTop_DeskCol]  DEFAULT ((1)) FOR [DeskCol]
GO


-- Initial data.
INSERT INTO sAppManDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive, DeskButtonName, DeskRow, DeskCol)
VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', NULL, 'parent.dbody.location = "../Desktop/Desktop_Body.aspx?DTID=1&TID=##TEAMID##";', '01', 1, 'btn_Desk_Home.gif', 0, 0)
GO

INSERT INTO sAppManDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive, DeskButtonName, DeskRow, DeskCol)
VALUES (2, 'App Store', 'App Store', 'icon_down.gif', 'App Store', NULL, 'parent.dbody.location = "../AppStore/AppStore_Main.aspx?DTID=2&TID=##TEAMID##";', '02', 1, 'btn_Desk_AppStore.gif', 1, 1)
GO

INSERT INTO sAppManDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive, DeskButtonName, DeskRow, DeskCol)
VALUES (3, 'Purchased Apps', 'Purchased Apps', 'icon_popup.gif', 'Purchased Apps', NULL, 'parent.dbody.location = "../AppMan/AppMan_Main.aspx?DTID=3&TID=##TEAMID##";', '03', 1, 'btn_Desk_PurchasedApps.gif', 1, 2)
GO

INSERT INTO sAppManDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive, DeskButtonName, DeskRow, DeskCol)
VALUES (100, 'Log Off', 'Log Off', 'icon_close_1.gif', 'Log Off', NULL, 'parent.dbody.location = "../Desktop/Desktop_LogOff.aspx?DTID=100&TID=##TEAMID##";', '99', 1, 'btn_Desk_LogOff.gif', 0, 0)
GO

EXEC spx_SystemButtons_IMPORT_MISSING
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03808', GetDate())
GO

SET NOCOUNT Off
GO
