
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentAdditionalCost_SourcingAdditionalCostID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentAdditionalCost] DROP CONSTRAINT [DF_pSourcingCommitmentAdditionalCost_SourcingAdditionalCostID]
END

GO


/****** Object:  Table [dbo].[pSourcingCommitmentAdditionalCost]    Script Date: 11/23/2012 15:19:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentAdditionalCost]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentAdditionalCost]
GO


/****** Object:  Table [dbo].[pSourcingCommitmentAdditionalCost]    Script Date: 11/23/2012 15:19:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentAdditionalCost](
	[CommitmentAdditionalCostID] [uniqueidentifier] NOT NULL,
	[SourcingAdditionalCostID] [uniqueidentifier] NULL,
	[CommitmentItemID] [uniqueidentifier] NULL,
	[QuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[SourcingStyleID] [uniqueidentifier] NULL,
	[Description] [nvarchar](200) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSourcingCommitmentAdditionalCost] PRIMARY KEY CLUSTERED 
(
	[CommitmentAdditionalCostID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCommitmentAdditionalCost] ADD  CONSTRAINT [DF_pSourcingCommitmentAdditionalCost_SourcingAdditionalCostID]  DEFAULT (newsequentialid()) FOR [CommitmentAdditionalCostID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04437', GetDate())
GO  

