/*** pColorPalette ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorPalette]') AND name = N'IX_pColorPalette_ColorFolderID')
DROP INDEX [IX_pColorPalette_ColorFolderID] ON [dbo].[pColorPalette] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorPalette_ColorFolderID] ON [dbo].[pColorPalette] 
(
	[ColorFolderID] ASC
)
INCLUDE ( [ColorCode],
[ColorName],
[CUser],
[Status],
[Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pColorFolder ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolder]') AND name = N'IX_pColorFolder_ColorTypeID')
DROP INDEX [IX_pColorFolder_ColorTypeID] ON [dbo].[pColorFolder] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorFolder_ColorTypeID] ON [dbo].[pColorFolder] 
(
	[ColorTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pColorType ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorType]') AND name = N'IX_pColorType_ColorTypeID')
DROP INDEX [IX_pColorType_ColorTypeID] ON [dbo].[pColorType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorType_ColorTypeID] ON [dbo].[pColorType] 
(
	[ColorTypeID] ASC,
	[CorpColor] ASC
)
INCLUDE ( [Sort], [Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pColorHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorHistory]') AND name = N'IX_pColorHistory_TeamID')
DROP INDEX [IX_pColorHistory_TeamID] ON [dbo].[pColorHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorHistory_TeamID] ON [dbo].[pColorHistory] 
(
	[TeamID] ASC,
	[CDate] DESC
)
INCLUDE ( [ColorFolderID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pColorPaletteSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorPaletteSeasonYear]') AND name = N'IX_pColorPaletteSeasonYear_ColorPaletteID')
DROP INDEX [IX_pColorPaletteSeasonYear_ColorPaletteID] ON [dbo].[pColorPaletteSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorPaletteSeasonYear_ColorPaletteID] ON [dbo].[pColorPaletteSeasonYear] 
(
	[ColorPaletteID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pColorFolderSeasonYear ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolderSeasonYear]') AND name = N'IX_pColorFolderSeasonYear_ColorFolderID')
DROP INDEX [IX_pColorFolderSeasonYear_ColorFolderID] ON [dbo].[pColorFolderSeasonYear] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorFolderSeasonYear_ColorFolderID] ON [dbo].[pColorFolderSeasonYear] 
(
	[ColorFolderID] ASC
)
INCLUDE ( [SeasonYearID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pColorFolderWorkflowPage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolderWorkflowPage]') AND name = N'IX_pColorFolderWorkflowPage_ColorFolderID')
DROP INDEX [IX_pColorFolderWorkflowPage_ColorFolderID] ON [dbo].[pColorFolderWorkflowPage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pColorFolderWorkflowPage_ColorFolderID] ON [dbo].[pColorFolderWorkflowPage] 
(
	[ColorFolderID] ASC,
	[ColorFolderWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** ColorLibraryPending ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ColorLibraryPending]') AND name = N'IX_ColorLibraryPending_ColorFolderID')
DROP INDEX [IX_ColorLibraryPending_ColorFolderID] ON [dbo].[ColorLibraryPending] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_ColorLibraryPending_ColorFolderID] ON [dbo].[ColorLibraryPending] 
(
	[ColorFolderID] ASC,
	[CUser] ASC,
	[isUpload] ASC
)
INCLUDE([MUser], [Active]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** ColorLibrary ****/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ColorLibrary]') AND name = N'IX_ColorLibrary_ColorLibraryTypeID')
DROP INDEX [IX_ColorLibrary_ColorLibraryTypeID] ON [dbo].[ColorLibrary] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_ColorLibrary_ColorLibraryTypeID] ON [dbo].[ColorLibrary] 
(
	[ColorLibraryTypeID] ASC,
	[ColorLibraryID] ASC
)
INCLUDE ( [H],
[S],
[L],
[PantoneType],
[PantoneNumber],
[PantoneName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09052', GetDate())
GO
