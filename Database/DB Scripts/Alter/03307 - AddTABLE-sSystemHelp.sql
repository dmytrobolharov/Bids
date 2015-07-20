IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemHelp]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemHelp]
GO

/****** Object:  Table [dbo].[sSystemHelp]    Script Date: 04/10/2012 11:25:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sSystemHelp](
	[sSystemHelpID] [uniqueidentifier] NOT NULL,
	[DesignString] [nvarchar](200) NULL,
	[da_DK] [nvarchar](200) NULL,
	[de_DE] [nvarchar](200) NULL,
	[en_US] [nvarchar](200) NULL,
	[en_GB] [nvarchar](200) NULL,
	[en_CA] [nvarchar](200) NULL,
	[fr_FR] [nvarchar](200) NULL,
	[fr_CA] [nvarchar](200) NULL,
	[el_GR] [nvarchar](200) NULL,
	[es_ES] [nvarchar](200) NULL,
	[es_MX] [nvarchar](200) NULL,
	[hi_IN] [nvarchar](200) NULL,
	[it_IT] [nvarchar](200) NULL,
	[ja_JA] [nvarchar](200) NULL,
	[ko_KR] [nvarchar](200) NULL,
	[nl_NL] [nvarchar](200) NULL,
	[pl_PL] [nvarchar](200) NULL,
	[pt_PT] [nvarchar](200) NULL,
	[pt_BR] [nvarchar](200) NULL,
	[ru_RU] [nvarchar](200) NULL,
	[sv_FI] [nvarchar](200) NULL,
	[sv_SE] [nvarchar](200) NULL,
	[tr_TR] [nvarchar](200) NULL,
	[zh_CHS] [nvarchar](200) NULL,
	[zh_CHT] [nvarchar](200) NULL,
	[sSystemPageID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
 CONSTRAINT [PK_sSystemHelp] PRIMARY KEY CLUSTERED 
(
	[sSystemHelpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sSystemHelp] ADD  CONSTRAINT [DF_sSystemHelp_sSystemHelpID]  DEFAULT (newid()) FOR [sSystemHelpID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03307'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03307', GetDate())
END

GO