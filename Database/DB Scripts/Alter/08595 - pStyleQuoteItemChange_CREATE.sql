IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pStyleQuo__Style__180676A4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleQuoteItemChange] DROP CONSTRAINT [DF__pStyleQuo__Style__180676A4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pStyleQuo__Style__18FA9ADD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleQuoteItemChange] DROP CONSTRAINT [DF__pStyleQuo__Style__18FA9ADD]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pStyleQuo__Activ__19EEBF16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleQuoteItemChange] DROP CONSTRAINT [DF__pStyleQuo__Activ__19EEBF16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pStyleQuo__Activ__1AE2E34F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleQuoteItemChange] DROP CONSTRAINT [DF__pStyleQuo__Activ__1AE2E34F]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pStyleQuo__RepRo__1BD70788]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleQuoteItemChange] DROP CONSTRAINT [DF__pStyleQuo__RepRo__1BD70788]
END

GO

/****** Object:  Table [dbo].[pStyleQuoteItemChange]    Script Date: 08/06/2014 19:13:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemChange]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleQuoteItemChange]
GO

/****** Object:  Table [dbo].[pStyleQuoteItemChange]    Script Date: 08/06/2014 19:13:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleQuoteItemChange](
	[StyleQuoteItemChangeID] [uniqueidentifier] NOT NULL,
	[StyleQuoteItemChangeNo] [int] IDENTITY(1,1) NOT NULL,
	[StyleQuoteItemStatus] [bit] NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[StyleQuoteItemChangeNotifyTo] [nvarchar](4000) NULL,
	[StyleQuoteItemChangeType] [nvarchar](100) NULL,
	[StyleQuoteItemChangeDescription] [nvarchar](4000) NULL,
	[StyleQuoteItemChangeBy] [nvarchar](100) NULL,
	[StyleQuoteItemChangeDate] [datetime] NULL,
	[ActiveID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[RepRowGuidColID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pStyleQuoteItemChange] PRIMARY KEY CLUSTERED 
(
	[StyleQuoteItemChangeID] ASC,
	[StyleQuoteItemChangeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleQuoteItemChange] ADD  DEFAULT (newid()) FOR [StyleQuoteItemChangeID]
GO

ALTER TABLE [dbo].[pStyleQuoteItemChange] ADD  DEFAULT ((0)) FOR [StyleQuoteItemStatus]
GO

ALTER TABLE [dbo].[pStyleQuoteItemChange] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ActiveID]
GO

ALTER TABLE [dbo].[pStyleQuoteItemChange] ADD  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pStyleQuoteItemChange] ADD  DEFAULT (newid()) FOR [RepRowGuidColID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08595', GetDate())
GO
