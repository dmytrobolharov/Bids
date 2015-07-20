IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLMacro_MacroID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLMacro] DROP CONSTRAINT [DF_pNBOLMacro_MacroID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLMacro]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLMacro]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLMacro](
	[MacroID] [uniqueidentifier] NOT NULL,
	[MacroCode] [nvarchar](200) NULL,
	[MacroName] [nvarchar](200) NULL,
	[ImageID] [uniqueidentifier] NULL,
	[Comments] [nvarchar](500) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
 CONSTRAINT [PK_pNBOLMacro] PRIMARY KEY CLUSTERED 
(
	[MacroID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLMacro] ADD  CONSTRAINT [DF_pNBOLMacro_MacroID]  DEFAULT (newid()) FOR [MacroID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03513', GetDate())
GO