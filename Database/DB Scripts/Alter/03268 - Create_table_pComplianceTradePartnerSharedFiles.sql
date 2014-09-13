CREATE TABLE [dbo].[pComplianceTradePartnerSharedFiles](
	[ComplianceShareFileID] [uniqueidentifier] NOT NULL,
	[ComplianceID] [uniqueidentifier] NOT NULL,
	[TradePartnerID] [uniqueidentifier] NOT NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pComplianceTradePartnerSharedFiles] ADD  CONSTRAINT [DF_ComplianceTradePartnerSharedFiles_ComplianceShareFileID]  DEFAULT (newid()) FOR [ComplianceShareFileID]
GO

ALTER TABLE [dbo].[pComplianceTradePartnerSharedFiles] ADD  CONSTRAINT [DF_ComplianceTradePartnerSharedFiles_CDate]  DEFAULT (getdate()) FOR [CDate]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03268'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03268', GetDate())
END
GO