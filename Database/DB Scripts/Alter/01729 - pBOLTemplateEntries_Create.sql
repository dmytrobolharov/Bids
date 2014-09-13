IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLTemplateEntries')
CREATE TABLE [dbo].[pBOLTemplateEntries](
	[TemplateEntryId] [uniqueidentifier] NOT NULL,
	[TemplateId] [uniqueidentifier] NULL,
	[OperationId] [uniqueidentifier] NULL,
	[MacroId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pBOLTemplateEntries] PRIMARY KEY CLUSTERED 
(
	[TemplateEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLTemplateEntries] ADD  CONSTRAINT [DF_pBOLTemplateEntries_TemplateEntryId]  DEFAULT (newid()) FOR [TemplateEntryId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01729'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01729', GetDate())
END	

GO
