IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pSourcing__Sourc__47B589C6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItemChange] DROP CONSTRAINT [DF__pSourcing__Sourc__47B589C6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pSourcing__Sourc__48A9ADFF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItemChange] DROP CONSTRAINT [DF__pSourcing__Sourc__48A9ADFF]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pSourcing__Activ__499DD238]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItemChange] DROP CONSTRAINT [DF__pSourcing__Activ__499DD238]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pSourcing__Activ__4A91F671]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItemChange] DROP CONSTRAINT [DF__pSourcing__Activ__4A91F671]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pSourcing__RepRo__4B861AAA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItemChange] DROP CONSTRAINT [DF__pSourcing__RepRo__4B861AAA]
END

GO

/****** Object:  Table [dbo].[pSourcingCommitmentItemChange]    Script Date: 08/09/2014 13:59:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentItemChange]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentItemChange]
GO

/****** Object:  Table [dbo].[pSourcingCommitmentItemChange]    Script Date: 08/09/2014 13:59:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentItemChange](
	[SourcingCommitmentItemChangeID] [uniqueidentifier] NOT NULL,
	[SourcingCommitmentItemChangeNo] [int] IDENTITY(1,1) NOT NULL,
	[SourcingCommitmentItemStatus] [bit] NULL,
	[SourcingCommitmentItemID] [uniqueidentifier] NULL,
	[SourcingCommitmentItemChangeNotifyTo] [nvarchar](4000) NULL,
	[SourcingCommitmentItemChangeType] [nvarchar](100) NULL,
	[SourcingCommitmentItemChangeDescription] [nvarchar](4000) NULL,
	[SourcingCommitmentItemChangeBy] [nvarchar](100) NULL,
	[SourcingCommitmentItemChangeDate] [datetime] NULL,
	[ActiveID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[RepRowGuidColID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pSourcingCommitmentItemChange] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentItemChangeID] ASC,
	[SourcingCommitmentItemChangeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCommitmentItemChange] ADD  DEFAULT (newid()) FOR [SourcingCommitmentItemChangeID]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItemChange] ADD  DEFAULT ((0)) FOR [SourcingCommitmentItemStatus]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItemChange] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ActiveID]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItemChange] ADD  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItemChange] ADD  DEFAULT (newid()) FOR [RepRowGuidColID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08690', GetDate())
GO
