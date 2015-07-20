/*** pStyleHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND name = N'IX_pStyleHeader_DevelopmentID')
DROP INDEX [IX_pStyleHeader_DevelopmentID] ON [dbo].[pStyleHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHeader_DevelopmentID] ON [dbo].[pStyleHeader] 
(
	[DevelopmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND name = N'IX_pStyleHeader_DesignSketchID')
DROP INDEX [IX_pStyleHeader_DesignSketchID] ON [dbo].[pStyleHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHeader_DesignSketchID] ON [dbo].[pStyleHeader] 
(
	[DesignSketchID] ASC
)
INCLUDE ( [DesignSketchVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND name = N'IX_pStyleHeader_DesignSketchBackID')
DROP INDEX [IX_pStyleHeader_DesignSketchBackID] ON [dbo].[pStyleHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleHeader_DesignSketchBackID] ON [dbo].[pStyleHeader] 
(
	[DesignSketchBackID] ASC
)
INCLUDE ( [DesignSketchBackVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleDetailForm ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailForm]') AND name = N'IX_pStyleDetailForm_StyleID')
DROP INDEX [IX_pStyleDetailForm_StyleID] ON [dbo].[pStyleDetailForm] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDetailForm_StyleID] ON [dbo].[pStyleDetailForm] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkFlowItemId] ASC
)
INCLUDE ( [Sort],
[CDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailForm]') AND name = N'IX_pStyleDetailForm_ImageID')
DROP INDEX [IX_pStyleDetailForm_ImageID] ON [dbo].[pStyleDetailForm] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDetailForm_ImageID] ON [dbo].[pStyleDetailForm] 
(
	[ImageID] ASC
)
INCLUDE ([StyleID], [ImageVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleBOMDimType ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimType]') AND name = N'IX_pStyleBOMDimType_DimTypeName')
DROP INDEX [IX_pStyleBOMDimType_DimTypeName] ON [dbo].[pStyleBOMDimType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimType_DimTypeName] ON [dbo].[pStyleBOMDimType] 
(
	[DimTypeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleColorway ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorway]') AND name = N'IX_pStyleColorway_StyleID')
DROP INDEX [IX_pStyleColorway_StyleID] ON [dbo].[pStyleColorway] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorway_StyleID] ON [dbo].[pStyleColorway] 
(
	[StyleID] ASC
)
INCLUDE ( [ColorPaletteID],
[StyleColorNo],
[StyleColorName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleWardrobeRelation ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWardrobeRelation]') AND name = N'IX_pStyleWardrobeRelation_StyleID')
DROP INDEX [IX_pStyleWardrobeRelation_StyleID] ON [dbo].[pStyleWardrobeRelation] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWardrobeRelation_StyleID] ON [dbo].[pStyleWardrobeRelation] 
(
	[StyleID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [StyleRelationID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSeasonYear]') AND name = N'IX_pStyleSeasonYear_SeasonYearID')
DROP INDEX [IX_pStyleSeasonYear_SeasonYearID] ON [dbo].[pStyleSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSeasonYear_SeasonYearID] ON [dbo].[pStyleSeasonYear] 
(
	[SeasonYearID] ASC
)
INCLUDE ( [StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleCostingHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingHeader]') AND name = N'IX_pStyleCostingHeader_StyleID')
DROP INDEX [IX_pStyleCostingHeader_StyleID] ON [dbo].[pStyleCostingHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCostingHeader_StyleID] ON [dbo].[pStyleCostingHeader] 
(
	[StyleID] ASC,
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleCostingScenarioItems ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingScenarioItems]') AND name = N'IX_pStyleCostingScenarioItems_StyleCostingID')
DROP INDEX [IX_pStyleCostingScenarioItems_StyleCostingID] ON [dbo].[pStyleCostingScenarioItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCostingScenarioItems_StyleCostingID] ON [dbo].[pStyleCostingScenarioItems] 
(
	[StyleCostingID] ASC
)
INCLUDE ( [StyleCostingName],
[ExchangeRateItemID],
[StyleCostingScenarioNo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pstyleCostingBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pstyleCostingBOM]') AND name = N'IX_pStyleCostingBOM_StyleCostingScenarioItemsID')
DROP INDEX [IX_pStyleCostingBOM_StyleCostingScenarioItemsID] ON [dbo].[pstyleCostingBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCostingBOM_StyleCostingScenarioItemsID] ON [dbo].[pstyleCostingBOM] 
(
	[StytleCostingScenarioItemsID] ASC
)
INCLUDE ( [MaterialCost]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleCostingBOL ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingBOL]') AND name = N'IX_pStyleCostingBOL_StyleCostingScenarioItemsID')
DROP INDEX [IX_pStyleCostingBOL_StyleCostingScenarioItemsID] ON [dbo].[pStyleCostingBOL] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCostingBOL_StyleCostingScenarioItemsID] ON [dbo].[pStyleCostingBOL] 
(
	[StytleCostingScenarioItemsID] ASC
)
INCLUDE ( [OperationCost]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pstyleCostingAdditionalItems ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pstyleCostingAdditionalItems]') AND name = N'IX_pstyleCostingAdditionalItems_StyleCostingScenarioItemsID')
DROP INDEX [IX_pstyleCostingAdditionalItems_StyleCostingScenarioItemsID] ON [dbo].[pstyleCostingAdditionalItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pstyleCostingAdditionalItems_StyleCostingScenarioItemsID] ON [dbo].[pstyleCostingAdditionalItems] 
(
	[StytleCostingScenarioItemsID] ASC
)
INCLUDE ( [AdditionalItemCost]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleBOLException ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOLException]') AND name = N'IX_pStyleBOLException_StyleID')
DROP INDEX [IX_pStyleBOLException_StyleID] ON [dbo].[pStyleBOLException] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOLException_StyleID] ON [dbo].[pStyleBOLException] 
(
	[StyleId] ASC,
	[StyleSet] ASC
)
INCLUDE ( [BOLExceptionName],
[CDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pBOLOpToMacro ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pBOLOpToMacro]') AND name = N'IX_pBOLOpToMacro_MacroID')
DROP INDEX [IX_pBOLOpToMacro_MacroID] ON [dbo].[pBOLOpToMacro] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pBOLOpToMacro_MacroID] ON [dbo].[pBOLOpToMacro] 
(
	[MacroId] ASC,
	[OperationId] ASC
) INCLUDE([Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOLPageOperations ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOLPageOperations]') AND name = N'IX_pStyleBOLPageOperations_MacroID')
DROP INDEX [IX_pStyleBOLPageOperations_MacroID] ON [dbo].[pStyleBOLPageOperations] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOLPageOperations_MacroID] ON [dbo].[pStyleBOLPageOperations] 
(
	[MacroId] ASC,
	[IsLinked] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOLPageOperations]') AND name = N'IX_pStyleBOLPageOperations_StyleID')
DROP INDEX [IX_pStyleBOLPageOperations_StyleID] ON [dbo].[pStyleBOLPageOperations] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOLPageOperations_StyleID] ON [dbo].[pStyleBOLPageOperations] 
(
	[StyleID] ASC,
	[StyleSet] ASC
)
INCLUDE ( [IsLinked],
[OperationId],
[MacroId],
[MacroParentId],
[SAM],
[IsException]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOLExceptionEntries ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOLExceptionEntries]') AND name = N'IX_pStyleBOLExceptionEntries_')
DROP INDEX [IX_pStyleBOLExceptionEntries_] ON [dbo].[pStyleBOLExceptionEntries] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOLExceptionEntries_] ON [dbo].[pStyleBOLExceptionEntries] 
(
	[BOLExceptionId] ASC,
	[PageOperationId] ASC
)
INCLUDE ( [isSet]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleNBOLHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleNBOLHeader]') AND name = N'IX_pStyleNBOLHeader_WorkflowItemID')
DROP INDEX [IX_pStyleNBOLHeader_WorkflowItemID] ON [dbo].[pStyleNBOLHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleNBOLHeader_WorkflowItemID] ON [dbo].[pStyleNBOLHeader] 
(
	[WorkFlowItemID] ASC
)
INCLUDE ( [WorkflowID],
[TemplateID],
[TemplateName],
[ExchangeRateItemID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleNBOLException ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleNBOLException]') AND name = N'IX_pStyleNBOLException_StyleID')
DROP INDEX [IX_pStyleNBOLException_StyleID] ON [dbo].[pStyleNBOLException] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleNBOLException_StyleID] ON [dbo].[pStyleNBOLException] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[WorkflowItemID] ASC
)
INCLUDE ( [WorkflowID],
[ExceptionName],
[Active],
[Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleNBOLItems ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleNBOLItems]') AND name = N'IX_pStyleNBOLItems_WorkflowItemID')
DROP INDEX [IX_pStyleNBOLItems_WorkflowItemID] ON [dbo].[pStyleNBOLItems] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleNBOLItems_WorkflowItemID] ON [dbo].[pStyleNBOLItems] 
(
	[WorkFlowItemID] ASC,
	[StyleID] ASC,
	[StyleSet] ASC
)
INCLUDE ( [WorkFlowID],
[IsLinked]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleSKUItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItem]') AND name = N'IX_pStyleSKUItem_WorkflowItemID')
DROP INDEX [IX_pStyleSKUItem_WorkflowItemID] ON [dbo].[pStyleSKUItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSKUItem_WorkflowItemID] ON [dbo].[pStyleSKUItem] 
(
	[WorkflowItemID] ASC
)
INCLUDE ( [ItemDim1TypeID],
[ItemDim2TypeID],
[ItemDim3TypeID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUItem]') AND name = N'IX_pStyleSKUItem_StyleBOMDimensionID')
DROP INDEX [IX_pStyleSKUItem_StyleBOMDimensionID] ON [dbo].[pStyleSKUItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSKUItem_StyleBOMDimensionID] ON [dbo].[pStyleSKUItem] 
(
	[StyleBOMDimensionID] ASC
)
INCLUDE ( [StyleSKUTemplateID],
[WorkflowItemID],
[PlanningSKUHeaderID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleDetailGridControl ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailGridControl]') AND name = N'IX_pStyleDetailGridControl_WorkflowID')
DROP INDEX [IX_pStyleDetailGridControl_WorkflowID] ON [dbo].[pStyleDetailGridControl] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDetailGridControl_WorkflowID] ON [dbo].[pStyleDetailGridControl] 
(
	[WorkflowID] ASC
)
INCLUDE ( [SchemaFile]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleMaterials ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMaterials]') AND name = N'IX_pStyleMaterials_StyleID')
DROP INDEX [IX_pStyleMaterials_StyleID] ON [dbo].[pStyleMaterials] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleMaterials_StyleID] ON [dbo].[pStyleMaterials] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[MainMaterial] ASC
)
INCLUDE ( [Artwork], [MaterialType], [MaterialID], [Qty], [MaterialPrice], [VolumePrice], [MaterialBOM], [Colorway]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMaterials]') AND name = N'IX_pStyleMaterials_MaterialID')
DROP INDEX [IX_pStyleMaterials_MaterialID] ON [dbo].[pStyleMaterials] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleMaterials_MaterialID] ON [dbo].[pStyleMaterials] 
(
	[MaterialID] ASC
)
INCLUDE ( [MChange],
[StyleID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMaterials]') AND name = N'IX_pStyleMaterials_MaterialImageID')
DROP INDEX [IX_pStyleMaterials_MaterialImageID] ON [dbo].[pStyleMaterials] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleMaterials_MaterialImageID] ON [dbo].[pStyleMaterials] 
(
	[MaterialImageID] ASC
)
INCLUDE ([StyleID], [MaterialImageVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleColorwayItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayItem]') AND name = N'IX_pStyleColorwayItem_StyleID')
DROP INDEX [IX_pStyleColorwayItem_StyleID] ON [dbo].[pStyleColorwayItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorwayItem_StyleID] ON [dbo].[pStyleColorwayItem] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[StyleMaterialID] ASC
)
INCLUDE ( [StyleColorID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayItem]') AND name = N'IX_pStyleColorwayItem_StyleColorID')
DROP INDEX [IX_pStyleColorwayItem_StyleColorID] ON [dbo].[pStyleColorwayItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorwayItem_StyleColorID] ON [dbo].[pStyleColorwayItem] 
(
	[StyleColorID] ASC,
	[StyleID] ASC,
	[StyleSet] ASC
)
INCLUDE ( [StyleMaterialID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayItem]') AND name = N'IX_pStyleColorwayItem_MaterialColorID')
DROP INDEX [IX_pStyleColorwayItem_MaterialColorID] ON [dbo].[pStyleColorwayItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleColorwayItem_MaterialColorID] ON [dbo].[pStyleColorwayItem] 
(
	[MaterialColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleDetail ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetail]') AND name = N'IX_pStyleDetail_StyleID')
DROP INDEX [IX_pStyleDetail_StyleID] ON [dbo].[pStyleDetail] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDetail_StyleID] ON [dbo].[pStyleDetail] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[Sort] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pBodyMarker ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pBodyMarker]') AND name = N'IX_pBodyMarker_StyleID')
DROP INDEX [IX_pBodyMarker_StyleID] ON [dbo].[pBodyMarker] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pBodyMarker_StyleID] ON [dbo].[pBodyMarker] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[IsLinked] ASC
)
INCLUDE ( [IsActive],
[IsForAveraging]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pBodyPatternSheetModel ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pBodyPatternSheetModel]') AND name = N'IX_pBodyPatternSheetModel_StyleID')
DROP INDEX [IX_pBodyPatternSheetModel_StyleID] ON [dbo].[pBodyPatternSheetModel] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pBodyPatternSheetModel_StyleID] ON [dbo].[pBodyPatternSheetModel] 
(
	[StyleID] ASC,
	[StyleSet] ASC,
	[IsLinked] ASC
)
INCLUDE ( [Active],
[Model_Code],
[Model_Name]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDocument]') AND name = N'IX_pStyleDocument_StyleID')
DROP INDEX [IX_pStyleDocument_StyleID] ON [dbo].[pStyleDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleDocument_StyleID] ON [dbo].[pStyleDocument] 
(
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTechPack ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTechPack]') AND name = N'IX_pTechPack_StyleID')
DROP INDEX [IX_pTechPack_StyleID] ON [dbo].[pTechPack] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTechPack_StyleID] ON [dbo].[pTechPack] 
(
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleTeam ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTeam]') AND name = N'IX_pStyleTeam_StyleID_SeasonYearID')
DROP INDEX [IX_pStyleTeam_StyleID_SeasonYearID] ON [dbo].[pStyleTeam] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleTeam_StyleID_SeasonYearID] ON [dbo].[pStyleTeam] 
(
	[StyleID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [TeamID],
[TradePartnerRelationshipLevelID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pStyleWorkflowTeam ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflowTeam]') AND name = N'IX_pStyleWorkflowTeam_StyleID')
DROP INDEX [IX_pStyleWorkflowTeam_StyleID] ON [dbo].[pStyleWorkflowTeam] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflowTeam_StyleID] ON [dbo].[pStyleWorkflowTeam] 
(
	[StyleId] ASC,
	[TeamID] ASC,
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTechPackTeam ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackTeam]') AND name = N'IX_pTechPackTeam_TeamID')
DROP INDEX [IX_pTechPackTeam_TeamID] ON [dbo].[pTechPackTeam] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTechPackTeam_TeamID] ON [dbo].[pTechPackTeam] 
(
	[TeamID] ASC,
	[StyleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOMDimension ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimension]') AND name = N'IX_pStyleBOMDimension_StyleID')
DROP INDEX [IX_pStyleBOMDimension_StyleID] ON [dbo].[pStyleBOMDimension] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimension_StyleID] ON [dbo].[pStyleBOMDimension] 
(
	[StyleID] ASC
)
INCLUDE ( [WorkFlowItemID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleBOM ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOM]') AND name = N'IX_pStyleBOM_MaterialID')
DROP INDEX [IX_pStyleBOM_MaterialID] ON [dbo].[pStyleBOM] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleBOM_MaterialID] ON [dbo].[pStyleBOM] 
(
	[MaterialID] ASC
)
INCLUDE ( [StyleID],
[MChange]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleSourcingItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSourcingItem]') AND name = N'IX_pStyleSourcingItem_TradePartnerVendorID')
DROP INDEX [IX_pStyleSourcingItem_TradePartnerVendorID] ON [dbo].[pStyleSourcingItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleSourcingItem_TradePartnerVendorID] ON [dbo].[pStyleSourcingItem] 
(
	[StyleSourcingID] ASC,
	[StyleMaterialID] ASC,
	[StyleColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pWorkFlowItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pWorkFlowItem]') AND name = N'IX_pWorkFlowItem_StyleSeasonYearID')
DROP INDEX [IX_pWorkFlowItem_StyleSeasonYearID] ON [dbo].[pWorkFlowItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pWorkFlowItem_StyleSeasonYearID] ON [dbo].[pWorkFlowItem] 
(
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleImage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImage]') AND name = N'IX_pStyleImage_SpecSketchID1')
DROP INDEX [IX_pStyleImage_SpecSketchID1] ON [dbo].[pStyleImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImage_SpecSketchID1] ON [dbo].[pStyleImage] 
(
	[SpecSketchID1] ASC
)
INCLUDE ( [StyleID],
[SpecSketchVersion1]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImage]') AND name = N'IX_pStyleImage_SpecSketchID2')
DROP INDEX [IX_pStyleImage_SpecSketchID2] ON [dbo].[pStyleImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImage_SpecSketchID2] ON [dbo].[pStyleImage] 
(
	[SpecSketchID2] ASC
)
INCLUDE ( [StyleID],
[SpecSketchVersion2]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImage]') AND name = N'IX_pStyleImage_SpecSketchID3')
DROP INDEX [IX_pStyleImage_SpecSketchID3] ON [dbo].[pStyleImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImage_SpecSketchID3] ON [dbo].[pStyleImage] 
(
	[SpecSketchID3] ASC
)
INCLUDE ( [StyleID],
[SpecSketchVersion3]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImage]') AND name = N'IX_pStyleImage_SpecSketchID4')
DROP INDEX [IX_pStyleImage_SpecSketchID4] ON [dbo].[pStyleImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImage_SpecSketchID4] ON [dbo].[pStyleImage] 
(
	[SpecSketchID4] ASC
)
INCLUDE ( [StyleID],
[SpecSketchVersion4]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleImageMeasurements ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImageMeasurements]') AND name = N'IX_pStyleImageMeasurements_ImageSet1ID')
DROP INDEX [IX_pStyleImageMeasurements_ImageSet1ID] ON [dbo].[pStyleImageMeasurements] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImageMeasurements_ImageSet1ID] ON [dbo].[pStyleImageMeasurements] 
(
	[ImageSet1Id] ASC
)
INCLUDE ( [StyleID],
[ImageVersionSet1]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImageMeasurements]') AND name = N'IX_pStyleImageMeasurements_ImageSet2ID')
DROP INDEX [IX_pStyleImageMeasurements_ImageSet2ID] ON [dbo].[pStyleImageMeasurements] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImageMeasurements_ImageSet2ID] ON [dbo].[pStyleImageMeasurements] 
(
	[ImageSet2Id] ASC
)
INCLUDE ( [StyleID],
[ImageVersionSet2]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImageMeasurements]') AND name = N'IX_pStyleImageMeasurements_ImageSet3ID')
DROP INDEX [IX_pStyleImageMeasurements_ImageSet3ID] ON [dbo].[pStyleImageMeasurements] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImageMeasurements_ImageSet3ID] ON [dbo].[pStyleImageMeasurements] 
(
	[ImageSet3Id] ASC
)
INCLUDE ( [StyleID],
[ImageVersionSet3]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImageMeasurements]') AND name = N'IX_pStyleImageMeasurements_ImageSet4ID')
DROP INDEX [IX_pStyleImageMeasurements_ImageSet4ID] ON [dbo].[pStyleImageMeasurements] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleImageMeasurements_ImageSet4ID] ON [dbo].[pStyleImageMeasurements] 
(
	[ImageSet4Id] ASC
)
INCLUDE ( [StyleID],
[ImageVersionSet4]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pStyleCosting ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCosting]') AND name = N'IX_pStyleCosting_StyleID')
DROP INDEX [IX_pStyleCosting_StyleID] ON [dbo].[pStyleCosting] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleCosting_StyleID] ON [dbo].[pStyleCosting] 
(
	[StyleID] ASC,
	[StyleCostingTypeID] ASC
)
INCLUDE ( [StyleCostingScenarioItemsId],
[StyleCostingName],
[StyleSeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09048', GetDate())
GO
