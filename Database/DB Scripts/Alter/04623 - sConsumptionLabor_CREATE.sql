IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sConsumptionLabor_ConsumptionLaborTablesID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sConsumptionLabor] DROP CONSTRAINT [DF_sConsumptionLabor_ConsumptionLaborTablesID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sConsumptionLabor]') AND type in (N'U'))
DROP TABLE [dbo].[sConsumptionLabor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sConsumptionLabor](
	[ConsumptionLaborTablesID] [uniqueidentifier] NOT NULL,
	[SizeClass] [nvarchar](200) NULL,
	[StyleCategoryID] [uniqueidentifier] NULL,
	[ConsumptionRatios] [numeric](18, 4) NULL,
	[LaborCosts] [numeric](18, 4) NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL
 CONSTRAINT [PK_sConsumptionLabor] PRIMARY KEY CLUSTERED 
(
	[ConsumptionLaborTablesID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sConsumptionLabor] ADD  CONSTRAINT [DF_sConsumptionLabor_ConsumptionLaborTablesID]  DEFAULT (newid()) FOR [ConsumptionLaborTablesID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04623', GetDate())
GO
