IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOMOption_SourcingCommitmentBOMOptionID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOMOption] DROP CONSTRAINT [DF_pSourcingCommitmentBOMOption_SourcingCommitmentBOMOptionID]
END

GO

/****** Object:  Table [dbo].[pSourcingCommitmentBOMOption]    Script Date: 11/23/2012 14:59:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOMOption]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentBOMOption]
GO

/****** Object:  Table [dbo].[pSourcingCommitmentBOMOption]    Script Date: 11/23/2012 14:59:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentBOMOption](
	[SourcingCommitmentBOMOptionID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SourcingCommitmentItemID] [uniqueidentifier] NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderId] [uniqueidentifier] NULL,
	[SourcingStyleID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[styleset] [int] NULL,
	[OptionNo] [int] NULL,
	[OptionStatus] [int] NULL,
	[OptionSystem] [int] NULL,
	[WorkFlowID] [uniqueidentifier] NULL,
	[WorkFlowItemID] [uniqueidentifier] NULL,
	[StyleBOMDimensionId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
	[OptionName] [nvarchar](100) NULL,
 CONSTRAINT [PK_pSourcingCommitmentBOMOption] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentBOMOptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCommitmentBOMOption] ADD  CONSTRAINT [DF_pSourcingCommitmentBOMOption_SourcingCommitmentBOMOptionID]  DEFAULT (newid()) FOR [SourcingCommitmentBOMOptionID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04446', GetDate())
GO