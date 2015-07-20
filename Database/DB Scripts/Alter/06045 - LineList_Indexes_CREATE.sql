/******************
* pLineFolderItem *
*******************/

/****** Object:  Index [IX_pLineFolderItem]    Script Date: 07/11/2013 15:14:27 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItem]') AND name = N'IX_pLineFolderItem')
DROP INDEX [IX_pLineFolderItem] ON [dbo].[pLineFolderItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderItem]    Script Date: 07/11/2013 15:14:28 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderItem] ON [dbo].[pLineFolderItem] 
(
	[LineFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pLineFolderItem_1]    Script Date: 07/11/2013 15:14:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItem]') AND name = N'IX_pLineFolderItem_1')
DROP INDEX [IX_pLineFolderItem_1] ON [dbo].[pLineFolderItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderItem_1]    Script Date: 07/11/2013 15:14:37 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderItem_1] ON [dbo].[pLineFolderItem] 
(
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pLineFolderItem_2]    Script Date: 07/11/2013 15:14:45 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItem]') AND name = N'IX_pLineFolderItem_2')
DROP INDEX [IX_pLineFolderItem_2] ON [dbo].[pLineFolderItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderItem_2]    Script Date: 07/11/2013 15:14:46 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderItem_2] ON [dbo].[pLineFolderItem] 
(
	[LineFolderID] ASC,
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pLineFolderItem_3]    Script Date: 07/11/2013 16:10:40 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItem]') AND name = N'IX_pLineFolderItem_3')
DROP INDEX [IX_pLineFolderItem_3] ON [dbo].[pLineFolderItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderItem_3]    Script Date: 07/11/2013 16:10:40 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderItem_3] ON [dbo].[pLineFolderItem] 
(
	[LineFolderID] ASC,
	[LineFolderItemDrop] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pLineFolderItem_4]    Script Date: 07/11/2013 16:15:39 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItem]') AND name = N'IX_pLineFolderItem_4')
DROP INDEX [IX_pLineFolderItem_4] ON [dbo].[pLineFolderItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderItem_4]    Script Date: 07/11/2013 16:15:39 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderItem_4] ON [dbo].[pLineFolderItem] 
(
	[StyleID] ASC,
	[LineFolderID] ASC,
	[StyleSeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*********************
* pDivisionStyleType *
**********************/

