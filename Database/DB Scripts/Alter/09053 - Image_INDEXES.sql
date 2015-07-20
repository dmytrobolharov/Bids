/*** hImage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[hImage]') AND name = N'IX_hImage_ImageID')
DROP INDEX [IX_hImage_ImageID] ON [dbo].[hImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_hImage_ImageID] ON [dbo].[hImage] 
(
	[ImageID] ASC,
	[Version] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pImage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImage]') AND name = N'IX_pImage_ImageSubFolder1')
DROP INDEX [IX_pImage_ImageSubFolder1] ON [dbo].[pImage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImage_ImageSubFolder1] ON [dbo].[pImage] 
(
	[ImageSubFolder1] ASC
)
INCLUDE ( [MDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pImageWFValidation ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImageWFValidation]') AND name = N'IX_pImageWFValidation_WorkflowID')
DROP INDEX [IX_pImageWFValidation_WorkflowID] ON [dbo].[pImageWFValidation] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImageWFValidation_WorkflowID] ON [dbo].[pImageWFValidation] 
(
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pImageHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImageHistory]') AND name = N'IX_pImageHistory_TeamID')
DROP INDEX [IX_pImageHistory_TeamID] ON [dbo].[pImageHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImageHistory_TeamID] ON [dbo].[pImageHistory] 
(
	[TeamID] ASC,
	[ImageID] ASC
)
INCLUDE ( [CDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pImageCatalogItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalogItem]') AND name = N'IX_pImageCatalogItem_ImageCatalogID')
DROP INDEX [IX_pImageCatalogItem_ImageCatalogID] ON [dbo].[pImageCatalogItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImageCatalogItem_ImageCatalogID] ON [dbo].[pImageCatalogItem] 
(
	[ImageCatalogID] ASC
)
INCLUDE ( [ImageID],
[ImageVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalogItem]') AND name = N'IX_pImageCatalogItem_ImageID')
DROP INDEX [IX_pImageCatalogItem_ImageID] ON [dbo].[pImageCatalogItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImageCatalogItem_ImageID] ON [dbo].[pImageCatalogItem] 
(
	[ImageID] ASC
)
INCLUDE ( [ImageCatalogID],
[ImageVersion]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pImageWorkflowPage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImageWorkflowPage]') AND name = N'IX_pImageWorkflowPage_ImageID')
DROP INDEX [IX_pImageWorkflowPage_ImageID] ON [dbo].[pImageWorkflowPage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImageWorkflowPage_ImageID] ON [dbo].[pImageWorkflowPage] 
(
	[ImageID] ASC
)
INCLUDE ( [ImageWorkflowTemplateItemID],
[WorkAssignedTo],
[WorkStatus]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pImageComment ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pImageComment]') AND name = N'IX_pImageComment_ImageID')
DROP INDEX [IX_pImageComment_ImageID] ON [dbo].[pImageComment] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pImageComment_ImageID] ON [dbo].[pImageComment] 
(
	[ImageID] ASC,
	[ImageCatalogID] ASC,
	[MDate] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09053', GetDate())
GO
