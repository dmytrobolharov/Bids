IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningColor_PlanningColorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningColor] DROP CONSTRAINT [DF_pPlanningColor_PlanningColorID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningColor]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningColor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pPlanningColor](
	[PlanningColorID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NOT NULL,
	[ColorFolderID] [uniqueidentifier] NOT NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [nvarchar](200) NULL,
	[CustomField8] [nvarchar](200) NULL,
	[CustomField9] [nvarchar](200) NULL,
	[CustomField10] [nvarchar](200) NULL,
 CONSTRAINT [PK_pPlanningColor] PRIMARY KEY CLUSTERED 
(
	[PlanningColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningColor] ADD  CONSTRAINT [DF_pPlanningColor_PlanningColorID]  DEFAULT (newid()) FOR [PlanningColorID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06333', GetDate())
GO
