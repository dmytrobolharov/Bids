IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningSKUHeader_PlanningSKUItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningSKUHeader] DROP CONSTRAINT [DF_pPlanningSKUHeader_PlanningSKUItemID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningSKUHeader]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningSKUHeader]
GO

CREATE TABLE [dbo].[pPlanningSKUHeader](
	[PlanningSKUHeaderID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[StyleSKUTemplateID] [uniqueidentifier] NULL,
	[PlanningSKUHeaderName] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pPlanningSKUHeader] PRIMARY KEY CLUSTERED 
(
	[PlanningSKUHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningSKUHeader] ADD  CONSTRAINT [DF_pPlanningSKUHeader_PlanningSKUItemID]  DEFAULT (newid()) FOR [PlanningSKUHeaderID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07186', GetDate())
GO
