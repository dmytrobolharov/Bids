IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBOLOperationFixed_OperationFixingId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBOLOperationFixed] DROP CONSTRAINT [DF_pBOLOperationFixed_OperationFixingId]
END
GO

/****** Object:  Table [dbo].[pBOLOperationFixed]    Script Date: 11/04/2011 13:27:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBOLOperationFixed]') AND type in (N'U'))
DROP TABLE [dbo].[pBOLOperationFixed]
GO

/****** Object:  Table [dbo].[pBOLOperationFixed]    Script Date: 11/04/2011 13:27:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pBOLOperationFixed](
	[OperationFixingId] [uniqueidentifier] NOT NULL,
	[OperationId] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[SeasonYearId] [uniqueidentifier] NULL,
	[FixedCost] [numeric](10, 2) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLOperationFixed] PRIMARY KEY CLUSTERED 
(
	[OperationFixingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLOperationFixed] ADD  CONSTRAINT [DF_pBOLOperationFixed_OperationFixingId]  DEFAULT (newid()) FOR [OperationFixingId]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02124'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02124', GetDate())
	END
GO