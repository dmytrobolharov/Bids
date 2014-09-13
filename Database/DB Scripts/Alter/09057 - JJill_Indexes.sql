IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorPalette]') AND name = N'IX_pColorPalette_07')
DROP INDEX [IX_pColorPalette_07] ON [dbo].[pColorPalette] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorPalette_07] ON [dbo].[pColorPalette] 
(
	[ColorLibraryID] ASC,
	[ColorFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMSEvalHeader]') AND name = N'IX_pMSEvalHeader_05')
DROP INDEX [IX_pMSEvalHeader_05] ON [dbo].[pMSEvalHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMSEvalHeader_05] ON [dbo].[pMSEvalHeader] 
(
	[SampleRequestWorkflowID] ASC,
	[StyleId] ASC,
	[StyleSet] ASC,
	[SampleRequestTradeID] ASC,
	[SampleWorkflowID] ASC
)
INCLUDE ( [SampleRequestHeaderId],
[TradePartnerVendorID],
[WorkflowID],
[WorkFlowItemId],
[StyleColorID],
[AMLMeasHdrId],
[Submit]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOM]') AND name = N'IX_pSampleRequestSubmitBOM_05')
DROP INDEX [IX_pSampleRequestSubmitBOM_05] ON [dbo].[pSampleRequestSubmitBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestSubmitBOM_05] ON [dbo].[pSampleRequestSubmitBOM] 
(
	[Status] ASC,
	[SampleWorkflowID] ASC,
	[Submit] ASC,
	[StyleSet] ASC,
	[SampleRequestTradeID] ASC,
	[StyleID] ASC,
	[SampleRequestWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimension]') AND name = N'IX_pStyleBOMDimension_05')
DROP INDEX [IX_pStyleBOMDimension_05] ON [dbo].[pStyleBOMDimension] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimension_05] ON [dbo].[pStyleBOMDimension] 
(
	[WorkFlowItemID] ASC,
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkFlowID] ASC
)
INCLUDE ( [StyleBOMDimensionID],
[ItemDim1TypeId],
[ItemDim2TypeId],
[ItemDim3TypeId],
[ItemDim1TypeName],
[ItemDim2TypeName],
[ItemDim3TypeName],
[Comments],
[ImageId],
[CDate],
[CUser],
[MDate],
[MUser],
[IsAvgQuantity],
[AverageCost],
[StyleBOMDimensionCopyMasterID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND name = N'IX_pStyleQuoteItem_05')
DROP INDEX [IX_pStyleQuoteItem_05] ON [dbo].[pStyleQuoteItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItem_05] ON [dbo].[pStyleQuoteItem] 
(
	[StyleID] ASC,
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND name = N'IX_pStyleWorkflow_05')
DROP INDEX [IX_pStyleWorkflow_05] ON [dbo].[pStyleWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflow_05] ON [dbo].[pStyleWorkflow] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_Users_05')
DROP INDEX [IX_Users_05] ON [dbo].[Users] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_Users_05] ON [dbo].[Users] 
(
	[Active] ASC,
	[Title] ASC,
	[FULLNAME] ASC
)
INCLUDE ( [FirstName],
[LastName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_Users_06')
DROP INDEX [IX_Users_06] ON [dbo].[Users] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_Users_06] ON [dbo].[Users] 
(
	[UserId] ASC,
	[FirstName] ASC,
	[LastName] ASC,
	[Email] ASC
)
INCLUDE ( [Title],
[Active],
[TradePartner]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartner]') AND name = N'IX_uTradePartner_05')
DROP INDEX [IX_uTradePartner_05] ON [dbo].[uTradePartner] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uTradePartner_05] ON [dbo].[uTradePartner] 
(
	[TradePartnerRelationshipType] ASC,
	[Active] ASC,
	[TradePartnerName] ASC
)
INCLUDE ( [TradePartnerCode]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09057', GetDate())
GO
