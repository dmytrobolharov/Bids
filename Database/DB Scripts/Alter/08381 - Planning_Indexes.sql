/*********************/
/* pPlanningDivision */
/*********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningDivision]') AND name = N'IX_pPlanningDivision_DivisionID')
DROP INDEX [IX_pPlanningDivision_DivisionID] ON [dbo].[pPlanningDivision] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningDivision_DivisionID] ON [dbo].[pPlanningDivision] 
(
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningDivision]') AND name = N'IX_pPlanningDivision_PlanningID')
DROP INDEX [IX_pPlanningDivision_PlanningID] ON [dbo].[pPlanningDivision] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningDivision_PlanningID] ON [dbo].[pPlanningDivision] 
(
	[PlanningID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/***********************/
/* pPlanningSeasonYear */
/***********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningSeasonYear]') AND name = N'IX_pPlanningSeasonYear_PlanningID')
DROP INDEX [IX_pPlanningSeasonYear_PlanningID] ON [dbo].[pPlanningSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningSeasonYear_PlanningID] ON [dbo].[pPlanningSeasonYear] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************/
/* pPlanningItem */
/*****************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningItem]') AND name = N'IX_pPlanningItem_PlanningID')
DROP INDEX [IX_pPlanningItem_PlanningID] ON [dbo].[pPlanningItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningItem_PlanningID] ON [dbo].[pPlanningItem] 
(
	[PlanningID] ASC,
	[StyleSeasonYearID] ASC
)
INCLUDE ( [StyleID],
[PlanningItemDrop],
[PlanningItemDropUser],
[PlanningItemDropDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningItem]') AND name = N'IX_pPlanningItem_PlanningID2')
DROP INDEX [IX_pPlanningItem_PlanningID2] ON [dbo].[pPlanningItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningItem_PlanningID2] ON [dbo].[pPlanningItem] 
(
	[PlanningID] ASC
)
INCLUDE ( [PlanningItemDrop],
[StyleSeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*********************/
/* pPlanningBusiness */
/*********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]') AND name = N'IX_pPlanningBusiness_1')
DROP INDEX [IX_pPlanningBusiness_1] ON [dbo].[pPlanningBusiness] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningBusiness_1] ON [dbo].[pPlanningBusiness] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC,
	[PlanningFinancialID] ASC
)
INCLUDE ( [PlanningDivisionID],
[PlanningStyleTypeID],
[PlanningStyleCategoryID],
[PlanningLastYearCh],
[PlanningPlanningCh],
[PlanningDIPCh],
[PlanningActualCh],
[PlanningBrandID],
[PlanningSubCategoryID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]') AND name = N'IX_pPlanningBusiness_2')
DROP INDEX [IX_pPlanningBusiness_2] ON [dbo].[pPlanningBusiness] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningBusiness_2] ON [dbo].[pPlanningBusiness] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC,
	[Active] ASC,
	[PlanningStyleCategoryID] ASC
)
INCLUDE ( [PlanningFinancialID],
[PlanningDivisionID],
[PlanningStyleTypeID],
[PlanningPlanningCh],
[PlanningBrandID],
[PlanningSubCategoryID],
[PlanningDivision],
[PlanningStyleTypeDescription],
[PlanningStyleCategory],
[PlanningBrand],
[PlanningSubCategory]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/**********************/
/* pPlanningSKUHeader */
/**********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningSKUHeader]') AND name = N'IX_pPlanningSKUHeader_PlanningID')
DROP INDEX [IX_pPlanningSKUHeader_PlanningID] ON [dbo].[pPlanningSKUHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningSKUHeader_PlanningID] ON [dbo].[pPlanningSKUHeader] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*****************************/
/* pPlanningSKUHeaderDimType */
/*****************************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningSKUHeaderDimType]') AND name = N'IX_pPlanningSKUHeaderDimType_PlanningID')
DROP INDEX [IX_pPlanningSKUHeaderDimType_PlanningID] ON [dbo].[pPlanningSKUHeaderDimType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningSKUHeaderDimType_PlanningID] ON [dbo].[pPlanningSKUHeaderDimType] 
(
	[PlanningSKUHeaderID] ASC
) INCLUDE([DimTypeID], [Position]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/***************************/
/* pPlanningLineListConfig */
/***************************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningLineListConfig]') AND name = N'IX_pPlanningLineListConfig_PlanningID')
DROP INDEX [IX_pPlanningLineListConfig_PlanningID] ON [dbo].[pPlanningLineListConfig] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningLineListConfig_PlanningID] ON [dbo].[pPlanningLineListConfig] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [DivisionID],
[StyleTypeID],
[StyleCategoryID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/******************/
/* pPlanningColor */
/******************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningColor]') AND name = N'IX_pPlanningColor_PlanningID')
DROP INDEX [IX_pPlanningColor_PlanningID] ON [dbo].[pPlanningColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningColor_PlanningID] ON [dbo].[pPlanningColor] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [ColorFolderID],
[ColorPaletteID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningColor]') AND name = N'IX_pPlanningColor_ColorPaletteID')
DROP INDEX [IX_pPlanningColor_ColorPaletteID] ON [dbo].[pPlanningColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningColor_ColorPaletteID] ON [dbo].[pPlanningColor] 
(
	[ColorPaletteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*********************/
