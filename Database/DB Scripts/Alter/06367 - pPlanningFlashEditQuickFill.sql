IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFlashEditQuickFill_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFlashEditQuickFill] DROP CONSTRAINT [DF_pPlanningFlashEditQuickFill_Active]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEditQuickFill]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningFlashEditQuickFill]
GO

CREATE TABLE [dbo].[pPlanningFlashEditQuickFill](
	[QuickFillID] [uniqueidentifier] NOT NULL,
	[QuickFillName] [nvarchar](200) NULL,
	[QuickFillDescription] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[StyleTypeID] [int] NULL,
	[StyleCategoryID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pPlanningFlashEditQuickFill] PRIMARY KEY CLUSTERED 
(
	[QuickFillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFill] ADD  CONSTRAINT [DF_pPlanningFlashEditQuickFill_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06367', GetDate())
GO
