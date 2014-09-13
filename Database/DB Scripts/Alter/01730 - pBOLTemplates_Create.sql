IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLTemplates')
CREATE TABLE [dbo].[pBOLTemplates](
	[TemplateId] [uniqueidentifier] NOT NULL,
	[TemplateCode] [nvarchar](200) NULL,
	[TemplateName] [nvarchar](200) NULL,
	[Image] [uniqueidentifier] NULL,
	[Comments] [nvarchar](max) NULL,
	[Approved] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLTemplates] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLTemplates] ADD  CONSTRAINT [DF_pBOLTemplates_TemplateId]  DEFAULT (newid()) FOR [TemplateId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01730'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01730', GetDate())
END	

GO
