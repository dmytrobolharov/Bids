/*** pSampleRequestBOMTrade ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestBOMTrade]') AND name = N'IX_pSampleRequestBOMTrade_StyleBOMDimensionID')
DROP INDEX [IX_pSampleRequestBOMTrade_StyleBOMDimensionID] ON [dbo].[pSampleRequestBOMTrade] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestBOMTrade_StyleBOMDimensionID] ON [dbo].[pSampleRequestBOMTrade] 
(
	[StyleBOMDimensionID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestBOMTrade]') AND name = N'IX_pSampleRequestBOMTrade_StyleID')
DROP INDEX [IX_pSampleRequestBOMTrade_StyleID] ON [dbo].[pSampleRequestBOMTrade] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestBOMTrade_StyleID] ON [dbo].[pSampleRequestBOMTrade] 
(
	[StyleID] ASC,
	[SampleRequestShare] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[TradePartnerRelationshipLevelID],
[StyleSeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestBOMTrade]') AND name = N'IX_pSampleRequestBOMTrade_StyleSeasonYearID')
DROP INDEX [IX_pSampleRequestBOMTrade_StyleSeasonYearID] ON [dbo].[pSampleRequestBOMTrade] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestBOMTrade_StyleSeasonYearID] ON [dbo].[pSampleRequestBOMTrade] 
(
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pSampleRequestSubmitBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOM]') AND name = N'IX_pSampleRequestSubmitBOM_SampleRequestTradeID')
DROP INDEX [IX_pSampleRequestSubmitBOM_SampleRequestTradeID] ON [dbo].[pSampleRequestSubmitBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestSubmitBOM_SampleRequestTradeID] ON [dbo].[pSampleRequestSubmitBOM] 
(
	[SampleRequestTradeID] ASC
)
INCLUDE ( [StyleID],
[ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOM]') AND name = N'IX_pSampleRequestSubmitBOM_SampleRequestWorkflowID')
DROP INDEX [IX_pSampleRequestSubmitBOM_SampleRequestWorkflowID] ON [dbo].[pSampleRequestSubmitBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestSubmitBOM_SampleRequestWorkflowID] ON [dbo].[pSampleRequestSubmitBOM] 
(
	[SampleRequestWorkflowID] ASC,
	[Submit] ASC
)
INCLUDE ( [SampleRequestSubmitID],
[SampleRequestTradeID],
[SampleWorkflowID],
[StyleID],
[StyleSet],
[Status],
[AssignedTo],
[DueDate],
[EndDate],
[MDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pSampleRequestWorkflowBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOM]') AND name = N'IX_pSampleRequestWorkflowBOM_1')
DROP INDEX [IX_pSampleRequestWorkflowBOM_1] ON [dbo].[pSampleRequestWorkflowBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestWorkflowBOM_1] ON [dbo].[pSampleRequestWorkflowBOM] 
(
	[StyleID] ASC
)
INCLUDE ( [SampleWorkflowID],
[SampleRequestTradeID],
[AssignedTo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleWorkflowViewAgent ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleWorkflowViewAgent]') AND name = N'IX_pSampleWorkflowViewAgent_TeamID')
DROP INDEX [IX_pSampleWorkflowViewAgent_TeamID] ON [dbo].[pSampleWorkflowViewAgent] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleWorkflowViewAgent_TeamID] ON [dbo].[pSampleWorkflowViewAgent] 
(
	[TeamId] ASC
)
INCLUDE ( [TradePartnerId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleWorkflowViewSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleWorkflowViewSubmit]') AND name = N'IX_pSampleWorkflowViewSubmit_TeamID')
DROP INDEX [IX_pSampleWorkflowViewSubmit_TeamID] ON [dbo].[pSampleWorkflowViewSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleWorkflowViewSubmit_TeamID] ON [dbo].[pSampleWorkflowViewSubmit] 
(
	[TeamId] ASC
)
INCLUDE ( [SampleWorkflowId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleRequestComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestComment]') AND name = N'IX_pSampleRequestComment_SampleRequestWorkflowID')
DROP INDEX [IX_pSampleRequestComment_SampleRequestWorkflowID] ON [dbo].[pSampleRequestComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestComment_SampleRequestWorkflowID] ON [dbo].[pSampleRequestComment] 
(
	[SampleRequestWorkflowID] ASC,
	[SampleCommentType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09049', GetDate())
GO
