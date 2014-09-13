IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pTACalTemplateTask_pTACalStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateTask]'))
ALTER TABLE [dbo].[pTACalTemplateTask] DROP CONSTRAINT [FK_pTACalTemplateTask_pTACalStatus]
GO

ALTER TABLE [dbo].[pTACalTemplateTask]  WITH CHECK ADD  CONSTRAINT [FK_pTACalTemplateTask_pTACalStatus] FOREIGN KEY([TaskStatus])
REFERENCES [dbo].[pTACalStatus] ([StatusID])
ON UPDATE CASCADE 
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[pTACalTemplateTask] CHECK CONSTRAINT [FK_pTACalTemplateTask_pTACalStatus]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09046', GetDate())
GO
