IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCADModel2BOM_CADModel2BOMId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCADModel2BOM] DROP CONSTRAINT [DF_pStyleCADModel2BOM_CADModel2BOMId]
END

GO

/****** Object:  Table [dbo].[pStyleCADModel2BOM]    Script Date: 11/18/2011 11:01:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCADModel2BOM]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCADModel2BOM]
GO

/****** Object:  Table [dbo].[pStyleCADModel2BOM]    Script Date: 11/18/2011 11:01:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleCADModel2BOM](
	[CADModel2BOMId] [uniqueidentifier] NOT NULL,
	[ModelId] [uniqueidentifier] NULL,
	[FabricType] [nvarchar](200) NULL,
	[MaterialId] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleCADModel2BOMId] PRIMARY KEY CLUSTERED 
(
	[CADModel2BOMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleCADModel2BOM] ADD  CONSTRAINT [DF_pStyleCADModel2BOM_CADModel2BOMId]  DEFAULT (newid()) FOR [CADModel2BOMId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02200'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02200', GetDate())
END	
GO