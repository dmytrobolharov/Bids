


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sDeskMenuGroup_DeskMenuGroupID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sDeskMenuGroup] DROP CONSTRAINT [DF_sDeskMenuGroup_DeskMenuGroupID]
END

GO



/****** Object:  Table [dbo].[sDeskMenu]    Script Date: 10/15/2010 09:53:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sDeskMenu]') AND type in (N'U'))
DROP TABLE [dbo].[sDeskMenu]
GO

/****** Object:  Table [dbo].[sDeskMenuGroup]    Script Date: 10/15/2010 09:53:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sDeskMenuGroup]') AND type in (N'U'))
DROP TABLE [dbo].[sDeskMenuGroup]
GO

/****** Object:  Table [dbo].[sDeskMenuType]    Script Date: 10/15/2010 09:53:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sDeskMenuType]') AND type in (N'U'))
DROP TABLE [dbo].[sDeskMenuType]
GO

/****** Object:  Table [dbo].[sDeskTop]    Script Date: 10/15/2010 09:53:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sDeskTop]') AND type in (N'U'))
DROP TABLE [dbo].[sDeskTop]
GO



/****** Object:  Table [dbo].[sDeskMenu]    Script Date: 10/15/2010 09:53:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sDeskMenu](
	[DeskMenuID] [int] NOT NULL,
	[DeskMenuTypeID] [int] NULL,
	[DeskName] [nvarchar](100) NULL,
	[DeskDescription] [nvarchar](4000) NULL,
	[DeskIcon] [varchar](200) NULL,
	[DeskUrl] [varchar](400) NULL,
	[DeskSort] [varchar](4) NULL,
	[DeskActive] [int] NOT NULL,
	[DeskWindowName] [varchar](20) NULL,
 CONSTRAINT [PK_sDeskMenu] PRIMARY KEY CLUSTERED 
(
	[DeskMenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[sDeskMenuGroup]    Script Date: 10/15/2010 09:53:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sDeskMenuGroup](
	[DeskMenuGroupID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DeskMenuTypeID] [int] NOT NULL,
	[DeskMenuID] [int] NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_sDeskMenuGroup] PRIMARY KEY CLUSTERED 
(
	[DeskMenuGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[sDeskMenuType]    Script Date: 10/15/2010 09:53:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[sDeskMenuType](
	[DeskMenuTypeID] [int] NOT NULL,
	[DeskMenuTypeName] [nvarchar](100) NULL,
	[DeskMenuTypeIcon] [varchar](200) NULL,
	[DeskMenuTypeUrl] [varchar](400) NULL,
	[DeskMenuTypeSort] [varchar](4) NULL,
	[DeskMenuTypeActive] [int] NOT NULL,
 CONSTRAINT [PK_sDeskMenuType] PRIMARY KEY CLUSTERED 
(
	[DeskMenuTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[sDeskTop]    Script Date: 10/15/2010 09:53:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sDeskTop](
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
 CONSTRAINT [PK_sDesktop] PRIMARY KEY CLUSTERED 
(
	[DeskTopID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sDeskMenuGroup] ADD  CONSTRAINT [DF_sDeskMenuGroup_DeskMenuGroupID]  DEFAULT (newsequentialid()) FOR [DeskMenuGroupID]
GO




INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', null, 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=1&TID=##TEAMID##'';', '../User/User_Menu.aspx', '##BISERVER##/Dashboard/Dash_Main.aspx?RFIID=32867a50-474d-4132-bad0-89fbd510ce5c', '01', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (3, 'Color', 'Color Folder', 'icon_colorway.gif', 'Color', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=3&TID=##TEAMID##'';', '../Color/Color_List_Menu.aspx', '../Color/Color_List_Grid.aspx?', '03', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (4, 'Image', 'Image Folder', 'icon_image.gif', 'Image', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=4&TID=##TEAMID##'';', '../Image/Image_Menu.aspx', '../Image/Image_Search.aspx?', '04', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (5, 'Material', 'Raw Material Folder', 'icon_puzzle.gif', 'Raw Material', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=5&TID=##TEAMID##'';', '../Material/Material_List_Menu.aspx', '../Material/Material_List_Grid.aspx?', '05', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (7, 'Body', 'Body Folder', 'icon_body.gif', 'Body', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=7&TID=##TEAMID##'';', '../Body/Body_List_Menu.aspx', '../Body/Body_List_Search.aspx?TB=S', '07', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (8, 'Style', 'Style Folder', 'icon_shirt.gif', 'Style', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=8&TID=##TEAMID##'';', '../Style/Style_List_Menu.aspx', '../Style/Style_List_Search.aspx?TB=S', '08', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (9, 'Line List', 'Line List Folder', 'icon_image_catalog.gif', 'Line List', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=9&TID=##TEAMID##'';', '../Line/Line_Menu.aspx', '../Line/Line_List_Grid.aspx?', '09', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (11, 'BI', 'Business Intelligence Folder', 'icon_report.gif', 'Business', 'Intelligence', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=11&TID=##TEAMID##'';', '##BISERVER##/Dashboard/Dash_Menu.aspx', '##BISERVER##/Dashboard/Dash_Main.aspx?RFIID=03b0281f-aee5-4ba3-bcbe-800378a0f318', '50', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (15, 'Compliance', 'Compliance Folder', 'icon_globe.gif', 'Compliance', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=15&TID=##TEAMID##'';', '../Compliance/Compliance_Menu.aspx', '../Compliance/Compliance_Main.aspx?', '15', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (25, 'Flash Edit', 'Flash Edit Folder', 'icon_tables_stacks.gif', 'Flash Edit', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=25&TID=##TEAMID##'';', '../FlashEdit/FlashEdit_Menu.aspx', '../FlashEdit/FlashEdit_Main.aspx?', '25', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (26, 'Batch Queue', 'Batch Queue Folder', 'icon_storeF.gif', 'Batch Queue', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=26&TID=##TEAMID##'';', '../BatchQueue/BatchQueue_Menu.aspx', '../BatchQueue/BatchQueue_Main.aspx?', '26', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (30, 'Control', 'Control Panel', 'icon_toolbox.gif', 'Control', 'Panel', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=30&TID=##TEAMID##'';', '../Control/Control_Menu.aspx', '../Control/Control_Main.aspx?', '30', 0)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (40, 'Administrator', 'Administrator Folder', 'icon_locked.gif', 'Administrator', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=40&TID=##TEAMID##'';', '../Control/Control_AdminMenu.aspx', '../Control/Control_AdminMain.aspx?', '40', 0)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive) VALUES (100, 'Log Off', 'Log Off', 'icon_close_1.gif', 'Log Off', null, 'parent.dbody.location = ''../Desk/Desk_LogOff.aspx?DTID=100&TID=##TEAMID##'';', null, null, '99', 1)
GO

INSERT INTO sDeskMenuType(DeskMenuTypeID, DeskMenuTypeName, DeskMenuTypeIcon, DeskMenuTypeUrl, DeskMenuTypeSort, DeskMenuTypeActive) VALUES (1, 'User To-Do', 'icon_task.gif', null, '01', 1)
GO
INSERT INTO sDeskMenuType(DeskMenuTypeID, DeskMenuTypeName, DeskMenuTypeIcon, DeskMenuTypeUrl, DeskMenuTypeSort, DeskMenuTypeActive) VALUES (2, 'User View', 'icon_binocular.gif', null, '02', 1)
GO
INSERT INTO sDeskMenuType(DeskMenuTypeID, DeskMenuTypeName, DeskMenuTypeIcon, DeskMenuTypeUrl, DeskMenuTypeSort, DeskMenuTypeActive) VALUES (3, 'Notices', 'icon_exclamation.gif', '../User/User_Notice.aspx', '03', 1)
GO

INSERT INTO sDeskMenu(DeskMenuID, DeskMenuTypeID, DeskName, DeskDescription, DeskIcon, DeskUrl, DeskSort, DeskActive, DeskWindowName) VALUES (2, 1, 'Style', null, 'pg-next.gif', '##BISERVER##/Dashboard/Dash_Main.aspx?RFIID=32867a50-474d-4132-bad0-89fbd510ce5c', '002', 1, 'main')
GO
INSERT INTO sDeskMenu(DeskMenuID, DeskMenuTypeID, DeskName, DeskDescription, DeskIcon, DeskUrl, DeskSort, DeskActive, DeskWindowName) VALUES (3, 2, 'Quote View', null, 'pg-next.gif', '../Quote/Quote_List.aspx', '003', 1, 'QUOTEFOLDER')
GO
INSERT INTO sDeskMenu(DeskMenuID, DeskMenuTypeID, DeskName, DeskDescription, DeskIcon, DeskUrl, DeskSort, DeskActive, DeskWindowName) VALUES (4, 2, 'Sample View', null, 'pg-next.gif', '../Sample/SampleRequest_Folder.aspx', '004', 1, 'SAMPLEFOLDER')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '600', GetDate())
GO