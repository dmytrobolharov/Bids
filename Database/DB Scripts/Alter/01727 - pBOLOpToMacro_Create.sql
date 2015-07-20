IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLOpToMacro')
CREATE TABLE [dbo].[pBOLOpToMacro](
	[OpToMacroId] [uniqueidentifier] NOT NULL,
	[MacroId] [uniqueidentifier] NULL,
	[OperationId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pBOLOpToMacro] PRIMARY KEY CLUSTERED 
(
	[OpToMacroId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLOpToMacro]  WITH CHECK ADD  CONSTRAINT [FK_pBOLOpToMacro_pBOLMacro] FOREIGN KEY([MacroId])
REFERENCES [dbo].[pBOLMacro] ([MacroId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBOLOpToMacro] CHECK CONSTRAINT [FK_pBOLOpToMacro_pBOLMacro]
GO

ALTER TABLE [dbo].[pBOLOpToMacro] ADD  CONSTRAINT [DF_pBOLOpToMacro_OpToMacroId]  DEFAULT (newid()) FOR [OpToMacroId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01727'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01727', GetDate())
END	

GO
