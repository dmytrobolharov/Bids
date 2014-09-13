
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingAdditionalCost_SourcingAdditionalCostID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingAdditionalCost] DROP CONSTRAINT [DF_pSourcingAdditionalCost_SourcingAdditionalCostID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingAdditionalCost]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingAdditionalCost]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingAdditionalCost](
	[SourcingAdditionalCostID] [uniqueidentifier] NOT NULL,
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
 CONSTRAINT [PK_pSourcingAdditionalCost] PRIMARY KEY CLUSTERED 
(
	[SourcingAdditionalCostID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingAdditionalCost] ADD  CONSTRAINT [DF_pSourcingAdditionalCost_SourcingAdditionalCostID]  DEFAULT (newsequentialid()) FOR [SourcingAdditionalCostID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04193', GetDate())
GO



