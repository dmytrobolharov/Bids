IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateDivision]') AND name = N'PK_pTACalTemplateDivision')
ALTER TABLE [dbo].[pTACalTemplateDivision] DROP CONSTRAINT [PK_pTACalTemplateDivision]
GO

ALTER TABLE [dbo].[pTACalTemplateDivision] ADD  CONSTRAINT [PK_pTACalTemplateDivision] PRIMARY KEY CLUSTERED 
(
 [TACalTemplateDivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_ptacaltemplatedivision_ptacaltemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pTACalTemplateDivision]'))
ALTER TABLE [dbo].[pTACalTemplateDivision] DROP CONSTRAINT [fk_ptacaltemplatedivision_ptacaltemplate]
GO

ALTER TABLE [dbo].[pTACalTemplateDivision]  WITH NOCHECK ADD  CONSTRAINT [fk_ptacaltemplatedivision_ptacaltemplate] FOREIGN KEY([TACalTemplateID])
REFERENCES [dbo].[pTACalTemplate] ([TACalTemplateId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pTACalTemplateDivision] CHECK CONSTRAINT [fk_ptacaltemplatedivision_ptacaltemplate]
GO



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08898', GetDate())
GO
