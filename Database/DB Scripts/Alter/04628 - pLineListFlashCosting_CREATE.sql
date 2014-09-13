IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineListFlashCosting_Variance]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineListFlashCosting] DROP CONSTRAINT [DF_pLineListFlashCosting_Variance]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineListFlashCosting]') AND type in (N'U'))
DROP TABLE [dbo].[pLineListFlashCosting]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLineListFlashCosting](
	[LineFolderItemID] [uniqueidentifier] NOT NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[DutyCategory] [uniqueidentifier] NULL,
	[MaterialCost] [numeric](18, 4) NULL,
	[LaborCost] [numeric](18, 4) NULL,
	[AddedCost] [numeric](18, 4) NULL,
	[FlashCostFOB] [numeric](18, 4) NULL,
	[DutyP] [numeric](18, 6) NULL,
	[Duty] [numeric](18, 4) NULL,
	[Variance] [numeric](18, 6) NULL,
	[FlashCostLDP] [numeric](18, 4) NULL,
	[WholesaleMU] [numeric](18, 6) NULL,
	[RetailMU] [numeric](18, 6) NULL,
	[WholesalePrice] [numeric](18, 4) NULL,
	[RetailPrice] [numeric](18, 4) NULL,
 CONSTRAINT [PK_pLineListFlashCosting] PRIMARY KEY CLUSTERED 
(
	[LineFolderItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLineListFlashCosting] ADD  CONSTRAINT [DF_pLineListFlashCosting_Variance]  DEFAULT ((0.25)) FOR [Variance]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04628', GetDate())
GO
