
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerFGVendor]') AND type = N'U')
	DROP TABLE [dbo].pMaterialTradePartnerFGVendor
GO

CREATE TABLE [dbo].[pMaterialTradePartnerFGVendor](
	[MaterialTradePartnerFGVendorID] [uniqueidentifier] NOT NULL,
	[MaterialTradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sort] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO

ALTER TABLE [dbo].[pMaterialTradePartnerFGVendor] ADD PRIMARY KEY CLUSTERED  ([MaterialTradePartnerFGVendorID])
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02021'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02021', GetDate())

END	  
GO