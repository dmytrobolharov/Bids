IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemHelpDetail]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemHelpDetail]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sSystemHelpDetail](
	[sSystemHelpDetailID] [uniqueidentifier] NOT NULL,
	[sSystemHelpID] [uniqueidentifier] NOT NULL,
	[CultureIndentifierID] [varchar](6) NOT NULL,
	[sSystemHelpDetail] [nvarchar](max) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[sSystemHelpDetail_Plain] [nvarchar](max) NULL,
 CONSTRAINT [PK_sSystemHelpDetail] PRIMARY KEY CLUSTERED 
(
	[sSystemHelpDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sSystemHelpDetail]  WITH CHECK ADD  CONSTRAINT [FK_sSystemHelpDetail_sSystemCulture] FOREIGN KEY([CultureIndentifierID])
REFERENCES [dbo].[sSystemCulture] ([CultureIndentifierID])
GO

ALTER TABLE [dbo].[sSystemHelpDetail] CHECK CONSTRAINT [FK_sSystemHelpDetail_sSystemCulture]
GO

ALTER TABLE [dbo].[sSystemHelpDetail] ADD  CONSTRAINT [DF_sSystemHelpDetail_sSystemHelpDetailID]  DEFAULT (newid()) FOR [sSystemHelpDetailID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03308'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03308', GetDate())
END

GO