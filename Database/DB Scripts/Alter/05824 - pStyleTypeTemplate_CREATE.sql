IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTypeTemplate_StyleTypeTemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTypeTemplate] DROP CONSTRAINT [DF_pStyleTypeTemplate_StyleTypeTemplateID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTypeTemplate_IsSilhouette]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTypeTemplate] DROP CONSTRAINT [DF_pStyleTypeTemplate_IsSilhouette]
END

GO

/****** Object:  Table [dbo].[pStyleTypeTemplate]    Script Date: 06/10/2013 16:40:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTypeTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleTypeTemplate]
GO

CREATE TABLE [dbo].[pStyleTypeTemplate](
	[StyleTypeTemplateID] [uniqueidentifier] NOT NULL,
	[StyleTypeTemplateName] [nvarchar](200) NULL,
	[IsSilhouette] [int] NULL,
 CONSTRAINT [PK_pStyleTypeTemplate] PRIMARY KEY CLUSTERED 
(
	[StyleTypeTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleTypeTemplate] ADD  CONSTRAINT [DF_pStyleTypeTemplate_StyleTypeTemplateID]  DEFAULT (newid()) FOR [StyleTypeTemplateID]
GO

ALTER TABLE [dbo].[pStyleTypeTemplate] ADD  CONSTRAINT [DF_pStyleTypeTemplate_IsSilhouette]  DEFAULT ((0)) FOR [IsSilhouette]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05824', GetDate())
GO
