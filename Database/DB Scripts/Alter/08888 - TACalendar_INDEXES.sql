/* pPlanningTACalendar */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningTACalendar]') AND name = N'pPlanningTACalendar_PlanningID_SeasonYearID')
DROP INDEX [pPlanningTACalendar_PlanningID_SeasonYearID] ON [dbo].[pPlanningTACalendar] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [pPlanningTACalendar_PlanningID_SeasonYearID] ON [dbo].[pPlanningTACalendar] 
(
	[PlanningID] ASC,
	[SeasonYearID] ASC
)
INCLUDE ( [TACalTemplateID], [Sort]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/* pTACalTemplateDivision */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateDivision]') AND name = N'IX_pTACalTemplateDivision_DivisionID')
DROP INDEX [IX_pTACalTemplateDivision_DivisionID] ON [dbo].[pTACalTemplateDivision] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalTemplateDivision_DivisionID] ON [dbo].[pTACalTemplateDivision] 
(
	[DivisionID] ASC
)
INCLUDE ( [TACalTemplateID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateDivision]') AND name = N'IX_pTACalTemplateDivision_TACalTemplateId')
DROP INDEX [IX_pTACalTemplateDivision_TACalTemplateId] ON [dbo].[pTACalTemplateDivision] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalTemplateDivision_TACalTemplateId] ON [dbo].[pTACalTemplateDivision] 
(
	[TACalTemplateID] ASC
)
INCLUDE ( [DivisionID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* pTimeActionHistory */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTimeActionHistory]') AND name = N'IX_pTimeActionHistory_TeamID')
DROP INDEX [IX_pTimeActionHistory_TeamID] ON [dbo].[pTimeActionHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTimeActionHistory_TeamID] ON [dbo].[pTimeActionHistory] 
(
	[TeamID] ASC,
	[TACalTemplateID] ASC
)
INCLUDE ( [CDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* pTACalReference */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReference]') AND name = N'IX_pTACalReference_TACalTemplateID_ReferenceID')
DROP INDEX [IX_pTACalReference_TACalTemplateID_ReferenceID] ON [dbo].[pTACalReference] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalReference_TACalTemplateID_ReferenceID] ON [dbo].[pTACalReference] 
(
	[TACalTemplateId] ASC,
	[ReferenceId] ASC
)
INCLUDE ( [TACalReferenceTypeId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/* pTACalTemplateTaskDep */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTaskDep]') AND name = N'IX_pTACalTemplateTaskdep_ChildID')
DROP INDEX [IX_pTACalTemplateTaskdep_ChildID] ON [dbo].[pTACalTemplateTaskDep] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalTemplateTaskdep_ChildID] ON [dbo].[pTACalTemplateTaskDep] 
(
	[TACalTemplateTaskChildId] ASC,
	[TACalTemplateTaskParentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* pTACalReferenceTask */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]') AND name = N'IX_pTACalReferenceTask_TACalTemplateTaskID')
DROP INDEX [IX_pTACalReferenceTask_TACalTemplateTaskID] ON [dbo].[pTACalReferenceTask] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalReferenceTask_TACalTemplateTaskID] ON [dbo].[pTACalReferenceTask] 
(
	[TACalTemplateTaskId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/* pStyleWorkflow */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND name = N'IX_pStyleWorkflow_StyleID')
DROP INDEX [IX_pStyleWorkflow_StyleID] ON [dbo].[pStyleWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pStyleWorkflow_StyleID] ON [dbo].[pStyleWorkflow] 
(
	[StyleID] ASC,
	[StyleSet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08888', GetDate())
GO


