/****** Object:  Table [dbo].[pstyleCostingBOM]    Script Date: 09/12/2012 16:32:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pstyleCostingBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pstyleCostingBOM]
GO

/****** Object:  Table [dbo].[pstyleCostingBOM]    Script Date: 09/12/2012 16:32:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pstyleCostingBOM](
      [styleCostingBOMID] [uniqueidentifier] NOT NULL,
      [StytleCostingScenarioItemsID] [uniqueidentifier] NULL,
      [StyleID] [uniqueidentifier] NULL,
      [StyleBOMDimensionID] [uniqueidentifier] NULL,
      [StyleMaterialId] [uniqueidentifier] NULL,
      [MaterialName] [nvarchar](200) NULL,
      [MaterialNo] [nvarchar](200) NULL,
      [MaterialType] [int] NULL,
      [MaterialTypeDesc] [nvarchar](200) NULL,
      [MaterialCost] decimal(18,3) NULL,
      [CDate] [datetime] NULL,
      [CUser] [nvarchar](200) NULL,
      [MDate] [datetime] NULL,
      [MUser] [nvarchar](200) NULL,
CONSTRAINT [PK_pstyleCostingBOM] PRIMARY KEY CLUSTERED 
(
      [styleCostingBOMID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pstyleCostingBOM] ADD  CONSTRAINT [DF_pstyleCostingBOM_styleCostingBOMID]  DEFAULT (newsequentialid()) FOR [styleCostingBOMID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03878', GetDate())
GO
