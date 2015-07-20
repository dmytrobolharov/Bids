IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerEquipment_TradePartnerEquipmentId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerEquipment] DROP CONSTRAINT [DF_uTradePartnerEquipment_TradePartnerEquipmentId]
END

GO

/****** Object:  Table [dbo].[uTradePartnerEquipment]    Script Date: 09/18/2012 10:45:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerEquipment]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerEquipment]
GO


/****** Object:  Table [dbo].[uTradePartnerEquipment]    Script Date: 09/18/2012 10:45:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerEquipment](
	[TradePartnerEquipmentId] [uniqueidentifier] NOT NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[MachineId] [uniqueidentifier] NULL,
	[MachineCode] [nvarchar](200) NULL,
	[MachineDesc] [nvarchar](200) NULL,
	[MachineClassID] [uniqueidentifier] NULL,
	[MachineTypeID] [uniqueidentifier] NULL,
	[ImageId] [uniqueidentifier] NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
 CONSTRAINT [PK_uTradePartnerEquipment] PRIMARY KEY CLUSTERED 
(
	[TradePartnerEquipmentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerEquipment] ADD  CONSTRAINT [DF_uTradePartnerEquipment_TradePartnerEquipmentId]  DEFAULT (newsequentialid()) FOR [TradePartnerEquipmentId]
GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03895', GetDate())
GO
