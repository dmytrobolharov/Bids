/*** pPartnerListHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPartnerListHistory]') AND name = N'IX_pPartnerListHistory_TeamID')
DROP INDEX [IX_pPartnerListHistory_TeamID] ON [dbo].[pPartnerListHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPartnerListHistory_TeamID] ON [dbo].[pPartnerListHistory] 
(
	[TeamID] ASC,
	[CDate] DESC
)
INCLUDE ( [TradePartnerID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerTemplateItem]') AND name = N'IX_uTradePartnerTemplateItem_TraderPartnerTemplateID')
DROP INDEX [IX_uTradePartnerTemplateItem_TraderPartnerTemplateID] ON [dbo].[uTradePartnerTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerTemplateItem_TraderPartnerTemplateID] ON [dbo].[uTradePartnerTemplateItem] 
(
	[TradePartnerTemplateID] ASC
)
INCLUDE ( [TradePartnerTemplatePageID],
[Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerContact ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerContact]') AND name = N'IX_uTradepartnerContact_TradePartnerID')
DROP INDEX [IX_uTradepartnerContact_TradePartnerID] ON [dbo].[uTradePartnerContact] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradepartnerContact_TradePartnerID] ON [dbo].[uTradePartnerContact] 
(
	[TradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerAddress ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerAddress]') AND name = N'IX_uTradePartnerAddress_TradePartnerID')
DROP INDEX [IX_uTradePartnerAddress_TradePartnerID] ON [dbo].[uTradePartnerAddress] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerAddress_TradePartnerID] ON [dbo].[uTradePartnerAddress] 
(
	[TradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerEquipment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerEquipment]') AND name = N'IX_uTradePartnerEquipment_TradePartnerID')
DROP INDEX [IX_uTradePartnerEquipment_TradePartnerID] ON [dbo].[uTradePartnerEquipment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerEquipment_TradePartnerID] ON [dbo].[uTradePartnerEquipment] 
(
	[TradePartnerId] ASC
)
INCLUDE ( [MachineId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerCompliance ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerCompliance]') AND name = N'IX_uTradePartnerCompliance_TradePartnerID')
DROP INDEX [IX_uTradePartnerCompliance_TradePartnerID] ON [dbo].[uTradePartnerCompliance] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerCompliance_TradePartnerID] ON [dbo].[uTradePartnerCompliance] 
(
	[TradePartnerId] ASC
)
INCLUDE ( [StatusId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerComplianceItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceItem]') AND name = N'IX_uTradePartnerComplianceItem_TradePartnerComplianceID')
DROP INDEX [IX_uTradePartnerComplianceItem_TradePartnerComplianceID] ON [dbo].[uTradePartnerComplianceItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerComplianceItem_TradePartnerComplianceID] ON [dbo].[uTradePartnerComplianceItem] 
(
	[TradePartnerComplianceId] ASC,
	[TradePartnerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerComments ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComments]') AND name = N'IX_uTradePartnerComments_TradePartnerComplianceID')
DROP INDEX [IX_uTradePartnerComments_TradePartnerComplianceID] ON [dbo].[uTradePartnerComments] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerComments_TradePartnerComplianceID] ON [dbo].[uTradePartnerComments] 
(
	[TradePartnerComplianceId] ASC,
	[MDate] DESC
)
INCLUDE ( [TradePartnerId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerComplianceDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceDocument]') AND name = N'IX_uTradePartnerComplianceDocument_TradePartnerComplianceID')
DROP INDEX [IX_uTradePartnerComplianceDocument_TradePartnerComplianceID] ON [dbo].[uTradePartnerComplianceDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerComplianceDocument_TradePartnerComplianceID] ON [dbo].[uTradePartnerComplianceDocument] 
(
	[TradePartnerComplianceId] ASC
)
INCLUDE ( [TradePartnerId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerInfrastructureImage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerInfrastructureImage]') AND name = N'IX_uTradePartnerInfrastructureImage_TradePartnerInfrastructureID')
DROP INDEX [IX_uTradePartnerInfrastructureImage_TradePartnerInfrastructureID] ON [dbo].[uTradePartnerInfrastructureImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerInfrastructureImage_TradePartnerInfrastructureID] ON [dbo].[uTradePartnerInfrastructureImage] 
(
	[TradePartnerInfrastructureID] ASC,
	[ImageID] ASC
)
INCLUDE ( [ImageVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerProductType ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerProductType]') AND name = N'IX_uTradePartnerProductType_TradePartnerID')
DROP INDEX [IX_uTradePartnerProductType_TradePartnerID] ON [dbo].[uTradePartnerProductType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerProductType_TradePartnerID] ON [dbo].[uTradePartnerProductType] 
(
	[TradePartnerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerCapacity ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerCapacity]') AND name = N'IX_uTradePartnerCapacity_TradePartnerID')
DROP INDEX [IX_uTradePartnerCapacity_TradePartnerID] ON [dbo].[uTradePartnerCapacity] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerCapacity_TradePartnerID] ON [dbo].[uTradePartnerCapacity] 
(
	[TradePartnerID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerShipInfo ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerShipInfo]') AND name = N'IX_uTradePartnerShipInfo_TradePartnerID')
DROP INDEX [IX_uTradePartnerShipInfo_TradePartnerID] ON [dbo].[uTradePartnerShipInfo] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerShipInfo_TradePartnerID] ON [dbo].[uTradePartnerShipInfo] 
(
	[TradePartnerID] ASC
)
INCLUDE ( [ShipTypeID],
[ShipModeID],
[TradePointID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** uTradePartnerRelationshipLevel ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerRelationshipLevel]') AND name = N'IX_uTradePartnerRelationshipLevel_TradePartnerID')
DROP INDEX [IX_uTradePartnerRelationshipLevel_TradePartnerID] ON [dbo].[uTradePartnerRelationshipLevel] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartnerRelationshipLevel_TradePartnerID] ON [dbo].[uTradePartnerRelationshipLevel] 
(
	[TradePartnerID] ASC,
	[TradePartnerRelationshipParentLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09055', GetDate())
GO
