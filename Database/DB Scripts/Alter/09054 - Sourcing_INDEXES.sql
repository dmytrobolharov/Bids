/*** pSourcingQuoteStyleBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuoteStyleBOM]') AND name = N'IX_pSourcingQuoteStyleBOM_StyleBOMDimensionID')
DROP INDEX [IX_pSourcingQuoteStyleBOM_StyleBOMDimensionID] ON [dbo].[pSourcingQuoteStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingQuoteStyleBOM_StyleBOMDimensionID] ON [dbo].[pSourcingQuoteStyleBOM] 
(
	[StyleBOMDimensionID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOM]') AND name = N'IX_pSourcingCommitmentBOM_StyleBOMDimensionID')
DROP INDEX [IX_pSourcingCommitmentBOM_StyleBOMDimensionID] ON [dbo].[pSourcingCommitmentBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentBOM_StyleBOMDimensionID] ON [dbo].[pSourcingCommitmentBOM] 
(
	[StyleBOMDimensionID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[NotShow],
[SourcingCommitmentItemID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingQuotationBOMDetails ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuotationBOMDetails]') AND name = N'IX_pSourcingQuotationBOMDetails_StyleQuoteItemID')
DROP INDEX [IX_pSourcingQuotationBOMDetails_StyleQuoteItemID] ON [dbo].[pSourcingQuotationBOMDetails] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingQuotationBOMDetails_StyleQuoteItemID] ON [dbo].[pSourcingQuotationBOMDetails] 
(
	[StyleQuoteItemID] ASC,
	[StyleBOMDimensionId] ASC
)
INCLUDE ( [PartnerTotal],
[ItemDim1Active],
[ItemDim2Active],
[ItemDim3Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleQuoteItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND name = N'IX_pStyleQuoteItem_StyleID')
DROP INDEX [IX_pStyleQuoteItem_StyleID] ON [dbo].[pStyleQuoteItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItem_StyleID] ON [dbo].[pStyleQuoteItem] 
(
	[StyleID] ASC,
	[TradePartnerID] ASC,
	[StyleQuoteItemShare] ASC
)
INCLUDE ( [StyleQuoteItemNo],
[StyleQuoteItemStatusId],
[TradePartnerVendorID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND name = N'IX_pStyleQuoteItem_SourcingHeaderID')
DROP INDEX [IX_pStyleQuoteItem_SourcingHeaderID] ON [dbo].[pStyleQuoteItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItem_SourcingHeaderID] ON [dbo].[pStyleQuoteItem] 
(
	[SourcingHeaderID] ASC,
	[StyleQuoteTradePartnerID] ASC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND name = N'IX_pStyleQuoteItem_SourcingHeaderID_StyleID')
DROP INDEX [IX_pStyleQuoteItem_SourcingHeaderID_StyleID] ON [dbo].[pStyleQuoteItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItem_SourcingHeaderID_StyleID] ON [dbo].[pStyleQuoteItem] 
(
	[SourcingHeaderID] ASC,
	[StyleID] ASC
)
INCLUDE([StyleQuoteItemNo],[StyleQuoteItemStatusId],[StyleQuoteTradePartnerID],[StyleColorID],[StyleSourcingID])WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND name = N'IX_pStyleQuoteItem_StyleQuoteTradePartnerID')
DROP INDEX [IX_pStyleQuoteItem_StyleQuoteTradePartnerID] ON [dbo].[pStyleQuoteItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItem_StyleQuoteTradePartnerID] ON [dbo].[pStyleQuoteItem] 
(
	[StyleQuoteTradePartnerID] ASC,
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** pStyleQuoteItemStatus ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemStatus]') AND name = N'IX_pStyleQuoteItemStatus_CustomKey')
DROP INDEX [IX_pStyleQuoteItemStatus_CustomKey] ON [dbo].[pStyleQuoteItemStatus] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItemStatus_CustomKey] ON [dbo].[pStyleQuoteItemStatus] 
(
	[CustomKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHistory]') AND name = N'IX_pSourcingHistory_TeamID')
DROP INDEX [IX_pSourcingHistory_TeamID] ON [dbo].[pSourcingHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingHistory_TeamID] ON [dbo].[pSourcingHistory] 
(
	[TeamID] ASC,
	[CDate] DESC
)
INCLUDE ( [SourcingHeaderID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingType ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingType]') AND name = N'PK_pSourcingType')
ALTER TABLE [dbo].[pSourcingType] DROP CONSTRAINT [PK_pSourcingType]
GO

ALTER TABLE [dbo].[pSourcingType] ADD  CONSTRAINT [PK_pSourcingType] PRIMARY KEY CLUSTERED 
(
	[SourcingTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pSourcingHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHeader]') AND name = N'IX_pSourcingHeader_SourcingType')
DROP INDEX [IX_pSourcingHeader_SourcingType] ON [dbo].[pSourcingHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingHeader_SourcingType] ON [dbo].[pSourcingHeader] 
(
	[SourcingType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHeader]') AND name = N'IX_pSourcingHeader_SeasonYearID')
DROP INDEX [IX_pSourcingHeader_SeasonYearID] ON [dbo].[pSourcingHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingHeader_SeasonYearID] ON [dbo].[pSourcingHeader] 
(
	[seasonYearId] ASC
)
INCLUDE ( [Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** pSourcingStyle ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingStyle]') AND name = N'IX_pSourcingStyle_SourcingHeaderID')
DROP INDEX [IX_pSourcingStyle_SourcingHeaderID] ON [dbo].[pSourcingStyle] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingStyle_SourcingHeaderID] ON [dbo].[pSourcingStyle] 
(
	[SourcingHeaderID] ASC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingTradePartner ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingTradePartner]') AND name = N'IX_pSourcingTradePartner_SourcingHeaderID')
DROP INDEX [IX_pSourcingTradePartner_SourcingHeaderID] ON [dbo].[pSourcingTradePartner] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingTradePartner_SourcingHeaderID] ON [dbo].[pSourcingTradePartner] 
(
	[SourcingHeaderID] ASC,
	[TradePartnerLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingAdditionalCost ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingAdditionalCost]') AND name = N'IX_pSourcingAdditionalCost_QuoteItemID')
DROP INDEX [IX_pSourcingAdditionalCost_QuoteItemID] ON [dbo].[pSourcingAdditionalCost] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingAdditionalCost_QuoteItemID] ON [dbo].[pSourcingAdditionalCost] 
(
	[QuoteItemID] ASC
)
INCLUDE ( [Amount]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentItem]') AND name = N'IX_pSourcingCommitmentItem_StyleQuoteItemID')
DROP INDEX [IX_pSourcingCommitmentItem_StyleQuoteItemID] ON [dbo].[pSourcingCommitmentItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentItem_StyleQuoteItemID] ON [dbo].[pSourcingCommitmentItem] 
(
	[StyleQuoteItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentItem]') AND name = N'IX_pSourcingCommitmentItem_SourcingHeaderID')
DROP INDEX [IX_pSourcingCommitmentItem_SourcingHeaderID] ON [dbo].[pSourcingCommitmentItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentItem_SourcingHeaderID] ON [dbo].[pSourcingCommitmentItem] 
(
	[SourcingHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingQuoteStyleBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuoteStyleBOM]') AND name = N'IX_pSourcingQuoteStyleBOM_StyleQuoteItemID')
DROP INDEX [IX_pSourcingQuoteStyleBOM_StyleQuoteItemID] ON [dbo].[pSourcingQuoteStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingQuoteStyleBOM_StyleQuoteItemID] ON [dbo].[pSourcingQuoteStyleBOM] 
(
	[StyleQuoteItemID] ASC,
	[StyleBOMDimensionID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[NotShow],
[StyleBOMDimensionItemID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingQuotationBOMOption ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuotationBOMOption]') AND name = N'IX_pSourcingQuotationBOMOption_StyleQuoteItemID')
DROP INDEX [IX_pSourcingQuotationBOMOption_StyleQuoteItemID] ON [dbo].[pSourcingQuotationBOMOption] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingQuotationBOMOption_StyleQuoteItemID] ON [dbo].[pSourcingQuotationBOMOption] 
(
	[StyleQuoteItemID] ASC
)
INCLUDE ( [OptionNo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCostOption ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCostOption]') AND name = N'PK_pSourcingCostOption')
ALTER TABLE [dbo].[pSourcingCostOption] DROP CONSTRAINT [PK_pSourcingCostOption]
GO

ALTER TABLE [dbo].[pSourcingCostOption] ADD  CONSTRAINT [PK_pSourcingCostOption] PRIMARY KEY CLUSTERED 
(
	[SourcingCostOptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCostOption]') AND name = N'IX_pSourcingCostOption_StyleQuoteItemID')
DROP INDEX [IX_pSourcingCostOption_StyleQuoteItemID] ON [dbo].[pSourcingCostOption] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCostOption_StyleQuoteItemID] ON [dbo].[pSourcingCostOption] 
(
	[StyleQuoteItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleQuoteDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteDocument]') AND name = N'IX_pStyleQuoteDocument_StyleQuoteItemID')
DROP INDEX [IX_pStyleQuoteDocument_StyleQuoteItemID] ON [dbo].[pStyleQuoteDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteDocument_StyleQuoteItemID] ON [dbo].[pStyleQuoteDocument] 
(
	[StyleQuoteItemID] ASC,
	[MDate] DESC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleQuoteComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteComment]') AND name = N'IX_pStyleQuoteComment_StyleQuoteItemiD')
DROP INDEX [IX_pStyleQuoteComment_StyleQuoteItemiD] ON [dbo].[pStyleQuoteComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteComment_StyleQuoteItemiD] ON [dbo].[pStyleQuoteComment] 
(
	[StyleQuoteItemID] ASC,
	[MDate] DESC
)
INCLUDE ( [CommentType],
[StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentBOMDetails ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOMDetails]') AND name = N'IX_pSourcingCommitmentBOMDetails_SourcingCommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentBOMDetails_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentBOMDetails] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentBOMDetails_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentBOMDetails] 
(
	[SourcingCommitmentItemID] ASC,
	[StyleBOMDimensionId] ASC
)
INCLUDE ( [StyleQuoteItemID],
[SourcingHeaderId],
[ItemDim1Active],
[ItemDim2Active],
[ItemDim3Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOM]') AND name = N'IX_pSourcingCommitmentBOM_SourcingCommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentBOM_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentBOM_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentBOM] 
(
	[SourcingCommitmentItemID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[NotShow]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentAdditionalCost ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentAdditionalCost]') AND name = N'IX_pSourcingCommitmentAdditionalCost_CommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentAdditionalCost_CommitmentItemID] ON [dbo].[pSourcingCommitmentAdditionalCost] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentAdditionalCost_CommitmentItemID] ON [dbo].[pSourcingCommitmentAdditionalCost] 
(
	[CommitmentItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentDocument]') AND name = N'IX_pSourcingCommitmentDocument_SourcingCommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentDocument_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentDocument_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentDocument] 
(
	[SourcingCommitmentItemID] ASC,
	[MDate] DESC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentComment]') AND name = N'IX_pSourcingCommitmentComment_SourcingCommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentComment_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentComment_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentComment] 
(
	[SourcingCommitmentItemID] ASC,
	[CommentType] ASC,
	[MDate] DESC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentBOMOption ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOMOption]') AND name = N'IX_pSourcingCommitmentBOMOption_SourcingCommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentBOMOption_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentBOMOption] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentBOMOption_SourcingCommitmentItemID] ON [dbo].[pSourcingCommitmentBOMOption] 
(
	[SourcingCommitmentItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pSourcingCommitmentBOMOptionItems ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOMOptionItems]') AND name = N'IX_pSourcingCommitmentBOMOptionItems_SourcingCommitmentBOMOptionID')
DROP INDEX [IX_pSourcingCommitmentBOMOptionItems_SourcingCommitmentBOMOptionID] ON [dbo].[pSourcingCommitmentBOMOptionItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentBOMOptionItems_SourcingCommitmentBOMOptionID] ON [dbo].[pSourcingCommitmentBOMOptionItems] 
(
	[SourcingCommitmentBOMOptionID] ASC
)
INCLUDE ( [StyleMaterialID],
[MainMaterial],
[MaterialNo],
[MaterialName],
[MaterialSort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentCostOption ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentCostOption]') AND name = N'PK_pSourcingCommitmentCostOption')
ALTER TABLE [dbo].[pSourcingCommitmentCostOption] DROP CONSTRAINT [PK_pSourcingCommitmentCostOption]
GO

ALTER TABLE [dbo].[pSourcingCommitmentCostOption] ADD  CONSTRAINT [PK_pSourcingCommitmentCostOption] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentCostOptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentCostOption]') AND name = N'IX_pSourcingCommitmentCostOption_CommitmentItemID')
DROP INDEX [IX_pSourcingCommitmentCostOption_CommitmentItemID] ON [dbo].[pSourcingCommitmentCostOption] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentCostOption_CommitmentItemID] ON [dbo].[pSourcingCommitmentCostOption] 
(
	[CommitmentItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSourcingCommitmentCostOptionDetail ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentCostOptionDetail]') AND name = N'PK_pSourcingCommitmentCostOptionDetail')
ALTER TABLE [dbo].[pSourcingCommitmentCostOptionDetail] DROP CONSTRAINT [PK_pSourcingCommitmentCostOptionDetail]
GO

ALTER TABLE [dbo].[pSourcingCommitmentCostOptionDetail] ADD  CONSTRAINT [PK_pSourcingCommitmentCostOptionDetail] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentCostOptionDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentCostOptionDetail]') AND name = N'IX_pSourcingCommitmentCostOptionDetail_SourcingCommitmentCostOptionID')
DROP INDEX [IX_pSourcingCommitmentCostOptionDetail_SourcingCommitmentCostOptionID] ON [dbo].[pSourcingCommitmentCostOptionDetail] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSourcingCommitmentCostOptionDetail_SourcingCommitmentCostOptionID] ON [dbo].[pSourcingCommitmentCostOptionDetail] 
(
	[SourcingCommitmentCostOptionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09054', GetDate())
GO
