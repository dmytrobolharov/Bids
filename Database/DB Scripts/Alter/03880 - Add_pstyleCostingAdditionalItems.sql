IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pstyleCostingAdditionalItems]') AND type in (N'U'))
DROP TABLE [dbo].[pstyleCostingAdditionalItems]
GO

/****** Object:  Table [dbo].[pstyleCostingAdditionalItems]    Script Date: 09/12/2012 16:32:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pstyleCostingAdditionalItems](
      [styleCostingAdditionalItemsID] [uniqueidentifier] NOT NULL,
      [StytleCostingScenarioItemsID] [uniqueidentifier] NULL,
      [StyleID] [uniqueidentifier] NULL,      
      [AdditionalItemNo] [nvarchar](200) NULL,
      [AdditionalItemName] [nvarchar](200) NULL,     
      [AdditionalItemCost] decimal(18,3) NULL,
      [CDate] [datetime] NULL,
      [CUser] [nvarchar](200) NULL,
      [MDate] [datetime] NULL,
      [MUser] [nvarchar](200) NULL,
CONSTRAINT [PK_pstyleCostingAdditionalItems] PRIMARY KEY CLUSTERED 
(
      [styleCostingAdditionalItemsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pstyleCostingAdditionalItems] ADD  CONSTRAINT [DF_pstyleCostingAdditionalItems_styleCostingAdditionalItemsID]  DEFAULT (newsequentialid()) FOR [styleCostingAdditionalItemsID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03880', GetDate())
GO

