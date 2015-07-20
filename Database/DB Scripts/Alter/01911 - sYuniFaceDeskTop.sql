-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 7 September 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'sYuniFaceDeskTop') 
    DROP TABLE sYuniFaceDeskTop
GO


-- Create the sYuniFaceDeskTop table.
CREATE TABLE [dbo].[sYuniFaceDeskTop](
	[DeskTopID] [int] NOT NULL,
	[DeskName] [nvarchar](100) NULL,
	[DeskDescription] [nvarchar](4000) NULL,
	[DeskIcon] [varchar](200) NULL,
	[DeskLabel1] [nvarchar](25) NULL,
	[DeskLabel2] [nvarchar](25) NULL,
	[DeskUrl] [varchar](400) NULL,
	[DeskMenu] [varchar](400) NULL,
	[DeskMain] [varchar](400) NULL,
	[DeskSort] [varchar](4) NULL,
	[DeskActive] [int] NOT NULL,
	[DeskTopRepId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_sYuniFaceDeskTop] PRIMARY KEY CLUSTERED 
(
	[DeskTopID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sYuniFaceDeskTop] ADD  CONSTRAINT [DF_sYuniFaceDeskTop_DeskTopRepId]  DEFAULT (newid()) FOR [DeskTopRepId]
GO



INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', NULL, 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=1&TID=##TEAMID##";', '../Desktop/Desktop_Body.aspx', NULL, '01', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (2, 'Config Editor', 'Configuration File Editor', 'icon_edit_file.gif', 'Config', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=2&TID=##TEAMID##";', '../ConfigEditor/Control_ConfigEditor_Menu.aspx', '../ConfigEditor/Control_ConfigEditor_Main.aspx', '02', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (3, 'Data Dictionary', 'Data Dictionary', 'icon_bookopen.gif', 'Data', 'Dictionary', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=3&TID=##TEAMID##";', '../DataDictionary/Control_DataDictionary_Menu.aspx', '../DataDictionary/Control_DataDictionary_List.aspx', '03', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (4, 'Schema Editor', 'Schema File Editor', 'icon_edit_file.gif', 'Schema', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=4&TID=##TEAMID##";', '../SchemaEditor/Control_SchemaEditor_Menu.aspx', '../SchemaEditor/Control_SchemaEditor_Main.aspx', '04', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (5, 'Language', 'Language Settings', 'icon_flag_un.gif', 'Language', NULL, 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=5&TID=##TEAMID##";', '../Language/Control_Language_Menu.aspx', '../Language/Control_Language_Main.aspx', '05', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (6, 'Database Extensions', 'Database Extensions', 'icon_locked.gif', 'Database', 'Extensdions', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=6&TID=##TEAMID##";', '../DatabaseExt/Control_Override_Menu.aspx', '../DatabaseExt/Control_Override_Main.aspx', '06', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (7, 'Web Service Clients', 'Web Service Clients', 'icon_relation.gif', 'Web Service', 'Clients', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=7&TID=##TEAMID##";', '../WSClient/Control_WSClient_Menu.aspx', '../WSClient/Control_WSClient_List.aspx', '07', 1)
GO

INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (100, 'Log Off', 'Log Off', 'icon_close_1.gif', 'Log Off', NULL, 'parent.dbody.location = "../Desktop/Desktop_LogOff.aspx?DTID=100&TID=##TEAMID##";', NULL, NULL, '99', 1)
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01911', GetDate())
GO

SET NOCOUNT Off
GO
