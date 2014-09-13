IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMDimensionComboItems_StyleBOMDimensionComboItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMDimensionComboItems] DROP CONSTRAINT [DF_pStyleBOMDimensionComboItems_StyleBOMDimensionComboItemID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionComboItems]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleBOMDimensionComboItems]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMDimensionComboItems](
	[StyleBOMDimensionComboItemID] [uniqueidentifier] NOT NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pStyleBOMDimensionComboItems] PRIMARY KEY CLUSTERED 
(
	[StyleBOMDimensionComboItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMDimensionComboItems] ADD  CONSTRAINT [DF_pStyleBOMDimensionComboItems_StyleBOMDimensionComboItemID]  DEFAULT (newid()) FOR [StyleBOMDimensionComboItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06460', GetDate())
GO
