IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLMacro')
CREATE TABLE [dbo].[pBOLMacro](
	[MacroId] [uniqueidentifier] NOT NULL,
	[MacroCode] [nvarchar](200) NULL,
	[MacroName] [nvarchar](200) NULL,
	[Image] [uniqueidentifier] NULL,
	[Comments] [nvarchar](max) NULL,
	[Approved] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLMacro] PRIMARY KEY CLUSTERED 
(
	[MacroId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLMacro] ADD  CONSTRAINT [DF_pBOLMacro_MacroId]  DEFAULT (newid()) FOR [MacroId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01718'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01718', GetDate())
END	

GO
