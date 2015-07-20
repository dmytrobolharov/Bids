IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFlashEditQuickFillItemTemp_QuickFillTempItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp] DROP CONSTRAINT [DF_pPlanningFlashEditQuickFillItemTemp_QuickFillTempItemID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEditQuickFillItemTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp]
GO

CREATE TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp](
	[QuickFillTempItemID] [uniqueidentifier] NOT NULL,
	[QuickFillID] [uniqueidentifier] NULL,
	[QuickFillFieldName] [nvarchar](200) NULL,
	[QuickFillFieldValue] [nvarchar](500) NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningFlashEditQuickFillItemTemp] PRIMARY KEY CLUSTERED 
(
	[QuickFillTempItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp] ADD  CONSTRAINT [DF_pPlanningFlashEditQuickFillItemTemp_QuickFillTempItemID]  DEFAULT (newid()) FOR [QuickFillTempItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06369', GetDate())
GO
