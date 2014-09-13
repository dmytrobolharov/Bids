

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DashFolder_DashFolderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rDashFolder] DROP CONSTRAINT [DF_DashFolder_DashFolderID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rDashFolder_DashFolderActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rDashFolder] DROP CONSTRAINT [DF_rDashFolder_DashFolderActive]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DashFolderItem_DashFolderItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rDashFolderItem] DROP CONSTRAINT [DF_DashFolderItem_DashFolderItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_rDashFolderItem_DashFolderItemActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[rDashFolderItem] DROP CONSTRAINT [DF_rDashFolderItem_DashFolderItemActive]
END

GO



/****** Object:  Table [dbo].[rDashFolder]    Script Date: 10/15/2010 09:55:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rDashFolder]') AND type in (N'U'))
DROP TABLE [dbo].[rDashFolder]
GO

/****** Object:  Table [dbo].[rDashFolderItem]    Script Date: 10/15/2010 09:55:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rDashFolderItem]') AND type in (N'U'))
DROP TABLE [dbo].[rDashFolderItem]
GO



/****** Object:  Table [dbo].[rDashFolder]    Script Date: 10/15/2010 09:55:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[rDashFolder](
	[DashFolderID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DashFolderName] [nvarchar](50) NULL,
	[DashFolderSort] [nvarchar](5) NULL,
	[DashFolderActive] [int] NULL,
 CONSTRAINT [PK_DashFolder] PRIMARY KEY CLUSTERED 
(
	[DashFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[rDashFolderItem]    Script Date: 10/15/2010 09:55:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[rDashFolderItem](
	[DashFolderItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DashFolderID] [uniqueidentifier] NULL,
	[DashFolderItemName] [nvarchar](100) NULL,
	[DashFolderItemUrl] [varchar](200) NULL,
	[DashFolderItemIcon] [varchar](200) NULL,
	[DashFolderItemSort] [varchar](5) NULL,
	[DashFolderItemActive] [int] NULL,
	[DashFolderItemServerUrl] [varchar](2000) NULL,
	[DashFolderItemServerFolderName] [varchar](255) NULL,
	[DashFolderItemServerReportName] [varchar](255) NULL,
 CONSTRAINT [PK_DashFolderItem] PRIMARY KEY CLUSTERED 
(
	[DashFolderItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[rDashFolder] ADD  CONSTRAINT [DF_DashFolder_DashFolderID]  DEFAULT (newid()) FOR [DashFolderID]
GO

ALTER TABLE [dbo].[rDashFolder] ADD  CONSTRAINT [DF_rDashFolder_DashFolderActive]  DEFAULT ((1)) FOR [DashFolderActive]
GO

ALTER TABLE [dbo].[rDashFolderItem] ADD  CONSTRAINT [DF_DashFolderItem_DashFolderItemID]  DEFAULT (newid()) FOR [DashFolderItemID]
GO

ALTER TABLE [dbo].[rDashFolderItem] ADD  CONSTRAINT [DF_rDashFolderItem_DashFolderItemActive]  DEFAULT ((1)) FOR [DashFolderItemActive]
GO


INSERT INTO rDashFolder(DashFolderID, DashFolderName, DashFolderSort, DashFolderActive) VALUES ('0FAAE5CD-7B02-4146-9159-133DC5BA0000', 'To Do', '001', 1)
GO
INSERT INTO rDashFolder(DashFolderID, DashFolderName, DashFolderSort, DashFolderActive) VALUES ('0FAAE5CD-7B02-4146-9159-133DC5BA0229', 'Sample', '005', 1)
GO
INSERT INTO rDashFolder(DashFolderID, DashFolderName, DashFolderSort, DashFolderActive) VALUES ('9CEE3776-FB97-46BE-891E-19C835ADE496', 'Style', '004', 1)
GO
INSERT INTO rDashFolder(DashFolderID, DashFolderName, DashFolderSort, DashFolderActive) VALUES ('18C8DB00-F02E-4FEB-B87F-87BD17AF7197', 'Color', '002', 1)
GO
INSERT INTO rDashFolder(DashFolderID, DashFolderName, DashFolderSort, DashFolderActive) VALUES ('AE03C508-B028-4969-B450-DFAEF6E9ACD5', 'Material', '003', 1)
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('FD4DD380-DF37-4521-B588-13214DA24BF4', 'AE03C508-B028-4969-B450-DFAEF6E9ACD5', 'Material Dashboard', '/YuniqueBI/Dash_Material', 'icon_chart_bar.gif', '001', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_Material')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('FD4DD380-DF37-4521-B588-13214DA24BF5', '18C8DB00-F02E-4FEB-B87F-87BD17AF7197', 'Color Dashboard', '/YuniqueBI/Dash_Color', 'icon_chart_bar.gif', '001', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_Color')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('03B0281F-AEE5-4BA3-BCBE-800378A0F318', '9CEE3776-FB97-46BE-891E-19C835ADE496', 'Style Dashboard', '/YuniqueBI/Dash_Style', 'icon_chart_pie.gif', '001', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_Style')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('03B0281F-AEE5-4BA3-BCBE-800378A0F319', '0FAAE5CD-7B02-4146-9159-133DC5BA0229', 'Sample Dashboard', '/YuniqueBI/Dash_Sample', 'icon_chart_pie.gif', '001', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_Sample')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('03B0281F-AEE5-4BA3-BCBE-800378A0F320', '9CEE3776-FB97-46BE-891E-19C835ADE496', 'Style Summary', '/YuniqueBI/DashMain', 'icon_chart_pie.gif', '001', 0, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'DashMain')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('03B0281F-AEE5-4BA3-BCBE-800378A0F321', '0FAAE5CD-7B02-4146-9159-133DC5BA0229', 'Sample Submit', '/YuniqueBI/Dash_SampleRequestSubmit', 'icon_chart_bar.gif', '002', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_SampleRequestSubmit')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('03B0281F-AEE5-4BA3-BCBE-800378A0F322', '0FAAE5CD-7B02-4146-9159-133DC5BA0229', 'Vendor Score Card', '/YuniqueBI/Dash_SampleVendorScore', 'icon_chart_bar.gif', '003', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_SampleVendorScore')
GO
INSERT INTO rDashFolderItem(DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName) VALUES ('32867A50-474D-4132-BAD0-89FBD510CE5C', '0FAAE5CD-7B02-4146-9159-133DC5BA0000', 'Style To Do', '/YuniqueBI/Dash_StyleToDoList', 'icon_chart_bar.gif', '001', 1, 'http://YSDPWKS/ReportServer', 'YuniqueBI', 'Dash_StyleToDo')
GO


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '601', GetDate())
GO