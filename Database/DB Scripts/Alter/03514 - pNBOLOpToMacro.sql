IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_OpToMacroId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLOpToMacro] DROP CONSTRAINT [DF_Table_1_OpToMacroId]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLOpToMacro]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLOpToMacro]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLOpToMacro](
	[OpToMacroID] [uniqueidentifier] NOT NULL,
	[MacroID] [uniqueidentifier] NULL,
	[OperationID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pNBOLOpToMacro] PRIMARY KEY CLUSTERED 
(
	[OpToMacroID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLOpToMacro] ADD  CONSTRAINT [DF_Table_1_OpToMacroId]  DEFAULT (newid()) FOR [OpToMacroID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03514', GetDate())
GO