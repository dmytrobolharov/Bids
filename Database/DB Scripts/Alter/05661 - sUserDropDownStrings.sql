IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_2_SystemDropDownListsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sUserDropDownStrings] DROP CONSTRAINT [DF_Table_2_SystemDropDownListsID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sUserDropDownStrings_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sUserDropDownStrings] DROP CONSTRAINT [DF_sUserDropDownStrings_CDate]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sUserDropDownStrings]') AND type in (N'U'))
DROP TABLE [dbo].[sUserDropDownStrings]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sUserDropDownStrings](
	[UserDropDownStringID] [uniqueidentifier] NOT NULL,
	[DesignString] [nvarchar](4000) NULL,
	[da_DK] [nvarchar](4000) NULL,
	[de_DE] [nvarchar](4000) NULL,
	[en_US] [nvarchar](4000) NULL,
	[en_GB] [nvarchar](4000) NULL,
	[en_CA] [nvarchar](4000) NULL,
	[fr_FR] [nvarchar](4000) NULL,
	[fr_CA] [nvarchar](4000) NULL,
	[es_ES] [nvarchar](4000) NULL,
	[es_MX] [nvarchar](4000) NULL,
	[hi_IN] [nvarchar](4000) NULL,
	[it_IT] [nvarchar](4000) NULL,
	[ja_JA] [nvarchar](4000) NULL,
	[ko_KR] [nvarchar](4000) NULL,
	[nl_NL] [nvarchar](4000) NULL,
	[pl_PL] [nvarchar](4000) NULL,
	[pt_PT] [nvarchar](4000) NULL,
	[pt_BR] [nvarchar](4000) NULL,
	[ru_RU] [nvarchar](4000) NULL,
	[sv_FI] [nvarchar](4000) NULL,
	[sv_SE] [nvarchar](4000) NULL,
	[tr_TR] [nvarchar](4000) NULL,
	[zh_CHS] [nvarchar](4000) NULL,
	[zh_CHT] [nvarchar](4000) NULL,
	[el_GR] [nvarchar](4000) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sUserDropDownStrings] PRIMARY KEY CLUSTERED 
(
	[UserDropDownStringID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sUserDropDownStrings] ADD  CONSTRAINT [DF_Table_2_SystemDropDownListsID]  DEFAULT (newsequentialid()) FOR [UserDropDownStringID]
GO

ALTER TABLE [dbo].[sUserDropDownStrings] ADD  CONSTRAINT [DF_sUserDropDownStrings_CDate]  DEFAULT (getdate()) FOR [CDate]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05661', GetDate())
GO

