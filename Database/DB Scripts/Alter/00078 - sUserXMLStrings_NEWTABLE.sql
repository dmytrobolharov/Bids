
/****** Object:  Table [dbo].[sUserXMLStrings]    Script Date: 04/21/2010 15:45:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sUserXMLStrings]') AND type in (N'U'))
DROP TABLE [dbo].[sUserXMLStrings]
GO

CREATE TABLE [dbo].[sUserXMLStrings](
	[UserXMLStringID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sUserXMLStrings_UserXMLStringID]  DEFAULT (newsequentialid()),
	[XMLName] [nvarchar](4000) NULL,
	[UserStringID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL CONSTRAINT [DF_sUserXMLStrings_CDate]  DEFAULT (getdate()),
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sUserXMLStrings] PRIMARY KEY CLUSTERED 
(
	[UserXMLStringID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '078', GetDate())
GO
