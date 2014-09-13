
/****** Object:  Table [dbo].[pStyleCostingBOL]    Script Date: 09/12/2012 16:48:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingBOL]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCostingBOL]
GO


/****** Object:  Table [dbo].[pStyleCostingBOL]    Script Date: 09/12/2012 16:48:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleCostingBOL](
      [styleCostingBOLID] [uniqueidentifier] NOT NULL,
      [StytleCostingScenarioItemsID] [uniqueidentifier] NULL,
      [StyleID] [uniqueidentifier] NULL,
      [StyleNBOLHeaderID] [uniqueidentifier] NULL,
      [StyleNBOLItemId] [uniqueidentifier] NULL,
      [OperationCode] [nvarchar](200) NULL,
      [OperationName] [nvarchar](200) NULL,
      [OperationTypeID] [uniqueidentifier] NULL,
      [OperationCost] decimal(18,3) NULL,
      [CDate] [datetime] NULL,
      [CUser] [nvarchar](200) NULL,
      [MDate] [datetime] NULL,
      [MUser] [nvarchar](200) NULL,
CONSTRAINT [PK_pstyleCostingBOL] PRIMARY KEY CLUSTERED 
(
      [styleCostingBOLID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
)ON [PRIMARY]

GO


ALTER TABLE [dbo].[pStyleCostingBOL] ADD  CONSTRAINT [DF_pStyleCostingBOL_styleCostingBOLID]  DEFAULT (newsequentialid()) FOR [styleCostingBOLID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03879', GetDate())
GO

