/*** pMaterial ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterial]') AND name = N'IX_pMaterial_TempID')
DROP INDEX [IX_pMaterial_TempID] ON [dbo].[pMaterial] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterial_TempID] ON [dbo].[pMaterial] 
(
	[TempID] ASC
)
INCLUDE ( [TempNo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterial]') AND name = N'IX_pMaterial_MaterialImageID')
DROP INDEX [IX_pMaterial_MaterialImageID] ON [dbo].[pMaterial] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterial_MaterialImageID] ON [dbo].[pMaterial] 
(
	[MaterialImageID] ASC
)
INCLUDE ( [MaterialImageVersion],
[MaterialType]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** pMaterialTradePartner ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartner]') AND name = N'IX_pMaterialTradePartner_MaterialID')
DROP INDEX [IX_pMaterialTradePartner_MaterialID] ON [dbo].[pMaterialTradePartner] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartner_MaterialID] ON [dbo].[pMaterialTradePartner] 
(
	[MaterialId] ASC,
	[TradePartnerRelationshipLevelID] ASC
)
INCLUDE([MaterialRequestWorkflowTempID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartner]') AND name = N'IX_pMaterialTradePartner_TradePartnerID')
DROP INDEX [IX_pMaterialTradePartner_TradePartnerID] ON [dbo].[pMaterialTradePartner] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTradePartner_TradePartnerID] ON [dbo].[pMaterialTradePartner] 
(
	[TradepartnerId] ASC
)
INCLUDE ( [TradePartnerRelationshipLevelID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pMaterialSize ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSize]') AND name = N'IX_pMaterialSize_MaterialID')
DROP INDEX [IX_pMaterialSize_MaterialID] ON [dbo].[pMaterialSize] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialSize_MaterialID] ON [dbo].[pMaterialSize] 
(
	[MaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pMaterialColorSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColorSeasonYear]') AND name = N'IX_pMaterialColorSeasonYear_MaterialColorID')
DROP INDEX [IX_pMaterialColorSeasonYear_MaterialColorID] ON [dbo].[pMaterialColorSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialColorSeasonYear_MaterialColorID] ON [dbo].[pMaterialColorSeasonYear] 
(
	[MaterialColorID] ASC
)
INCLUDE ( [MaterialID],
[SeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialColorSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColorSeasonYear]') AND name = N'IX_pMaterialColorSeasonYear_SeasonYearID')
DROP INDEX [IX_pMaterialColorSeasonYear_SeasonYearID] ON [dbo].[pMaterialColorSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialColorSeasonYear_SeasonYearID] ON [dbo].[pMaterialColorSeasonYear] 
(
	[SeasonYearID] ASC,
	[MaterialID] ASC,
	[MaterialColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialHistory]') AND name = N'IX_pMaterialHistory_TeamID')
DROP INDEX [IX_pMaterialHistory_TeamID] ON [dbo].[pMaterialHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialHistory_TeamID] ON [dbo].[pMaterialHistory] 
(
	[TeamID] ASC,
	[CDate] ASC
)
INCLUDE ( [MaterialID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialWorkflowPage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialWorkflowPage]') AND name = N'IX_pMaterialWorkflowPage_MaterialID')
DROP INDEX [IX_pMaterialWorkflowPage_MaterialID] ON [dbo].[pMaterialWorkflowPage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialWorkflowPage_MaterialID] ON [dbo].[pMaterialWorkflowPage] 
(
	[MaterialID] ASC,
	[MaterialTemplatePageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTemplateItem]') AND name = N'IX_pMaterialTemplateItem_MaterialTemplateID')
DROP INDEX [IX_pMaterialTemplateItem_MaterialTemplateID] ON [dbo].[pMaterialTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialTemplateItem_MaterialTemplateID] ON [dbo].[pMaterialTemplateItem] 
(
	[MaterialTemplateID] ASC,
	[MaterialTemplatePageID] ASC
)
INCLUDE ( [Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pMaterialSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSeasonYear]') AND name = N'IX_pMaterialSeasonYear_MaterialID')
DROP INDEX [IX_pMaterialSeasonYear_MaterialID] ON [dbo].[pMaterialSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialSeasonYear_MaterialID] ON [dbo].[pMaterialSeasonYear] 
(
	[MaterialID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialDocument ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialDocument]') AND name = N'IX_pMaterialDocument_MaterialID')
DROP INDEX [IX_pMaterialDocument_MaterialID] ON [dbo].[pMaterialDocument] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialDocument_MaterialID] ON [dbo].[pMaterialDocument] 
(
	[MaterialID] ASC,
	[3D] ASC
)
INCLUDE ( [MaterialDocumentShared]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pMaterialColor ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColor]') AND name = N'IX_pMaterialColor_MaterialID')
DROP INDEX [IX_pMaterialColor_MaterialID] ON [dbo].[pMaterialColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialColor_MaterialID] ON [dbo].[pMaterialColor] 
(
	[MaterialID] ASC,
	[ColorPaletteID] ASC
) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialComment]') AND name = N'IX_pMaterialComment_MaterialID')
DROP INDEX [IX_pMaterialComment_MaterialID] ON [dbo].[pMaterialComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialComment_MaterialID] ON [dbo].[pMaterialComment] 
(
	[MaterialID] ASC,
	[MDate] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialColorPending ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColorPending]') AND name = N'IX_pMaterialColorPending_MaterialID')
DROP INDEX [IX_pMaterialColorPending_MaterialID] ON [dbo].[pMaterialColorPending] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialColorPending_MaterialID] ON [dbo].[pMaterialColorPending] 
(
	[MaterialID] ASC,
	[CUser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialLinkColorwayItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialLinkColorwayItem]') AND name = N'IX_pMaterialLinkColorwayItem_MaterialColorID')
DROP INDEX [IX_pMaterialLinkColorwayItem_MaterialColorID] ON [dbo].[pMaterialLinkColorwayItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialLinkColorwayItem_MaterialColorID] ON [dbo].[pMaterialLinkColorwayItem] 
(
	[MaterialColorId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialDesign ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialDesign]') AND name = N'IX_pMaterialDesign_MaterialID')
DROP INDEX [IX_pMaterialDesign_MaterialID] ON [dbo].[pMaterialDesign] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialDesign_MaterialID] ON [dbo].[pMaterialDesign] 
(
	[MaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialCoreColor ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialCoreColor]') AND name = N'IX_pMaterialCoreColor_MaterialCoreID')
DROP INDEX [IX_pMaterialCoreColor_MaterialCoreID] ON [dbo].[pMaterialCoreColor] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialCoreColor_MaterialCoreID] ON [dbo].[pMaterialCoreColor] 
(
	[MaterialCoreID] ASC,
	[ColorPaletteID] ASC
)
INCLUDE ( [Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialCoreItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialCoreItem]') AND name = N'IX_pMaterialCoreItem_MaterialCoreID')
DROP INDEX [IX_pMaterialCoreItem_MaterialCoreID] ON [dbo].[pMaterialCoreItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialCoreItem_MaterialCoreID] ON [dbo].[pMaterialCoreItem] 
(
	[MaterialCoreID] ASC
)
INCLUDE ( [MaterialID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMaterialCoreColorItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialCoreColorItem]') AND name = N'IX_pMaterialCoreColorItem_MaterialCoreItemID')
DROP INDEX [IX_pMaterialCoreColorItem_MaterialCoreItemID] ON [dbo].[pMaterialCoreColorItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMaterialCoreColorItem_MaterialCoreItemID] ON [dbo].[pMaterialCoreColorItem] 
(
	[MaterialCoreItemID] ASC,
	[MaterialCoreColorID] ASC,
	[MaterialID] ASC
)
INCLUDE ( [MaterialColorID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09050', GetDate())
GO