/* pPlanningMaterial */
/*********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningMaterial]') AND name = N'IX_pPlanningMaterial_PlanningID')
DROP INDEX [IX_pPlanningMaterial_PlanningID] ON [dbo].[pPlanningMaterial] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningMaterial_PlanningID] ON [dbo].[pPlanningMaterial] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [MaterialID],
[PlanningMaterialDrop]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*********************/
/* pPlanningDocument */
/*********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningDocument]') AND name = N'IX_pPlanningDocument_PlanningID')
DROP INDEX [IX_pPlanningDocument_PlanningID] ON [dbo].[pPlanningDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pPlanningDocument_PlanningID] ON [dbo].[pPlanningDocument] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*************************/
/* pStyleDevelopmentItem */
/*************************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDevelopmentItem]') AND name = N'IX_pStyleDevelopmentItem_StyleID')
DROP INDEX [IX_pStyleDevelopmentItem_StyleID] ON [dbo].[pStyleDevelopmentItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDevelopmentItem_StyleID] ON [dbo].[pStyleDevelopmentItem] 
(
	[StyleID] ASC
)
INCLUDE ( [Variation]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/******************/
/* pStyleWorkflow */
/******************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND name = N'IX_pStyleWorkflow_WorkflowID')
DROP INDEX [IX_pStyleWorkflow_WorkflowID] ON [dbo].[pStyleWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflow_WorkflowID] ON [dbo].[pStyleWorkflow] 
(
	[WorkflowID] ASC,
	[StyleSeasonYearID] ASC
) INCLUDE([StyleSet], [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/**********************/
/* pStyleBOMDimension */
/**********************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimension]') AND name = N'IX_pStyleBOMDimension_WorkflowItemID')
DROP INDEX [IX_pStyleBOMDimension_WorkflowItemID] ON [dbo].[pStyleBOMDimension] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimension_WorkflowItemID] ON [dbo].[pStyleBOMDimension] 
(
	[WorkFlowItemID] ASC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/**************************/
/* pStyleBOMDimensionItem */
/**************************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItem]') AND name = N'IX_pStyleBOMDimensionItem_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMDimensionItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMDimensionItem] 
(
	[StyleBOMDimensionID] ASC,
	[StyleID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[ItemDim1Active],
[ItemDim2Active],
[ItemDim3Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*************/
/* pStyleBOM */
/*************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOM]') AND name = N'IX_pStyleBOM_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOM_StyleBOMDimensionID] ON [dbo].[pStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOM_StyleBOMDimensionID] ON [dbo].[pStyleBOM] 
(
	[StyleBOMDimensionId] ASC
)
INCLUDE ( [MaterialID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************/
/* pStyleBOMItem */
/*****************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMItem]') AND name = N'IX_pStyleBOMItem_StyleBOMDimensionID')
DROP INDEX [IX_pStyleBOMItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMItem_StyleBOMDimensionID] ON [dbo].[pStyleBOMItem] 
(
	[StyleBOMDimensionID] ASC
)
INCLUDE ( [ItemDim1Id],
[ItemDim2Id],
[ItemDim3Id],
[MaterialColorId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMItem]') AND name = N'IX_pStyleBOMItem_StyleMaterialID')
DROP INDEX [IX_pStyleBOMItem_StyleMaterialID] ON [dbo].[pStyleBOMItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMItem_StyleMaterialID] ON [dbo].[pStyleBOMItem] 
(
	[StyleMaterialID] ASC
)
INCLUDE ( [MaterialColorId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*****************/
/* pStyleSKUItem */
/*****************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItem]') AND name = N'IX_pStyleSKUItem_PlanningSKUHeaderID')
DROP INDEX [IX_pStyleSKUItem_PlanningSKUHeaderID] ON [dbo].[pStyleSKUItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSKUItem_PlanningSKUHeaderID] ON [dbo].[pStyleSKUItem] 
(
	[PlanningSKUHeaderID] ASC
) INCLUDE([WorkflowItemID], [StyleBOMDimensionID], [ItemDim1TypeID], [ItemDim2TypeID], [ItemDim3TypeID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItem]') AND name = N'IX_pStyleSKUItem_WorkflowItemID')
DROP INDEX [IX_pStyleSKUItem_WorkflowItemID] ON [dbo].[pStyleSKUItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSKUItem_WorkflowItemID] ON [dbo].[pStyleSKUItem] 
(
	[WorkflowItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/******************/
/* pStyleSKUItems */
/******************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItems]') AND name = N'IX_pStyleSKUItems_StyleSKUItemID')
DROP INDEX [IX_pStyleSKUItems_StyleSKUItemID] ON [dbo].[pStyleSKUItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSKUItems_StyleSKUItemID] ON [dbo].[pStyleSKUItems] 
(
	[StyleSKUItemID] ASC
)
INCLUDE ( [ItemDim1ID],
[ItemDim2ID],
[ItemDim3ID],
[TotalWSUnits],
[TotalRUnits],
[TotalEUnits],
[TotalUnits]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/***************/
/* pLineFolder */
/***************/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolder]') AND name = N'IX_pLineFolder_PlanningID')
DROP INDEX [IX_pLineFolder_PlanningID] ON [dbo].[pLineFolder] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pLineFolder_PlanningID] ON [dbo].[pLineFolder] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08381', GetDate())
GO