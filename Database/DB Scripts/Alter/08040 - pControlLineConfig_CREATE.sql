IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pControlLineConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pControlLineConfig]
GO

CREATE TABLE [dbo].[pControlLineConfig](
	[DivisionID] [uniqueidentifier] NOT NULL,
	[LineListConfigID] [uniqueidentifier] NOT NULL,
	[LineListConfigName] [nvarchar](200) NULL,
	[PlanningLockColorPalette] [int] NOT NULL,
	[PlanningLockMaterialPalette] [int] NOT NULL,
 CONSTRAINT [PK_pControlLineConfig] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[LineListConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08040', GetDate())
GO
