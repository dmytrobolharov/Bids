
/****** Object:  Table [dbo].[pMaterialContentVendorColor]    Script Date: 02/03/2011 14:29:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (select * from INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pMaterialContentVendorColor')
   BEGIN

CREATE TABLE [dbo].[pMaterialContentVendorColor](
	[MaterialContentVendorColorId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pMaterialContentVendorColor_MaterialContentVendorColorId]  DEFAULT (newid()),
	[MaterialTradePartnerID] [uniqueidentifier] NULL,
	[MaterialId] [uniqueidentifier] NULL,	
	[MaterialContentVendorColorCode] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaterialContentVendorColorPerc] [decimal](18, 0) NULL,
	[MaterialContentVendorColorName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_pMaterialContentVendorColor] PRIMARY KEY CLUSTERED 
(
	[MaterialContentVendorColorId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

  END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01091', GetDate())
GO
