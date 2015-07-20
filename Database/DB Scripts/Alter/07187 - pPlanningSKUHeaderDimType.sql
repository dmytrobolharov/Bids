IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningSKUHeaderDimType_PlanningSKUHeaderDimTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningSKUHeaderDimType] DROP CONSTRAINT [DF_pPlanningSKUHeaderDimType_PlanningSKUHeaderDimTypeID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningSKUHeaderDimType]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningSKUHeaderDimType]
GO

CREATE TABLE [dbo].[pPlanningSKUHeaderDimType](
	[PlanningSKUHeaderDimTypeID] [uniqueidentifier] NOT NULL,
	[PlanningSKUHeaderID] [uniqueidentifier] NULL,
	[DimTypeID] [uniqueidentifier] NULL,
	[Position] [int] NULL,
 CONSTRAINT [PK_pPlanningSKUHeaderDimType] PRIMARY KEY CLUSTERED 
(
	[PlanningSKUHeaderDimTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningSKUHeaderDimType] ADD  CONSTRAINT [DF_pPlanningSKUHeaderDimType_PlanningSKUHeaderDimTypeID]  DEFAULT (newid()) FOR [PlanningSKUHeaderDimTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07187', GetDate())
GO
