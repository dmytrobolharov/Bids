IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pChangeTransaction')
   DROP TABLE pChangeTransaction
GO


CREATE TABLE [dbo].[pChangeTransaction]
(
[ChangeTransID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newid()),
[ChangeTransPageName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChangeTransTableID] [uniqueidentifier] NULL,
[ChangeTransTablePKID] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChangeTransUserID] [uniqueidentifier] NULL,
[ChangeTransDate] [datetime] NULL,
[ChangeTransTypeID] [int] NOT NULL DEFAULT ((0)),
CONSTRAINT [PK_pChangeTransaction] PRIMARY KEY CLUSTERED 
(
	[ChangeTransID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '680', GetDate())
GO
