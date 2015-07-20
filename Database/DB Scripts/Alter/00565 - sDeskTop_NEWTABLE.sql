

/****** Object:  Table [dbo].[sDeskTop]    Script Date: 10/11/2010 10:30:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sDeskTop]') AND type in (N'U'))
DROP TABLE [dbo].[sDeskTop]

GO

/****** Object:  Table [dbo].[sDeskTop]    Script Date: 10/11/2010 10:30:23 ******/
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


INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', null, 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=1'';', '01', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (3, 'Color', 'Color Folder', 'icon_colorway.gif', 'Color', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=3'';', '03', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (4, 'Image', 'Image Folder', 'icon_image.gif', 'Image', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=4'';', '04', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (5, 'Material', 'Raw Material Folder', 'icon_puzzle.gif', 'Raw Material', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=5'';', '05', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (7, 'Body', 'Body Folder', 'icon_body.gif', 'Body', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=7'';', '07', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (8, 'Style', 'Style Folder', 'icon_shirt.gif', 'Style', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=8'';', '08', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (9, 'Line List', 'Line List Folder', 'icon_image_catalog.gif', 'Line List', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=9'';', '09', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (11, 'BI', 'Business Intelligence Folder', 'icon_report.gif', 'Business', 'Intelligence', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=11'';', '11', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (15, 'Compliance', 'Compliance Folder', 'icon_globe.gif', 'Compliance', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=15'';', '15', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (30, 'Control', 'Control Panel', 'icon_toolbox.gif', 'Control', 'Panel', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=30'';', '30', 1)
GO
INSERT INTO dbo.sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (100, 'Log Off', 'Log Off', 'icon_close_1.gif', 'Log Off', null, 'parent.dbody.location = ''../Desk/Desk_LogOff.aspx?DTID=100'';', '99', 1)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '565', GetDate())
GO