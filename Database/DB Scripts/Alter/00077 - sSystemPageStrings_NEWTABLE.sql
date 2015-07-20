
/****** Object:  Table [dbo].[sSystemPageStrings]    Script Date: 04/21/2010 15:44:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemPageStrings]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemPageStrings]
GO
CREATE TABLE [dbo].[sSystemPageStrings](
	[sSystemPageString] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sSystemPageStrings_sSystemPageString]  DEFAULT (newid()),
	[FormName] [nvarchar](4000) NULL,
	[SystemStringID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL CONSTRAINT [DF_sSystemPageStrings_CDate]  DEFAULT (getdate()),
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sSystemPageStrings] PRIMARY KEY CLUSTERED 
(
	[sSystemPageString] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '077', GetDate())
GO
