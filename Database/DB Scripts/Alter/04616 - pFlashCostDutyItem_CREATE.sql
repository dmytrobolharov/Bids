IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashCostDuty_FlashCostDutyID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashCostDutyItem] DROP CONSTRAINT [DF_pFlashCostDuty_FlashCostDutyID]
END

GO

/****** Object:  Table [dbo].[pFlashCostDutyItem]    Script Date: 12/13/2012 17:30:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pFlashCostDutyItem]') AND type in (N'U'))
DROP TABLE [dbo].[pFlashCostDutyItem]
GO

/****** Object:  Table [dbo].[pFlashCostDutyItem]    Script Date: 12/13/2012 17:30:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pFlashCostDutyItem](
	[FlashCostDutyItemID] [uniqueidentifier] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
	[SizeClassID] [uniqueidentifier] NOT NULL,
	[CostDutyPercent] [numeric](18, 6) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[FlashCostDutyID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pFlashCostDuty] PRIMARY KEY CLUSTERED 
(
	[FlashCostDutyItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pFlashCostDutyItem] ADD  CONSTRAINT [DF_pFlashCostDuty_FlashCostDutyID]  DEFAULT (newid()) FOR [FlashCostDutyItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04616', GetDate())
GO
