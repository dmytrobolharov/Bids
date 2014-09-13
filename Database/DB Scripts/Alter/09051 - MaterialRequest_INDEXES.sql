/*** pMaterialTradePartnerColor ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerColor]') AND name = N'IX_pMaterialTradePartnerColor_MaterialID')
DROP INDEX [IX_pMaterialTradePartnerColor_MaterialID] ON [dbo].[pMaterialTradePartnerColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartnerColor_MaterialID] ON [dbo].[pMaterialTradePartnerColor] 
(
	[MaterialID] ASC,
	[MaterialTradePartnerID] ASC,
	[MaterialColorID] ASC,
	[MaterialSizeID] ASC
)
INCLUDE ( [MaterialTradeColor7],
[MaterialTradeColor8]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerColor]') AND name = N'IX_pMaterialTradePartnerColor_MaterialColorID')
DROP INDEX [IX_pMaterialTradePartnerColor_MaterialColorID] ON [dbo].[pMaterialTradePartnerColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartnerColor_MaterialColorID] ON [dbo].[pMaterialTradePartnerColor] 
(
	[MaterialColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerColor]') AND name = N'IX_pMaterialTradePartnerColor_MaterialTradePartnerID')
DROP INDEX [IX_pMaterialTradePartnerColor_MaterialTradePartnerID] ON [dbo].[pMaterialTradePartnerColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartnerColor_MaterialTradePartnerID] ON [dbo].[pMaterialTradePartnerColor] 
(
	[MaterialTradePartnerID] ASC
)
INCLUDE([MaterialColorID], [MaterialSizeID], [ColorPaletteID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerColor]') AND name = N'IX_pMaterialTradePartnerColor_MaterialSizeID')
DROP INDEX [IX_pMaterialTradePartnerColor_MaterialSizeID] ON [dbo].[pMaterialTradePartnerColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartnerColor_MaterialSizeID] ON [dbo].[pMaterialTradePartnerColor] 
(
	[MaterialSizeID] ASC
)
INCLUDE ( [MaterialColorID],
[MaterialTradePartnerID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pMaterialSampleWorkflowViewAgent ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSampleWorkflowViewAgent]') AND name = N'IX_pMaterialSampleWorkflowViewAgent_TeamID')
DROP INDEX [IX_pMaterialSampleWorkflowViewAgent_TeamID] ON [dbo].[pMaterialSampleWorkflowViewAgent] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialSampleWorkflowViewAgent_TeamID] ON [dbo].[pMaterialSampleWorkflowViewAgent] 
(
	[TeamId] ASC
)
INCLUDE ( [TradePartnerId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialSampleWorkflowViewSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSampleWorkflowViewSubmit]') AND name = N'IX_pMaterialSampleWorkflowViewSubmit_TeamID')
DROP INDEX [IX_pMaterialSampleWorkflowViewSubmit_TeamID] ON [dbo].[pMaterialSampleWorkflowViewSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialSampleWorkflowViewSubmit_TeamID] ON [dbo].[pMaterialSampleWorkflowViewSubmit] 
(
	[TeamId] ASC
)
INCLUDE ( [SampleWorkflowId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmit ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_AssignedTo')
DROP INDEX [IX_pMaterialRequestSubmit_AssignedTo] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_AssignedTo] ON [dbo].[pMaterialRequestSubmit] 
(
	[AssignedTo] ASC,
	[Submit] ASC
)
INCLUDE ( [MaterialRequestSubmitWorkflowID],
[MaterialTradePartnerColorID],
[MaterialTradePartnerID],
[EndDate],
[Status]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_MaterialRequestSubmitWorkflowID')
DROP INDEX [IX_pMaterialRequestSubmit_MaterialRequestSubmitWorkflowID] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_MaterialRequestSubmitWorkflowID] ON [dbo].[pMaterialRequestSubmit] 
(
	[MaterialRequestSubmitWorkflowID] ASC
)
INCLUDE ( [MaterialTradePartnerID],
[Submit],
[AgentView]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND name = N'IX_pMaterialRequestSubmit_MaterialTradePartnerID')
DROP INDEX [IX_pMaterialRequestSubmit_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmit] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmit_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmit] 
(
	[MaterialTradePartnerID] ASC
)
INCLUDE ( [MaterialTradePartnerColorID],
[MaterialRequestSubmitWorkflowID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmitWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND name = N'IX_pMaterialRequestSubmitWorkflow_Status')
DROP INDEX [IX_pMaterialRequestSubmitWorkflow_Status] ON [dbo].[pMaterialRequestSubmitWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitWorkflow_Status] ON [dbo].[pMaterialRequestSubmitWorkflow] 
(
	[Status] ASC,
	[DueDate] ASC
)
INCLUDE ( [MaterialTradePartnerColorID],
[MaterialRequestWorkflowID],
[Submit],
[AssignedTo],
[MaterialTradePartnerID],
[MaterialID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND name = N'IX_pMaterialRequestSubmitWorkflow_MaterialID')
DROP INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialID] ON [dbo].[pMaterialRequestSubmitWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialID] ON [dbo].[pMaterialRequestSubmitWorkflow] 
(
	[MaterialID] ASC
)
INCLUDE ( [MaterialRequestWorkflowID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND name = N'IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerColorID')
DROP INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerColorID] ON [dbo].[pMaterialRequestSubmitWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerColorID] ON [dbo].[pMaterialRequestSubmitWorkflow] 
(
	[MaterialTradePartnerColorID] ASC
)
INCLUDE ( [MaterialRequestWorkflowID],
[MaterialTradePartnerID],
[TradePartnerID],
[MaterialID],
[Status],
[Submit],
[DueDate],
[EndDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND name = N'IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerID')
DROP INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmitWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitWorkflow_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmitWorkflow] 
(
	[MaterialTradePartnerID] ASC
)
INCLUDE ( [MaterialRequestWorkflowID], [MaterialRequestSubmitAllColors]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pMaterialRequestWorkflowTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestWorkflowTemplateItem]') AND name = N'IX_pMaterialRequestWorkflowTemplateItem_MaterialRequestWorkflowTempID')
DROP INDEX [IX_pMaterialRequestWorkflowTemplateItem_MaterialRequestWorkflowTempID] ON [dbo].[pMaterialRequestWorkflowTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestWorkflowTemplateItem_MaterialRequestWorkflowTempID] ON [dbo].[pMaterialRequestWorkflowTemplateItem] 
(
	[MaterialRequestWorkflowTempID] ASC,
	[MaterialRequestWorkflowID] ASC
)
INCLUDE ( [MaterialRequestWorkflowSort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestTemp ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestTemp]') AND name = N'IX_pMaterialRequestTemp_MaterialRequestGroupID')
DROP INDEX [IX_pMaterialRequestTemp_MaterialRequestGroupID] ON [dbo].[pMaterialRequestTemp] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestTemp_MaterialRequestGroupID] ON [dbo].[pMaterialRequestTemp] 
(
	[MaterialRequestGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSeasonColorTemp ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSeasonColorTemp]') AND name = N'IX_pMaterialRequestSeasonColorTemp_MaterialRequestGroupID')
DROP INDEX [IX_pMaterialRequestSeasonColorTemp_MaterialRequestGroupID] ON [dbo].[pMaterialRequestSeasonColorTemp] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSeasonColorTemp_MaterialRequestGroupID] ON [dbo].[pMaterialRequestSeasonColorTemp] 
(
	[MaterialRequestGroupID] ASC
)
INCLUDE ( [MaterialID],
[SeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestDocument]') AND name = N'IX_pMaterialRequestDocument_MaterialID')
DROP INDEX [IX_pMaterialRequestDocument_MaterialID] ON [dbo].[pMaterialRequestDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestDocument_MaterialID] ON [dbo].[pMaterialRequestDocument] 
(
	[MaterialID] ASC,
	[MaterialRequestSubmitWorkflowID] ASC
)
INCLUDE ( [MaterialTradePartnerID],
[MaterialTradePartnerColorID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmitGroup ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitGroup]') AND name = N'IX_pMaterialRequestSubmitGroup_MaterialTradePartnerID')
DROP INDEX [IX_pMaterialRequestSubmitGroup_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmitGroup] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitGroup_MaterialTradePartnerID] ON [dbo].[pMaterialRequestSubmitGroup] 
(
	[MaterialTradePartnerID] ASC,
	[MaterialRequestWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmitComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitComment]') AND name = N'IX_pMaterialRequestSubmitComment_MaterialRequestSubmitID')
DROP INDEX [IX_pMaterialRequestSubmitComment_MaterialRequestSubmitID] ON [dbo].[pMaterialRequestSubmitComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitComment_MaterialRequestSubmitID] ON [dbo].[pMaterialRequestSubmitComment] 
(
	[MaterialRequestSubmitID] ASC,
	[MDate] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pMaterialRequestSubmitDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitDocument]') AND name = N'IX_pMaterialRequestSubmitDocument_MaterialRequestSubmitID')
DROP INDEX [IX_pMaterialRequestSubmitDocument_MaterialRequestSubmitID] ON [dbo].[pMaterialRequestSubmitDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitDocument_MaterialRequestSubmitID] ON [dbo].[pMaterialRequestSubmitDocument] 
(
	[MaterialRequestSubmitID] ASC,
	[CDate] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialRequestSubmitItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitItem]') AND name = N'IX_pMaterialRequestSubmitItem_MaterialRequestSubmitID')
DROP INDEX [IX_pMaterialRequestSubmitItem_MaterialRequestSubmitID] ON [dbo].[pMaterialRequestSubmitItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialRequestSubmitItem_MaterialRequestSubmitID] ON [dbo].[pMaterialRequestSubmitItem] 
(
	[MaterialRequestSubmitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09051', GetDate())
GO
