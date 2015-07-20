/*****************************/
/******* pAmlMeasHeader ******/
/*****************************/

/****** Object:  Index [IX_pAMLMeasHdr]    Script Date: 06/13/2013 12:45:33 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasHdr]') AND name = N'IX_pAMLMeasHdr')
DROP INDEX [IX_pAMLMeasHdr] ON [dbo].[pAMLMeasHdr] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pAMLMeasHdr]    Script Date: 06/13/2013 12:45:34 ******/
CREATE NONCLUSTERED INDEX [IX_pAMLMeasHdr] ON [dbo].[pAMLMeasHdr] 
(
	[WorkFlowItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pAMLMeasHdr_1]    Script Date: 06/13/2013 12:45:53 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasHdr]') AND name = N'IX_pAMLMeasHdr_1')
DROP INDEX [IX_pAMLMeasHdr_1] ON [dbo].[pAMLMeasHdr] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pAMLMeasHdr_1]    Script Date: 06/13/2013 12:45:53 ******/
CREATE NONCLUSTERED INDEX [IX_pAMLMeasHdr_1] ON [dbo].[pAMLMeasHdr] 
(
	[Workflowid] ASC,
	[WorkFlowItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************************/
/******* pAmlMeasIGC *********/
/*****************************/

/****** Object:  Index [IX_AmlMeasIGC_1]    Script Date: 06/13/2013 12:46:50 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasIGC]') AND name = N'IX_AmlMeasIGC_1')
DROP INDEX [IX_AmlMeasIGC_1] ON [dbo].[pAMLMeasIGC] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_AmlMeasIGC_1]    Script Date: 06/13/2013 12:46:50 ******/
CREATE NONCLUSTERED INDEX [IX_AmlMeasIGC_1] ON [dbo].[pAMLMeasIGC] 
(
	[AMLMeasHdrId] ASC
)
INCLUDE ( [AMLMeasPOMId],
[POM_Row],
[SizeCol],
[Incr]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************************/
/******* pAmlMeasLbl *********/
/*****************************/

/****** Object:  Index [IX_pAMLMeasLbl]    Script Date: 06/13/2013 12:47:23 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasLbl]') AND name = N'IX_pAMLMeasLbl')
DROP INDEX [IX_pAMLMeasLbl] ON [dbo].[pAMLMeasLbl] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pAMLMeasLbl]    Script Date: 06/13/2013 12:47:24 ******/
CREATE NONCLUSTERED INDEX [IX_pAMLMeasLbl] ON [dbo].[pAMLMeasLbl] 
(
	[AMLMeasHdrId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************************/
/******* pAmlMeasPOM *********/
/*****************************/

/****** Object:  Index [IX_pAMLMeasPOM]    Script Date: 06/13/2013 12:47:51 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasPOM]') AND name = N'IX_pAMLMeasPOM')
DROP INDEX [IX_pAMLMeasPOM] ON [dbo].[pAMLMeasPOM] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pAMLMeasPOM]    Script Date: 06/13/2013 12:47:51 ******/
CREATE NONCLUSTERED INDEX [IX_pAMLMeasPOM] ON [dbo].[pAMLMeasPOM] 
(
	[AMLMeasHdrId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pAMLMeasPOM_1]    Script Date: 06/13/2013 12:48:03 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasPOM]') AND name = N'IX_pAMLMeasPOM_1')
DROP INDEX [IX_pAMLMeasPOM_1] ON [dbo].[pAMLMeasPOM] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pAMLMeasPOM_1]    Script Date: 06/13/2013 12:48:03 ******/
CREATE NONCLUSTERED INDEX [IX_pAMLMeasPOM_1] ON [dbo].[pAMLMeasPOM] 
(
	[POM_Row] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_pAMLMeasPOM_2]    Script Date: 06/13/2013 12:48:17 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasPOM]') AND name = N'IX_pAMLMeasPOM_2')
DROP INDEX [IX_pAMLMeasPOM_2] ON [dbo].[pAMLMeasPOM] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pAMLMeasPOM_2]    Script Date: 06/13/2013 12:48:17 ******/
CREATE NONCLUSTERED INDEX [IX_pAMLMeasPOM_2] ON [dbo].[pAMLMeasPOM] 
(
	[AMLMeasHdrId] ASC,
	[POM_Row] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*****************************/
/* pGRMeasurementsClassRange */
/*****************************/

/****** Object:  Index [IX_pGRMeasurementsClassRange]    Script Date: 06/13/2013 12:48:53 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsClassRange]') AND name = N'IX_pGRMeasurementsClassRange')
DROP INDEX [IX_pGRMeasurementsClassRange] ON [dbo].[pGRMeasurementsClassRange] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [IX_pGRMeasurementsClassRange]    Script Date: 06/13/2013 12:48:53 ******/
CREATE NONCLUSTERED INDEX [IX_pGRMeasurementsClassRange] ON [dbo].[pGRMeasurementsClassRange] 
(
	[SizeClass] ASC,
	[SizeRange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06066', GetDate())
GO
