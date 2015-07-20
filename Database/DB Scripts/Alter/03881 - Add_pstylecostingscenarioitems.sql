
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCostingScenarioItems_StytleCostingScenarioID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCostingScenarioItems] DROP CONSTRAINT [DF_pStyleCostingScenarioItems_StytleCostingScenarioID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCostingScenarioItems_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCostingScenarioItems] DROP CONSTRAINT [DF_pStyleCostingScenarioItems_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCostingScenarioItems_StyleColorwayID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCostingScenarioItems] DROP CONSTRAINT [DF_pStyleCostingScenarioItems_StyleColorwayID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingScenarioItems]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCostingScenarioItems]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[pStyleCostingScenarioItems](
	[StytleCostingScenarioItemsID] [uniqueidentifier] NOT NULL,
	[StyleCostingID] [uniqueidentifier]  NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleCostingTypeID] [int] NULL,
	[StyleCostingScenarioNo] [int] NULL,
	[StyleCostingFreightTypeID] [int] NULL,
	[StyleQuotaDutyID] [uniqueidentifier] NULL,
	[StyleCostingDate] [datetime] NULL,
	[StyleCostingStatus] [nvarchar](200) NULL,
	[StyleCostingCustomField1] [decimal](18, 3) NULL,
	[StyleCostingCustomField2] [decimal](18, 3) NULL,
	[StyleCostingCustomField3] [int] NULL,
	[StyleCostingCustomField4] [int] NULL,
	[StyleCostingCustomField5] [nvarchar](200) NULL,
	[StyleCostingCustomField6] [decimal](18, 3) NULL,
	[StyleCostingCustomField7] [decimal](18, 5) NULL,
	[StyleCostingCustomField8] [decimal](18, 3) NULL,
	[StyleCostingCustomField9] [decimal](18, 5) NULL,
	[StyleCostingCustomField10] [decimal](18, 3) NULL,
	[StyleCostingCustomField11] [decimal](18, 5) NULL,
	[StyleCostingCustomField12] [decimal](18, 3) NULL,
	[StyleCostingCustomField13] [decimal](18, 3) NULL,
	[StyleCostingCustomField14] [decimal](18, 3) NULL,
	[StyleCostingCustomField15] [decimal](18, 5) NULL,
	[StyleCostingCustomField16] [decimal](18, 3) NULL,
	[StyleCostingCustomField17] [decimal](18, 5) NULL,
	[StyleCostingCustomField18] [decimal](18, 5) NULL,
	[StyleCostingCustomField19] [int] NULL,
	[StyleCostingCustomField20] [decimal](18, 3) NULL,
	[StyleCostingCustomField21] [decimal](18, 3) NULL,
	[StyleCostingCustomField22] [decimal](18, 3) NULL,
	[StyleCostingCustomField23] [decimal](18, 5) NULL,
	[StyleCostingCustomField24] [decimal](18, 3) NULL,
	[StyleCostingCustomField25] [nvarchar](50) NULL,
	[StyleCostingCustomField26] [nvarchar](50) NULL,
	[StyleCostingCustomField27] [nvarchar](50) NULL,
	[StyleCostingCustomField28] [nvarchar](50) NULL,
	[StyleCostingCustomField29] [nvarchar](50) NULL,
	[StyleCostingCustomField30] [nvarchar](50) NULL,
	[StyleCostingCustomField31] [nvarchar](50) NULL,
	[StyleCostingCustomField32] [nvarchar](50) NULL,
	[StyleCostingCustomField33] [nvarchar](50) NULL,
	[StyleCostingCustomField34] [nvarchar](50) NULL,
	[StyleCostingCustomField35] [nvarchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [bit] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL,
	[StyleColorwayID] [uniqueidentifier] NULL,
	[BOMCost] [decimal](18, 3) NULL,
	[BOLCost] [decimal](18, 3) NULL,
	[BOLCurr] [nvarchar](5) NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
	[StyleNBOLHeaderId] [uniqueidentifier] NULL,
	[StyleSourcingID] [uniqueidentifier] NULL,
	[StyleCostingHeaderId] [uniqueidentifier] NULL,
	[StyleCostingName] [nvarchar](100) NULL,
	[StyleCostingCurrency] [nvarchar](20) NULL,
	[StyleCostingConvertedCurr] [decimal](18, 3) NULL,
	[StyleCostingHTS] [nvarchar](50) NULL,
	[AdditionalCost] [decimal](18, 3) NULL,
	[StyleCostingComments] [nvarchar](500) NULL,		
	[StyleCostingCustomField36] [decimal](18, 3) NULL,
	[StyleCostingCustomField37] [decimal](18, 3) NULL,
	[StyleCostingCustomField38] [decimal](18, 3) NULL,
	[StyleCostingCustomField39] [decimal](18, 3) NULL,
	[StyleCostingCustomField40] [decimal](18, 3) NULL,
	[StyleCostingCustomField41] [decimal](18, 3) NULL,
	[StyleCostingCustomField42] [decimal](18, 3) NULL,
	[StyleCostingCustomField43] [decimal](18, 3) NULL,
	[StyleCostingCustomField44] [decimal](18, 5) NULL,
	[StyleCostingCustomField45] [decimal](18, 3) NULL,
 CONSTRAINT [PK_Temp_pStyleCostingScenarioItems] PRIMARY KEY CLUSTERED 
(
	[StytleCostingScenarioItemsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleCostingScenarioItems] ADD  CONSTRAINT [DF_pStyleCostingScenarioItems_StytleCostingScenarioID]  DEFAULT (newsequentialid()) FOR [StytleCostingScenarioItemsID]

Go
ALTER TABLE [dbo].[pStyleCostingScenarioItems] ADD  CONSTRAINT [DF_pStyleCostingScenarioItems_Active]  DEFAULT ((0)) FOR [Active]

Go
ALTER TABLE [dbo].[pStyleCostingScenarioItems] ADD  CONSTRAINT [DF_pStyleCostingScenarioItems_StyleColorwayID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [StyleColorwayID]

Go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03881', GetDate())
GO


