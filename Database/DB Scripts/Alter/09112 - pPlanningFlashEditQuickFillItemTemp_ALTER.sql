IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Fk_pPlanningFlashEditQuickFillItemTemp_pPlanningFlashEditQuickFill]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEditQuickFillItemTemp]'))
ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp] DROP CONSTRAINT [Fk_pPlanningFlashEditQuickFillItemTemp_pPlanningFlashEditQuickFill]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09112', GetDate())
GO
