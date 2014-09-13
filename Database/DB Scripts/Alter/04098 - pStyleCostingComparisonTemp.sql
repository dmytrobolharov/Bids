IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingComparisonTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCostingComparisonTemp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleCostingComparisonTemp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StyleCostingComparisonID] [uniqueidentifier] NULL,
	[StyleCostingScenarioID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04098', GetDate())
GO
