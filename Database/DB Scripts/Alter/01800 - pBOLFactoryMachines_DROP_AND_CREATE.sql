
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBOLFactoryMachines_uTradePartnerVendor]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBOLFactoryMachines]'))
ALTER TABLE [dbo].[pBOLFactoryMachines] DROP CONSTRAINT [FK_pBOLFactoryMachines_uTradePartnerVendor]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBOLFactoryMachines_FactoryMachinesId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBOLFactoryMachines] DROP CONSTRAINT [DF_pBOLFactoryMachines_FactoryMachinesId]
END

GO

/****** Object:  Table [dbo].[pBOLFactoryMachines]    Script Date: 08/31/2011 17:19:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBOLFactoryMachines]') AND type in (N'U'))
DROP TABLE [dbo].[pBOLFactoryMachines]
GO

/****** Object:  Table [dbo].[pBOLFactoryMachines]    Script Date: 08/31/2011 17:19:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pBOLFactoryMachines](
	[FactoryMachinesId] [uniqueidentifier] NOT NULL,
	[FactoryId] [uniqueidentifier] NULL,
	[MachineId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLFactoryMachines] PRIMARY KEY CLUSTERED 
(
	[FactoryMachinesId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLFactoryMachines]  WITH CHECK ADD  CONSTRAINT [FK_pBOLFactoryMachines_uTradePartnerVendor] FOREIGN KEY([TradePartnerVendorID])
REFERENCES [dbo].[uTradePartnerVendor] ([TradePartnerVendorID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBOLFactoryMachines] CHECK CONSTRAINT [FK_pBOLFactoryMachines_uTradePartnerVendor]
GO

ALTER TABLE [dbo].[pBOLFactoryMachines] ADD  CONSTRAINT [DF_pBOLFactoryMachines_FactoryMachinesId]  DEFAULT (newid()) FOR [FactoryMachinesId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01800'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01800', GetDate())
END

GO 

