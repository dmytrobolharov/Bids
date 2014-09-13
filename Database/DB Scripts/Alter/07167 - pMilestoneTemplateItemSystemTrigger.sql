IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneTemplateItemSystemTrigger_SystemTriggerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneTemplateItemSystemTrigger] DROP CONSTRAINT [DF_pMilestoneTemplateItemSystemTrigger_SystemTriggerID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneTemplateItemSystemTrigger_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneTemplateItemSystemTrigger] DROP CONSTRAINT [DF_pMilestoneTemplateItemSystemTrigger_Active]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItemSystemTrigger]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplateItemSystemTrigger]
GO

CREATE TABLE [dbo].[pMilestoneTemplateItemSystemTrigger](
	[SystemTriggerID] [uniqueidentifier] NOT NULL,
	[TriggerName] [nvarchar](200) NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pMilestoneTemplateItemSystemTrigger] PRIMARY KEY CLUSTERED 
(
	[SystemTriggerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMilestoneTemplateItemSystemTrigger] ADD  CONSTRAINT [DF_pMilestoneTemplateItemSystemTrigger_SystemTriggerID]  DEFAULT (newid()) FOR [SystemTriggerID]
GO

ALTER TABLE [dbo].[pMilestoneTemplateItemSystemTrigger] ADD  CONSTRAINT [DF_pMilestoneTemplateItemSystemTrigger_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07167', GetDate())
GO
