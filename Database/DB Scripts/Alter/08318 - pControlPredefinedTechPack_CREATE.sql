IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pControlPredefinedTechPackConfig_Availible]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pControlPredefinedTechPackConfig] DROP CONSTRAINT [DF_pControlPredefinedTechPackConfig_Availible]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pControlPredefinedTechPackConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pControlPredefinedTechPackConfig]
GO

CREATE TABLE [dbo].[pControlPredefinedTechPackConfig](
	[DivisionID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
	[ReportTechPackFolderID] [uniqueidentifier] NOT NULL,
	[Availible] [bit] NOT NULL,
 CONSTRAINT [PK_pControlPredefinedTechPackConfig] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[StyleTypeID] ASC,
	[ReportTechPackFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pControlPredefinedTechPackConfig] ADD  CONSTRAINT [DF_pControlPredefinedTechPackConfig_Availible]  DEFAULT ((0)) FOR [Availible]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08318', GetDate())
GO
