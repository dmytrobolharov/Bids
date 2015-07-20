IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUTemplate_StyleSKUTemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUTemplate] DROP CONSTRAINT [DF_pStyleSKUTemplate_StyleSKUTemplateID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSKUTemplate_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSKUTemplate] DROP CONSTRAINT [DF_pStyleSKUTemplate_Active]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSKUTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleSKUTemplate]
GO

CREATE TABLE [dbo].[pStyleSKUTemplate](
	[StyleSKUTemplateID] [uniqueidentifier] NOT NULL,
	[TemplateName] [nvarchar](200) NULL,
	[FlashEditSchema] [nvarchar](400) NULL,
	[SearchSchema] [nvarchar](400) NULL,
	[GridSchema] [nvarchar](400) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_pStyleSKUTemplate] PRIMARY KEY CLUSTERED 
(
	[StyleSKUTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleSKUTemplate] ADD  CONSTRAINT [DF_pStyleSKUTemplate_StyleSKUTemplateID]  DEFAULT (newid()) FOR [StyleSKUTemplateID]
GO

ALTER TABLE [dbo].[pStyleSKUTemplate] ADD  CONSTRAINT [DF_pStyleSKUTemplate_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06999', GetDate())
GO
