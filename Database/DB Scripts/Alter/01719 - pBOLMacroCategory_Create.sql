IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLMacroCategory')
CREATE TABLE [dbo].[pBOLMacroCategory](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[CategoryName] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLMacroCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLMacroCategory] ADD  CONSTRAINT [DF_pBOLMacroCategory_CategoryId]  DEFAULT (newid()) FOR [CategoryId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01719'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01719', GetDate())
END	

GO
