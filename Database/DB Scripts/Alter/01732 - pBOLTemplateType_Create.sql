IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLTemplateType')
CREATE TABLE [dbo].[pBOLTemplateType](
	[TypeId] [uniqueidentifier] NOT NULL,
	[TypeName] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[SubcategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLTemplateType] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLTemplateType] ADD  CONSTRAINT [DF_pBOLTemplateType_TypeId]  DEFAULT (newid()) FOR [TypeId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01732'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01732', GetDate())
END	

GO
