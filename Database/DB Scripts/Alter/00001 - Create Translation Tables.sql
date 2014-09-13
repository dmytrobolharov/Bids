

/****** Object:  Table [dbo].[sSystemPageStrings]    Script Date: 01/20/2010 11:23:41 ******/

CREATE TABLE sSystemPageStrings(
	[FormName] [nvarchar](4000) NULL,
	[SystemStringID] [uniqueidentifier] NULL,
	[WhenModified] [datetime] NULL,
	[WhoModified] [nvarchar](100) NULL
) ON [PRIMARY]

GO


CREATE TABLE sSystemStrings(
	[SystemStringID] [uniqueidentifier] NULL,
	[DesignString] [nvarchar](4000) NULL,
	[DA] [nvarchar](4000) NULL,
	[DE] [nvarchar](4000) NULL,
	[EN-US] [nvarchar](4000) NULL,
	[EN-UK] [nvarchar](4000) NULL,
	[FR] [nvarchar](4000) NULL,
	[ES] [nvarchar](4000) NULL,
	[ES-MX] [nvarchar](4000) NULL,
	[IT] [nvarchar](4000) NULL,
	[JA] [nvarchar](4000) NULL,
	[KO] [nvarchar](4000) NULL,
	[NL] [nvarchar](4000) NULL,
	[PL] [nvarchar](4000) NULL,
	[PT] [nvarchar](4000) NULL,
	[RU] [nvarchar](4000) NULL,
	[TR] [nvarchar](4000) NULL,
	[ZH-CN] [nvarchar](4000) NULL,
	[ZH-HK] [nvarchar](4000) NULL,
	[ZH-TW] [nvarchar](4000) NULL,
	[WhenModified] [datetime] NULL,
	[WhoModified] [nvarchar](100) NULL
) ON [PRIMARY]

GO

ALTER TABLE sSystemStrings ADD  DEFAULT (newsequentialid()) FOR [SystemStringID]
GO


CREATE TABLE sUserStrings(
	[UserStringID] [uniqueidentifier] NULL,
	[DesignString] [nvarchar](4000) NULL,
	[DA] [nvarchar](4000) NULL,
	[DE] [nvarchar](4000) NULL,
	[EN-US] [nvarchar](4000) NULL,
	[EN-UK] [nvarchar](4000) NULL,
	[FR] [nvarchar](4000) NULL,
	[ES] [nvarchar](4000) NULL,
	[ES-MX] [nvarchar](4000) NULL,
	[IT] [nvarchar](4000) NULL,
	[JA] [nvarchar](4000) NULL,
	[KO] [nvarchar](4000) NULL,
	[NL] [nvarchar](4000) NULL,
	[PL] [nvarchar](4000) NULL,
	[PT] [nvarchar](4000) NULL,
	[RU] [nvarchar](4000) NULL,
	[TR] [nvarchar](4000) NULL,
	[ZH-CN] [nvarchar](4000) NULL,
	[ZH-HK] [nvarchar](4000) NULL,
	[ZH-TW] [nvarchar](4000) NULL,
	[WhenModified] [datetime] NULL,
	[WhoModified] [nvarchar](100) NULL
) ON [PRIMARY]

GO

ALTER TABLE sUserStrings ADD  DEFAULT (newsequentialid()) FOR [UserStringID]
GO

CREATE TABLE sUserXMLStrings(
	[XMLName] [nvarchar](4000) NULL,
	[UserStringID] [uniqueidentifier] NULL,
	[WhenModified] [datetime] NULL,
	[WhoModified] [nvarchar](100) NULL
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '001', GetDate())

GO