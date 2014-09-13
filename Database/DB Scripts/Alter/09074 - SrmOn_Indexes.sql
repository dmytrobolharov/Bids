/*** These are indexes useful in SrmOn project ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflow]') AND name = N'IX_pSampleRequestWorkflow_Status')
DROP INDEX [IX_pSampleRequestWorkflow_Status] ON [dbo].[pSampleRequestWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestWorkflow_Status] ON [dbo].[pSampleRequestWorkflow] 
(
	[Status] ASC,
	[DueDate] ASC
)
INCLUDE ( [SampleRequestTradeID],
[SampleWorkflowID],
[StyleID],
[StyleSet],
[Submit]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleRequestWorkflowBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOM]') AND name = N'IX_pSampleRequestWorkflowBOM_Status')
DROP INDEX [IX_pSampleRequestWorkflowBOM_Status] ON [dbo].[pSampleRequestWorkflowBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestWorkflowBOM_Status] ON [dbo].[pSampleRequestWorkflowBOM] 
(
	[Status] ASC,
	[DueDate] ASC
)
INCLUDE ( [SampleRequestTradeID],
[SampleWorkflowID],
[StyleID],
[StyleSet],
[Submit]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** hCommitmentHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[hCommitmentHistory]') AND name = N'IX_hCommitmentHistory_TeamID')
DROP INDEX [IX_hCommitmentHistory_TeamID] ON [dbo].[hCommitmentHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_hCommitmentHistory_TeamID] ON [dbo].[hCommitmentHistory] 
(
	[TeamId] ASC
)
INCLUDE ( [CommitmentItemId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleQuoteItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND name = N'IX_pStyleQuoteItem_StyleQuoteItemShare')
DROP INDEX [IX_pStyleQuoteItem_StyleQuoteItemShare] ON [dbo].[pStyleQuoteItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleQuoteItem_StyleQuoteItemShare] ON [dbo].[pStyleQuoteItem] 
(
	[StyleQuoteItemShare] ASC,
	[TradePartnerID] ASC,
	[StyleQuoteItemStatusId] ASC,
	[TradePartnerVendorID] ASC,
	[StyleQuoteItemApprovedDate] ASC
)
INCLUDE ( [StyleQuoteID],
[StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmitWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND name = N'IX_pMaterialRequestSubmitWorkflow_TradePartnerID')
DROP INDEX [IX_pMaterialRequestSubmitWorkflow_TradePartnerID] ON [dbo].[pMaterialRequestSubmitWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitWorkflow_TradePartnerID] ON [dbo].[pMaterialRequestSubmitWorkflow] 
(
	[TradePartnerID] ASC
)
INCLUDE ( [MaterialRequestWorkflowID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleTeam ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTeam]') AND name = N'IX_pStyleTeam_TeamID')
DROP INDEX [IX_pStyleTeam_TeamID] ON [dbo].[pStyleTeam] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleTeam_TeamID] ON [dbo].[pStyleTeam] 
(
	[TeamID] ASC,
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** hSampleHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[hSampleHistory]') AND name = N'IX_hSampleHistory_TeamID')
DROP INDEX [IX_hSampleHistory_TeamID] ON [dbo].[hSampleHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_hSampleHistory_TeamID] ON [dbo].[hSampleHistory] 
(
	[TeamId] ASC,
	[CDate] DESC
)
INCLUDE ( [StyleId],
[SampleRequestTradeId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleRequestWorkflowBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOM]') AND name = N'IX_pSampleRequestWorkflowBOM_SampleWorkflowID')
DROP INDEX [IX_pSampleRequestWorkflowBOM_SampleWorkflowID] ON [dbo].[pSampleRequestWorkflowBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestWorkflowBOM_SampleWorkflowID] ON [dbo].[pSampleRequestWorkflowBOM] 
(
	[SampleWorkflowID] ASC
)
INCLUDE ( [SampleRequestTradeID],
[StyleID],
[StyleSet],
[TradePartnerID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09074', GetDate())
GO
