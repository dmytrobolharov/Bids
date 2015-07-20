/*** pMilestoneItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneItem]') AND name = N'IX_pMilestoneItem_MilestoneID')
DROP INDEX [IX_pMilestoneItem_MilestoneID] ON [dbo].[pMilestoneItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMilestoneItem_MilestoneID] ON [dbo].[pMilestoneItem] 
(
	[MilestoneID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pMilestoneTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItem]') AND name = N'IX_pMilestoneTemplateItem_MilestoneTemplateID')
DROP INDEX [IX_pMilestoneTemplateItem_MilestoneTemplateID] ON [dbo].[pMilestoneTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pMilestoneTemplateItem_MilestoneTemplateID] ON [dbo].[pMilestoneTemplateItem] 
(
	[MilestoneTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pCalendarMilestoneItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarMilestoneItem]') AND name = N'IX_pCalendarMilestoneItem_CalendarHeaderID')
DROP INDEX [IX_pCalendarMilestoneItem_CalendarHeaderID] ON [dbo].[pCalendarMilestoneItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pCalendarMilestoneItem_CalendarHeaderID] ON [dbo].[pCalendarMilestoneItem] 
(
	[CalendarHeaderID] ASC,
	[DependentWorkflowTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09066', GetDate())
GO


