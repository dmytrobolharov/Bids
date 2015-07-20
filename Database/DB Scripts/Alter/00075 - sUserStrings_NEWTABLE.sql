
/****** Object:  Table [dbo].[sUserStrings]    Script Date: 04/21/2010 11:59:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sUserStrings]') AND type in (N'U'))
DROP TABLE [dbo].[sUserStrings]
GO
CREATE TABLE [dbo].[sUserStrings](
	[UserStringID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sUserStrings_UserStringID]  DEFAULT (newsequentialid()),
	[DesignString] [nvarchar](4000) NULL,
	[da-DK] [nvarchar](4000) NULL,
	[de-DE] [nvarchar](4000) NULL,
	[en-US] [nvarchar](4000) NULL,
	[en-GB] [nvarchar](4000) NULL,
	[en-CA] [nvarchar](4000) NULL,
	[fr-FR] [nvarchar](4000) NULL,
	[fr-CA] [nvarchar](4000) NULL,
	[es-ES] [nvarchar](4000) NULL,
	[es-MX] [nvarchar](4000) NULL,
	[hi-IN] [nvarchar](4000) NULL,
	[it-IT] [nvarchar](4000) NULL,
	[ja-JA] [nvarchar](4000) NULL,
	[ko-KR] [nvarchar](4000) NULL,
	[nl-NL] [nvarchar](4000) NULL,
	[pl-PL] [nvarchar](4000) NULL,
	[pt-PT] [nvarchar](4000) NULL,
	[pt-BR] [nvarchar](4000) NULL,
	[ru-RU] [nvarchar](4000) NULL,
	[sv-FI] [nvarchar](4000) NULL,
	[sv-SE] [nvarchar](4000) NULL,
	[tr-TR] [nvarchar](4000) NULL,
	[zh-CHS] [nvarchar](4000) NULL,
	[zh-CHT] [nvarchar](4000) NULL,
	[CDate] [datetime] NULL CONSTRAINT [DF_sUserStrings_CDate]  DEFAULT (getdate()),
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sUserStrings] PRIMARY KEY CLUSTERED 
(
	[UserStringID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

DELETE FROM sUserXMLStrings

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '075', GetDate())
GO