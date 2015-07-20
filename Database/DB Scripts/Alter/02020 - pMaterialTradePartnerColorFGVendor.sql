
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerColorFGVendor]') AND type = N'U')
	DROP TABLE [dbo].pMaterialTradePartnerColorFGVendor
GO


CREATE TABLE [dbo].[pMaterialTradePartnerColorFGVendor](
	[MaterialTradePartnerColorFGVendorID] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[MaterialTradePartnerFGVendorID] [uniqueidentifier] NULL,
	[MaterialTradePartnerColorID] [uniqueidentifier] NULL,
	[Quantity] [decimal] (18, 2) NULL,
	[ExMill] [datetime] NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaterialTradePartnerID] [uniqueidentifier] NULL
)
GO
ALTER TABLE [dbo].[pMaterialTradePartnerColorFGVendor] ADD PRIMARY KEY CLUSTERED  ([MaterialTradePartnerColorFGVendorID])
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02020'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02020', GetDate())

END	  
GO