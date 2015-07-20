
/****** Object:  Table [dbo].[sSystemButtons]    Script Date: 04/21/2010 10:55:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemButtons]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemButtons]
GO
CREATE TABLE [dbo].[sSystemButtons](
	[SystemButtonID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sSystemButtons_SystemButtonID]  DEFAULT (newsequentialid()),
	[ButtonIcon] [varchar](200) NULL,
	[ButtonType] [varchar](200) NULL,
	[DesignString] [nvarchar](20) NULL,
	[da-DK] [nvarchar](20) NULL,
	[de-DE] [nvarchar](20) NULL,
	[en-US] [nvarchar](20) NULL,
	[en-GB] [nvarchar](20) NULL,
	[en-CA] [nvarchar](20) NULL,
	[fr-FR] [nvarchar](20) NULL,
	[fr-CA] [nvarchar](20) NULL,
	[es-ES] [nvarchar](20) NULL,
	[es-MX] [nvarchar](20) NULL,
	[hi-IN] [nvarchar](20) NULL,
	[it-IT] [nvarchar](20) NULL,
	[ja-JA] [nvarchar](20) NULL,
	[ko-KR] [nvarchar](20) NULL,
	[nl-NL] [nvarchar](20) NULL,
	[pl-PL] [nvarchar](20) NULL,
	[pt-PT] [nvarchar](20) NULL,
	[pt-BR] [nvarchar](20) NULL,
	[ru-RU] [nvarchar](20) NULL,
	[sv-FI] [nvarchar](20) NULL,
	[sv-SE] [nvarchar](20) NULL,
	[tr-TR] [nvarchar](20) NULL,
	[zh-CHS] [nvarchar](20) NULL,
	[zh-CHT] [nvarchar](20) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sSystemButtons] PRIMARY KEY CLUSTERED 
(
	[SystemButtonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '073', GetDate())
GO