/****** Object:  Index [IX_pDivisionStyleType_2]    Script Date: 07/11/2013 15:18:48 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pDivisionStyleType]') AND name = N'IX_pDivisionStyleType_2')
DROP INDEX [IX_pDivisionStyleType_2] ON [dbo].[pDivisionStyleType] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pDivisionStyleType_2]    Script Date: 07/11/2013 15:18:48 ******/
CREATE NONCLUSTERED INDEX [IX_pDivisionStyleType_2] ON [dbo].[pDivisionStyleType] 
(
	[DivisionID] ASC,
	[StyleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/**************************
* pStyleCategoryStyleType *
***************************/

/****** Object:  Index [IX_pStyleCategoryStyleType]    Script Date: 07/11/2013 15:32:32 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCategoryStyleType]') AND name = N'IX_pStyleCategoryStyleType')
DROP INDEX [IX_pStyleCategoryStyleType] ON [dbo].[pStyleCategoryStyleType] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pStyleCategoryStyleType]    Script Date: 07/11/2013 15:32:32 ******/
CREATE NONCLUSTERED INDEX [IX_pStyleCategoryStyleType] ON [dbo].[pStyleCategoryStyleType] 
(
	[StyleCategoryID] ASC,
	[StyleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****************************
* pCalendarHeaderToDivision *
*****************************/

/****** Object:  Index [IX_pCalendarHeaderToDivision]    Script Date: 07/11/2013 15:36:03 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarHeaderToDivision]') AND name = N'IX_pCalendarHeaderToDivision')
DROP INDEX [IX_pCalendarHeaderToDivision] ON [dbo].[pCalendarHeaderToDivision] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pCalendarHeaderToDivision]    Script Date: 07/11/2013 15:36:03 ******/
CREATE NONCLUSTERED INDEX [IX_pCalendarHeaderToDivision] ON [dbo].[pCalendarHeaderToDivision] 
(
	[CalendarHeaderID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************
* pStyleMaterial *
******************/

/****** Object:  Index [IX_pStyleMaterial]    Script Date: 07/11/2013 15:49:05 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMaterials]') AND name = N'IX_pStyleMaterial')
DROP INDEX [IX_pStyleMaterial] ON [dbo].[pStyleMaterials] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pStyleMaterial]    Script Date: 07/11/2013 15:49:05 ******/
CREATE NONCLUSTERED INDEX [IX_pStyleMaterial] ON [dbo].[pStyleMaterials] 
(
	[MainMaterial] ASC
)
INCLUDE ( [StyleSet],
[StyleID],
[MaterialName],
[F],
[H],
[I]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/***********************
* pLineFolderItemColor *
************************/

/****** Object:  Index [IX_pLineFolderItemColor]    Script Date: 07/11/2013 15:53:07 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItemColor]') AND name = N'IX_pLineFolderItemColor')
DROP INDEX [IX_pLineFolderItemColor] ON [dbo].[pLineFolderItemColor] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderItemColor]    Script Date: 07/11/2013 15:53:07 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderItemColor] ON [dbo].[pLineFolderItemColor] 
(
	[LineFolderItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*********************
* pStyleColorwayItem *
**********************/

/****** Object:  Index [IX_pStyleColorwayItem]    Script Date: 07/11/2013 15:56:15 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayItem]') AND name = N'IX_pStyleColorwayItem')
DROP INDEX [IX_pStyleColorwayItem] ON [dbo].[pStyleColorwayItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pStyleColorwayItem]    Script Date: 07/11/2013 15:56:15 ******/
CREATE NONCLUSTERED INDEX [IX_pStyleColorwayItem] ON [dbo].[pStyleColorwayItem] 
(
	[StyleColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*********************
* sAccessStyleFolder *
**********************/

/****** Object:  Index [IX_sAccessStyleFolder]    Script Date: 07/11/2013 16:20:24 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sAccessStyleFolder]') AND name = N'IX_sAccessStyleFolder')
DROP INDEX [IX_sAccessStyleFolder] ON [dbo].[sAccessStyleFolder] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_sAccessStyleFolder]    Script Date: 07/11/2013 16:20:24 ******/
CREATE NONCLUSTERED INDEX [IX_sAccessStyleFolder] ON [dbo].[sAccessStyleFolder] 
(
	[TeamId] ASC,
	[StyleTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_sAccessStyleFolder_1]    Script Date: 07/11/2013 16:31:28 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sAccessStyleFolder]') AND name = N'IX_sAccessStyleFolder_1')
DROP INDEX [IX_sAccessStyleFolder_1] ON [dbo].[sAccessStyleFolder] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_sAccessStyleFolder_1]    Script Date: 07/11/2013 16:31:28 ******/
CREATE NONCLUSTERED INDEX [IX_sAccessStyleFolder_1] ON [dbo].[sAccessStyleFolder] 
(
	[TeamId] ASC,
	[StyleTypeId] ASC,
	[AccessRoleId] ASC,
	[AccessModify] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/***************************
* sAccessLineFolderPalette *
****************************/

/****** Object:  Index [IX_sAccessLineFolderPalette]    Script Date: 07/11/2013 16:25:44 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sAccessLineFolderPalette]') AND name = N'IX_sAccessLineFolderPalette')
DROP INDEX [IX_sAccessLineFolderPalette] ON [dbo].[sAccessLineFolderPalette] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_sAccessLineFolderPalette]    Script Date: 07/11/2013 16:25:44 ******/
CREATE NONCLUSTERED INDEX [IX_sAccessLineFolderPalette] ON [dbo].[sAccessLineFolderPalette] 
(
	[LineTypeID] ASC,
	[LinePaletteID] ASC,
	[TeamID] ASC
)
INCLUDE ( [AccessLinePaletteID],
[AccessRoleId],
[AccessView],
[AccessCreate],
[AccessModify],
[AccessDelete],
[AccessPrint],
[CUser],
[CDate],
[MUser],
[MDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/***************************
* pStyleColorwaySeasonYear *
****************************/

/****** Object:  Index [IX_pStyleColorwaySeasonYear]    Script Date: 07/11/2013 16:35:40 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwaySeasonYear]') AND name = N'IX_pStyleColorwaySeasonYear')
DROP INDEX [IX_pStyleColorwaySeasonYear] ON [dbo].[pStyleColorwaySeasonYear] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pStyleColorwaySeasonYear]    Script Date: 07/11/2013 16:35:40 ******/
CREATE NONCLUSTERED INDEX [IX_pStyleColorwaySeasonYear] ON [dbo].[pStyleColorwaySeasonYear] 
(
	[StyleSeasonYearID] ASC,
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*******************
* pStyleSeasonYear *
********************/

/****** Object:  Index [IX_pStyleSeasonYear]    Script Date: 07/11/2013 16:43:16 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSeasonYear]') AND name = N'IX_pStyleSeasonYear')
DROP INDEX [IX_pStyleSeasonYear] ON [dbo].[pStyleSeasonYear] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pStyleSeasonYear]    Script Date: 07/11/2013 16:43:16 ******/
CREATE NONCLUSTERED INDEX [IX_pStyleSeasonYear] ON [dbo].[pStyleSeasonYear] 
(
	[StyleID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/************************
* pLineListFlashCosting *
*************************/

/****** Object:  Index [IX_pLineListFlashCosting]    Script Date: 07/11/2013 16:53:04 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineListFlashCosting]') AND name = N'IX_pLineListFlashCosting')
DROP INDEX [IX_pLineListFlashCosting] ON [dbo].[pLineListFlashCosting] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineListFlashCosting]    Script Date: 07/11/2013 16:53:04 ******/
CREATE NONCLUSTERED INDEX [IX_pLineListFlashCosting] ON [dbo].[pLineListFlashCosting] 
(
	[LineFolderItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****************************
* pSampleRequestWorkflowBOM *
*****************************/

/****** Object:  Index [IX_pSampleRequestWorkflowBOM_1]    Script Date: 07/11/2013 16:57:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOM]') AND name = N'IX_pSampleRequestWorkflowBOM_1')
DROP INDEX [IX_pSampleRequestWorkflowBOM_1] ON [dbo].[pSampleRequestWorkflowBOM] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pSampleRequestWorkflowBOM_1]    Script Date: 07/11/2013 16:57:36 ******/
CREATE NONCLUSTERED INDEX [IX_pSampleRequestWorkflowBOM_1] ON [dbo].[pSampleRequestWorkflowBOM] 
(
	[StyleID] ASC
)
INCLUDE ( [SampleWorkflowID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*************************
* pStyleBOMDimensionItem *
**************************/

/****** Object:  Index [IX_pStyleBOMDimensionItem]    Script Date: 07/11/2013 17:06:59 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionItem]') AND name = N'IX_pStyleBOMDimensionItem')
DROP INDEX [IX_pStyleBOMDimensionItem] ON [dbo].[pStyleBOMDimensionItem] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pStyleBOMDimensionItem]    Script Date: 07/11/2013 17:07:00 ******/
CREATE NONCLUSTERED INDEX [IX_pStyleBOMDimensionItem] ON [dbo].[pStyleBOMDimensionItem] 
(
	[StyleBOMDimensionID] ASC,
	[ItemDim1Id] ASC
)
INCLUDE ( [ItemDim1Name]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/**********************
* pLineFolderBusiness *
***********************/

/****** Object:  Index [IX_pLineFolderBusiness]    Script Date: 07/11/2013 17:18:51 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderBusiness]') AND name = N'IX_pLineFolderBusiness')
DROP INDEX [IX_pLineFolderBusiness] ON [dbo].[pLineFolderBusiness] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderBusiness]    Script Date: 07/11/2013 17:18:51 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderBusiness] ON [dbo].[pLineFolderBusiness] 
(
	[LineFolderID] ASC
)
INCLUDE ( [LineFolderDivisionID],
[LineFolderStyleTypeID],
[LineFolderStyleCategoryID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pLineFolderBusiness_1]    Script Date: 07/11/2013 17:41:33 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderBusiness]') AND name = N'IX_pLineFolderBusiness_1')
DROP INDEX [IX_pLineFolderBusiness_1] ON [dbo].[pLineFolderBusiness] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pLineFolderBusiness_1]    Script Date: 07/11/2013 17:41:33 ******/
CREATE NONCLUSTERED INDEX [IX_pLineFolderBusiness_1] ON [dbo].[pLineFolderBusiness] 
(
	[LineFolderStyleTypeID] ASC,
	[LineFolderStyleCategoryID] ASC,
	[LineFolderBusinessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06045', GetDate())
GO
