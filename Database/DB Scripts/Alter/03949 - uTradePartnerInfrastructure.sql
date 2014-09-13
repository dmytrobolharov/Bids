
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_uTradePartnerInfrastructure_uTradePartner]') AND parent_object_id = OBJECT_ID(N'[dbo].[uTradePartnerInfrastructure]'))
ALTER TABLE [dbo].[uTradePartnerInfrastructure] DROP CONSTRAINT [FK_uTradePartnerInfrastructure_uTradePartner]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerInfrastructure_TradePartnerInfrastructureID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerInfrastructure] DROP CONSTRAINT [DF_uTradePartnerInfrastructure_TradePartnerInfrastructureID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerInfrastructure_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerInfrastructure] DROP CONSTRAINT [DF_uTradePartnerInfrastructure_Active]
END

GO


/****** Object:  Table [dbo].[uTradePartnerInfrastructure]    Script Date: 09/24/2012 01:18:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerInfrastructure]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerInfrastructure]
GO


/****** Object:  Table [dbo].[uTradePartnerInfrastructure]    Script Date: 09/24/2012 01:18:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerInfrastructure](
	[TradePartnerInfrastructureID] [uniqueidentifier] NOT NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[FacilityName] [nvarchar](200) NULL,
	[FacilityDescription] [nvarchar](200) NULL,
	[FacilityType] [nvarchar](50) NULL,
	[FacilityLocation] [nvarchar](100) NULL,
	[FacilityArea] [nvarchar](50) NULL,
	[TotalEmployees] [int] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [nvarchar](200) NULL,
	[CustomField8] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_uTradePartnerInfrastructure] PRIMARY KEY CLUSTERED 
(
	[TradePartnerInfrastructureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerInfrastructure]  WITH CHECK ADD  CONSTRAINT [FK_uTradePartnerInfrastructure_uTradePartner] FOREIGN KEY([TradePartnerID])
REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
GO

ALTER TABLE [dbo].[uTradePartnerInfrastructure] CHECK CONSTRAINT [FK_uTradePartnerInfrastructure_uTradePartner]
GO

ALTER TABLE [dbo].[uTradePartnerInfrastructure] ADD  CONSTRAINT [DF_uTradePartnerInfrastructure_TradePartnerInfrastructureID]  DEFAULT (newsequentialid()) FOR [TradePartnerInfrastructureID]
GO

ALTER TABLE [dbo].[uTradePartnerInfrastructure] ADD  CONSTRAINT [DF_uTradePartnerInfrastructure_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03949', GetDate())
GO
