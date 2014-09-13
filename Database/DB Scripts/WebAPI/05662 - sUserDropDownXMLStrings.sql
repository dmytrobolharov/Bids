IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_UserXMLStringID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sUserDropDownXMLStrings] DROP CONSTRAINT [DF_Table_1_UserXMLStringID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sUserDropDownXMLStrings_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sUserDropDownXMLStrings] DROP CONSTRAINT [DF_sUserDropDownXMLStrings_CDate]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sUserDropDownXMLStrings]') AND type in (N'U'))
DROP TABLE [dbo].[sUserDropDownXMLStrings]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sUserDropDownXMLStrings](
	[UserDropDownXMLStringID] [uniqueidentifier] NOT NULL,
	[XMLName] [nvarchar](4000) NULL,
	[UserDropDownStringID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sUserDropDownXMLStrings] PRIMARY KEY CLUSTERED 
(
	[UserDropDownXMLStringID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sUserDropDownXMLStrings] ADD  CONSTRAINT [DF_Table_1_UserXMLStringID]  DEFAULT (newsequentialid()) FOR [UserDropDownXMLStringID]
GO

ALTER TABLE [dbo].[sUserDropDownXMLStrings] ADD  CONSTRAINT [DF_sUserDropDownXMLStrings_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05662', GetDate())
GO

