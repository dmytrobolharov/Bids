IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOM]') AND name = N'IX_pStyleBOM_WorkflowItemID')
DROP INDEX [IX_pStyleBOM_WorkflowItemID] ON [dbo].[pStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOM_WorkflowItemID] ON [dbo].[pStyleBOM] 
(
	[WorkflowItemId] ASC
)
INCLUDE ( [StyleID], [MaterialID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialTradePartner ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartner]') AND name = N'IX_pMaterialTradePartner_SeasonYearID')
DROP INDEX [IX_pMaterialTradePartner_SeasonYearID] ON [dbo].[pMaterialTradePartner] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartner_SeasonYearID] ON [dbo].[pMaterialTradePartner] 
(
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmitWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND name = N'IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerID')
DROP INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmitWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmitWorkflow] 
(
	[MaterialTradePartnerID] ASC
)
INCLUDE ( [MaterialRequestWorkflowID],
[MaterialRequestSubmitAllColors],
[MaterialID],
[Status],
[DueDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_MaterialRequestSubmitWorkflowID')
DROP INDEX [IX_pMaterialRequestSubmit_MaterialRequestSubmitWorkflowID] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_MaterialRequestSubmitWorkflowID] ON [dbo].[pMaterialRequestSubmit] 
(
	[MaterialRequestSubmitWorkflowID] ASC
)
INCLUDE ( [MaterialTradePartnerID],
[Submit],
[AgentView],
[DueDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pSampleRequestWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflow]') AND name = N'IX_pSampleRequestWorkflow_StyleID')
DROP INDEX [IX_pSampleRequestWorkflow_StyleID] ON [dbo].[pSampleRequestWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestWorkflow_StyleID] ON [dbo].[pSampleRequestWorkflow] 
(
	[StyleID] ASC
)
INCLUDE ( [SampleWorkflowID],
[SampleRequestTradeID],
[AssignedTo],
[Status],
[DueDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
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
[AssignedTo],
[Status],
[DueDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_MaterialTradePartnerColorID')
DROP INDEX [IX_pMaterialRequestSubmit_MaterialTradePartnerColorID] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_MaterialTradePartnerColorID] ON [dbo].[pMaterialRequestSubmit] 
(
	[MaterialTradePartnerColorID] ASC
)
INCLUDE ( [MaterialRequestSubmitWorkflowID],
[Submit],
[DueDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleRequestTrade ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestTrade]') AND name = N'IX_pSampleRequestTrade_StyleSeasonYearID')
DROP INDEX [IX_pSampleRequestTrade_StyleSeasonYearID] ON [dbo].[pSampleRequestTrade] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestTrade_StyleSeasonYearID] ON [dbo].[pSampleRequestTrade] 
(
	[StyleSeasonYearID] ASC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pSampleRequestBOMTrade ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestBOMTrade]') AND name = N'IX_pSampleRequestBOMTrade_StyleSeasonYearID')
DROP INDEX [IX_pSampleRequestBOMTrade_StyleSeasonYearID] ON [dbo].[pSampleRequestBOMTrade] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestBOMTrade_StyleSeasonYearID] ON [dbo].[pSampleRequestBOMTrade] 
(
	[StyleSeasonYearID] ASC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOM]') AND name = N'IX_pStyleBOM_MainMaterial')
DROP INDEX [IX_pStyleBOM_MainMaterial] ON [dbo].[pStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOM_MainMaterial] ON [dbo].[pStyleBOM] 
(
	[MainMaterial] ASC
)
INCLUDE ( [StyleID],
[StyleBOMDimensionId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTechPack ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTechPack]') AND name = N'IX_pTechPack_StyleSeasonYearID')
DROP INDEX [IX_pTechPack_StyleSeasonYearID] ON [dbo].[pTechPack] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTechPack_StyleSeasonYearID] ON [dbo].[pTechPack] 
(
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleCostingHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingHeader]') AND name = N'IX_pStyleCostingHeader_StyleSeasonYearID')
DROP INDEX [IX_pStyleCostingHeader_StyleSeasonYearID] ON [dbo].[pStyleCostingHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCostingHeader_StyleSeasonYearID] ON [dbo].[pStyleCostingHeader] 
(
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND name = N'IX_pStyleWorkflow_StyleID')
DROP INDEX [IX_pStyleWorkflow_StyleID] ON [dbo].[pStyleWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflow_StyleID] ON [dbo].[pStyleWorkflow] 
(
	[StyleID] ASC
)
INCLUDE ( [StyleSet],
[WorkAssignedTo],
[WorkStatus],
[WorkflowID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND name = N'IX_pStyleHeader_DivisionID')
DROP INDEX [IX_pStyleHeader_DivisionID] ON [dbo].[pStyleHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHeader_DivisionID] ON [dbo].[pStyleHeader] 
(
	[DivisionID] ASC,
	[StyleType] ASC,
	[StyleCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialColor ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColor]') AND name = N'IX_pMaterialColor_ColorPaletteID')
DROP INDEX [IX_pMaterialColor_ColorPaletteID] ON [dbo].[pMaterialColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialColor_ColorPaletteID] ON [dbo].[pMaterialColor] 
(
	[ColorPaletteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSeasonYear]') AND name = N'IX_pMaterialSeasonYear_SeasonYearID')
DROP INDEX [IX_pMaterialSeasonYear_SeasonYearID] ON [dbo].[pMaterialSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialSeasonYear_SeasonYearID] ON [dbo].[pMaterialSeasonYear] 
(
	[SeasonYearID] ASC,
	[MaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_Status')
DROP INDEX [IX_pMaterialRequestSubmit_Status] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_Status] ON [dbo].[pMaterialRequestSubmit] 
(
	[Status] ASC
)
INCLUDE ( [MaterialRequestSubmitWorkflowID],
[Submit]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_Status')
DROP INDEX [IX_pMaterialRequestSubmit_Status] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_Status] ON [dbo].[pMaterialRequestSubmit] 
(
	[Status] ASC,
	[DueDate] ASC
)
INCLUDE ( [MaterialRequestSubmitWorkflowID],
[Submit]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pColorPaletteSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorPaletteSeasonYear]') AND name = N'IX_pColorPaletteSeasonYear_SeasonYearID')
DROP INDEX [IX_pColorPaletteSeasonYear_SeasonYearID] ON [dbo].[pColorPaletteSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorPaletteSeasonYear_SeasonYearID] ON [dbo].[pColorPaletteSeasonYear] 
(
	[SeasonYearID] ASC
)
INCLUDE ( [ColorPaletteID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pSampleRequestSubmitBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOM]') AND name = N'IX_pSampleRequestSubmitBOM_Status')
DROP INDEX [IX_pSampleRequestSubmitBOM_Status] ON [dbo].[pSampleRequestSubmitBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSampleRequestSubmitBOM_Status] ON [dbo].[pSampleRequestSubmitBOM] 
(
	[Status] ASC,
	[DueDate] ASC
)
INCLUDE ( [SampleRequestWorkflowID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09067', GetDate())
GO


