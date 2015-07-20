/*** pStyleHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHistory]') AND name = N'IX_pStyleHistory_TeamID')
DROP INDEX [IX_pStyleHistory_TeamID] ON [dbo].[pStyleHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHistory_TeamID] ON [dbo].[pStyleHistory] 
(
	[TeamID] ASC
)
INCLUDE ( [StyleID],
[CDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND name = N'IX_pStyleHeader_StyleType')
DROP INDEX [IX_pStyleHeader_StyleType] ON [dbo].[pStyleHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHeader_StyleType] ON [dbo].[pStyleHeader] 
(
	[StyleType] ASC
)
INCLUDE ( [DivisionID],
[StyleID],
[StyleCategory],
[SubCategoryId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** there is a weird view (vwx_StyleBOMMaterial_SELECT) that uses StyleNo as join condition
	 The index makes it much more efficient ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND name = N'IX_pStyleHeader_StyleNo')
DROP INDEX [IX_pStyleHeader_StyleNo] ON [dbo].[pStyleHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHeader_StyleNo] ON [dbo].[pStyleHeader] 
(
	[StyleNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pStyleWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND name = N'IX_pStyleWorkflow_WorkDue')
DROP INDEX [IX_pStyleWorkflow_WorkDue] ON [dbo].[pStyleWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflow_WorkDue] ON [dbo].[pStyleWorkflow] 
(
	[WorkDue] ASC
)
INCLUDE ( [StyleID],
[WorkflowID],
[WorkStatus],
[StyleSeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND name = N'IX_pStyleWorkflow_StyleID')
DROP INDEX [IX_pStyleWorkflow_StyleID] ON [dbo].[pStyleWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflow_StyleID] ON [dbo].[pStyleWorkflow] 
(
	[StyleID] ASC
)
INCLUDE ( [StyleSet],
[WorkAssignedTo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleCalendarTemp ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCalendarTemp]') AND name = N'IX_pStyleCalendarTemp_CalendarID')
DROP INDEX [IX_pStyleCalendarTemp_CalendarID] ON [dbo].[pStyleCalendarTemp] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCalendarTemp_CalendarID] ON [dbo].[pStyleCalendarTemp] 
(
	[CalendarId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleDevelopmentItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDevelopmentItem]') AND name = N'IX_pStyleDevelopmentItem_StyleID')
DROP INDEX [IX_pStyleDevelopmentItem_StyleID] ON [dbo].[pStyleDevelopmentItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDevelopmentItem_StyleID] ON [dbo].[pStyleDevelopmentItem] 
(
	[StyleID] ASC
)
INCLUDE ( [Variation],
[StyleDevelopmentID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDevelopmentItem]') AND name = N'IX_pStyleDevelopmentItem_StyleDevelopmentID')
DROP INDEX [IX_pStyleDevelopmentItem_StyleDevelopmentID] ON [dbo].[pStyleDevelopmentItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDevelopmentItem_StyleDevelopmentID] ON [dbo].[pStyleDevelopmentItem] 
(
	[StyleDevelopmentID] ASC
)
INCLUDE ( [StyleID],
[Variation]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleTeam ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTeam]') AND name = N'IX_pStyleTeam_StyleID')
DROP INDEX [IX_pStyleTeam_StyleID] ON [dbo].[pStyleTeam] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleTeam_StyleID] ON [dbo].[pStyleTeam] 
(
	[StyleID] ASC,
	[TeamID] ASC
)
INCLUDE ( [RequestStatus]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** pStyleSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSeasonYear]') AND name = N'IX_pStyleSeasonYear')
DROP INDEX [IX_pStyleSeasonYear] ON [dbo].[pStyleSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSeasonYear] ON [dbo].[pStyleSeasonYear] 
(
	[StyleID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [StyleSeason],
[StyleYear]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** pWorkFlowItemLinked ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkFlowItemLinked]') AND name = N'IX_pWorkFlowItemLinked_WorkflowItemID')
DROP INDEX [IX_pWorkFlowItemLinked_WorkflowItemID] ON [dbo].[pWorkFlowItemLinked] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pWorkFlowItemLinked_WorkflowItemID] ON [dbo].[pWorkFlowItemLinked] 
(
	[WorkFlowItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkFlowItemLinked]') AND name = N'IX_pWorkFlowItemLinked_StyleID')
DROP INDEX [IX_pWorkFlowItemLinked_StyleID] ON [dbo].[pWorkFlowItemLinked] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pWorkFlowItemLinked_StyleID] ON [dbo].[pWorkFlowItemLinked] 
(
	[StyleID] ASC,
	[StyleSet] ASC
)
INCLUDE ( [WorkFlowItemID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pWorkflowTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkflowTemplateItem]') AND name = N'IX_pWorkflowTemplateItem_WorkflowTemplateID')
DROP INDEX [IX_pWorkflowTemplateItem_WorkflowTemplateID] ON [dbo].[pWorkflowTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pWorkflowTemplateItem_WorkflowTemplateID] ON [dbo].[pWorkflowTemplateItem] 
(
	[WorkflowTemplateID] ASC
)
INCLUDE ( [WorkflowID],
[WorkflowSort],
[StartDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkflowTemplateItem]') AND name = N'IX_pWorkflowTemplateItem_WorkflowID')
DROP INDEX [IX_pWorkflowTemplateItem_WorkflowID] ON [dbo].[pWorkflowTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pWorkflowTemplateItem_WorkflowID] ON [dbo].[pWorkflowTemplateItem] 
(
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pWorkFlowItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkFlowItem]') AND name = N'IDX_WorkFlowId')
DROP INDEX [IDX_WorkFlowId] ON [dbo].[pWorkFlowItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IDX_WorkFlowId] ON [dbo].[pWorkFlowItem] 
(
	[WorkflowID] ASC
)
INCLUDE ( [StyleID],
[StyleSet],
[StyleSeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkFlowItem]') AND name = N'IX_pWorkFlowItem_WirkflowItemMasterID')
DROP INDEX [IX_pWorkFlowItem_WirkflowItemMasterID] ON [dbo].[pWorkFlowItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pWorkFlowItem_WirkflowItemMasterID] ON [dbo].[pWorkFlowItem] 
(
	[WorkflowItemMasterID] ASC
)
INCLUDE ( [StyleID],
[StyleSeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleColorway ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorway]') AND name = N'IX_pStyleColorway_StyleID')
DROP INDEX [IX_pStyleColorway_StyleID] ON [dbo].[pStyleColorway] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorway_StyleID] ON [dbo].[pStyleColorway] 
(
	[StyleID] ASC
)
INCLUDE ( [ColorPaletteID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorway]') AND name = N'IX_pStyleColorway_ColorPaletteID')
DROP INDEX [IX_pStyleColorway_ColorPaletteID] ON [dbo].[pStyleColorway] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorway_ColorPaletteID] ON [dbo].[pStyleColorway] 
(
	[ColorPaletteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleColorwaySeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwaySeasonYear]') AND name = N'IX_pStyleColorwaySeasonYear_StyleColorwayID')
DROP INDEX [IX_pStyleColorwaySeasonYear_StyleColorwayID] ON [dbo].[pStyleColorwaySeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorwaySeasonYear_StyleColorwayID] ON [dbo].[pStyleColorwaySeasonYear] 
(
	[StyleColorwayID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwaySeasonYear]') AND name = N'IX_pStyleColorwaySeasonYear_StyleID')
DROP INDEX [IX_pStyleColorwaySeasonYear_StyleID] ON [dbo].[pStyleColorwaySeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorwaySeasonYear_StyleID] ON [dbo].[pStyleColorwaySeasonYear] 
(
	[StyleID] ASC,
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleComment]') AND name = N'IX_pStyleComment_StyleID')
DROP INDEX [IX_pStyleComment_StyleID] ON [dbo].[pStyleComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleComment_StyleID] ON [dbo].[pStyleComment] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkflowID] ASC,
	[MDate] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOMDimensionItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItem]') AND name = N'IX_pStyleBOMDimensionItem_WorkflowItemID')
DROP INDEX [IX_pStyleBOMDimensionItem_WorkflowItemID] ON [dbo].[pStyleBOMDimensionItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItem_WorkflowItemID] ON [dbo].[pStyleBOMDimensionItem] 
(
	[WorkFlowItemID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItem]') AND name = N'IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim1')
DROP INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim1] ON [dbo].[pStyleBOMDimensionItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim1] ON [dbo].[pStyleBOMDimensionItem] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim1Id] ASC
)
INCLUDE ( [ItemDim1Name],
[ItemDim1Sort],
[ItemDim1Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItem]') AND name = N'IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim2')
DROP INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim2] ON [dbo].[pStyleBOMDimensionItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim2] ON [dbo].[pStyleBOMDimensionItem] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim2Id] ASC
)
INCLUDE ( [ItemDim2Name],
[ItemDim2Sort],
[ItemDim2Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItem]') AND name = N'IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim3')
DROP INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim3] ON [dbo].[pStyleBOMDimensionItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID_Dim3] ON [dbo].[pStyleBOMDimensionItem] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim3Id] ASC
)
INCLUDE ( [ItemDim3Name],
[ItemDim3Sort],
[ItemDim3Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pStyleBOMDimensionItems ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItems]') AND name = N'IX_pStyleBOMDimensionItems_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID] ON [dbo].[pStyleBOMDimensionItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID] ON [dbo].[pStyleBOMDimensionItems] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim1Id] ASC
)
INCLUDE ( [ItemDim1Name],
[ItemDim2Id],
[ItemDim3Id],
[ItemDimActive]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItems]') AND name = N'IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim1')
DROP INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim1] ON [dbo].[pStyleBOMDimensionItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim1] ON [dbo].[pStyleBOMDimensionItems] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim1Id] ASC
)
INCLUDE ( [ItemDim1Name],
[ItemDim1Sort],
[ItemDim1Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItems]') AND name = N'IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim2')
DROP INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim2] ON [dbo].[pStyleBOMDimensionItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim2] ON [dbo].[pStyleBOMDimensionItems] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim2Id] ASC
)
INCLUDE ( [ItemDim2Name],
[ItemDim2Sort],
[ItemDim2Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItems]') AND name = N'IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim3')
DROP INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim3] ON [dbo].[pStyleBOMDimensionItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim3] ON [dbo].[pStyleBOMDimensionItems] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim3Id] ASC
)
INCLUDE ( [ItemDim3Name],
[ItemDim3Sort],
[ItemDim3Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItems]') AND name = N'IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim12')
DROP INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim12] ON [dbo].[pStyleBOMDimensionItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItems_StyleBOMDimensionID_Dim12] ON [dbo].[pStyleBOMDimensionItems] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim1Id] ASC,
	[ItemDim2Id] ASC
)
INCLUDE ( [ItemDim1Name],
[ItemDim2Name],
[ItemDim1Sort],
[ItemDim2Sort],
[ItemDim1Active],
[ItemDim2Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOM]') AND name = N'IX_pStyleBOM_StyleID')
DROP INDEX [IX_pStyleBOM_StyleID] ON [dbo].[pStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOM_StyleID] ON [dbo].[pStyleBOM] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkflowItemId] ASC,
	[MaterialType] ASC
)
INCLUDE ( [MainMaterial],
[WorkflowId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOM]') AND name = N'IX_pStyleBOM_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOM_StyleBOMDimensionID] ON [dbo].[pStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOM_StyleBOMDimensionID] ON [dbo].[pStyleBOM] 
(
	[StyleBOMDimensionId] ASC
)
INCLUDE ( [MaterialID],
[MainMaterial],
[Dim1TypeSel],
[Dim2TypeSel],
[Dim3TypeSel]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pStyleBOMItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMItem]') AND name = N'IX_pStyleBOMItem_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOMItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMItem] 
(
	[StyleBOMDimensionID] ASC,
	[StyleMaterialID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[MaterialColorId],
[MaterialQuantity],
[MaterialDimension]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMItem]') AND name = N'IX_pStyleBOMItem_StyleMaterialID')
DROP INDEX [IX_pStyleBOMItem_StyleMaterialID] ON [dbo].[pStyleBOMItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMItem_StyleMaterialID] ON [dbo].[pStyleBOMItem] 
(
	[StyleMaterialID] ASC
)
INCLUDE ( [MaterialColorId],
[StyleBOMDimensionID],
[StyleBOMDimensionItemID],
[StyleID],
[StyleSet]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pStyleBOMTemp ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMTemp]') AND name = N'IX_pStyleBOMTemp_WorkflowItemID')
DROP INDEX [IX_pStyleBOMTemp_WorkflowItemID] ON [dbo].[pStyleBOMTemp] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMTemp_WorkflowItemID] ON [dbo].[pStyleBOMTemp] 
(
	[WorkflowItemId] ASC,
	[StyleID] ASC,
	[StyleSet] ASC
)
INCLUDE ( [QuickAdd]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleChange ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleChange]') AND name = N'IX_pStyleChange_StyleID')
DROP INDEX [IX_pStyleChange_StyleID] ON [dbo].[pStyleChange] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleChange_StyleID] ON [dbo].[pStyleChange] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkflowID] ASC
)
INCLUDE ( [StyleChangeNo],
[StyleChangeBy],
[StyleChangeDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOMDimensionTempColor ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionTempColor]') AND name = N'IX_pStyleBOMDimensionTempColor_StyleBOMDimansionID')
DROP INDEX [IX_pStyleBOMDimensionTempColor_StyleBOMDimansionID] ON [dbo].[pStyleBOMDimensionTempColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionTempColor_StyleBOMDimansionID] ON [dbo].[pStyleBOMDimensionTempColor] 
(
	[StyleBOMDimensionID] ASC,
	[TeamID] ASC
)
INCLUDE ( [ColorPaletteID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOMMiscItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMMiscItem]') AND name = N'IX_pStyleBOMMiscItem_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOMMiscItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMMiscItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMMiscItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMMiscItem] 
(
	[StyleMaterialID] ASC,
	[StyleMaterialMiscID] ASC,
	[StyleBOMDimensionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08992', GetDate())
GO
