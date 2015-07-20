-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 29 November 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pLinePlanBusinessRollUp') 
    DROP TABLE pLinePlanBusinessRollUp
GO

CREATE TABLE pLinePlanBusinessRollUp
(
	[LinePlanBusinessRollUpID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanID] [uniqueidentifier] NULL,
	[LinePlanFinancialID] [uniqueidentifier] NULL,
	[LinePlanFinancialText] [nvarchar](100) NULL,
	[LinePlanFinancialSort] [varchar](5) NULL,
	[RangePlan] [int] NULL,
	[LinePlanAttributeItemID1] [uniqueidentifier] NULL,
	[LinePlanAttributeItemID2] [uniqueidentifier] NULL,
	[LinePlanAttributeItemID3] [uniqueidentifier] NULL,
	[LinePlanAttributeItemID4] [uniqueidentifier] NULL,
	[LinePlanAttributeText1] [nvarchar](100) NULL,
	[LinePlanAttributeText2] [nvarchar](100) NULL,
	[LinePlanAttributeText3] [nvarchar](100) NULL,
	[LinePlanAttributeText4] [nvarchar](100) NULL,
	[LinePlanAttributeItemSort1] [varchar](5) NULL,
	[LinePlanAttributeItemSort2] [varchar](5) NULL,
	[LinePlanAttributeItemSort3] [varchar](5) NULL,
	[LinePlanAttributeItemSort4] [varchar](5) NULL,
	[LinePlanBusLYCh1] [decimal](18, 5) NULL,
	[LinePlanBusLYCh2] [decimal](18, 5) NULL,
	[LinePlanBusLYCh3] [decimal](18, 5) NULL,
	[LinePlanBusLYCh4] [decimal](18, 5) NULL,
	[LinePlanBusLYCh5] [decimal](18, 5) NULL,
	[LinePlanBusPnCh1] [decimal](18, 5) NULL,
	[LinePlanBusPnCh2] [decimal](18, 5) NULL,
	[LinePlanBusPnCh3] [decimal](18, 5) NULL,
	[LinePlanBusPnCh4] [decimal](18, 5) NULL,
	[LinePlanBusPnCh5] [decimal](18, 5) NULL,
	[LinePlanBusCuCh1] [decimal](18, 5) NULL,
	[LinePlanBusCuCh2] [decimal](18, 5) NULL,
	[LinePlanBusCuCh3] [decimal](18, 5) NULL,
	[LinePlanBusCuCh4] [decimal](18, 5) NULL,
	[LinePlanBusCuCh5] [decimal](18, 5) NULL,
	[LinePlanBusWpCh1] [decimal](18, 5) NULL,
	[LinePlanBusWpCh2] [decimal](18, 5) NULL,
	[LinePlanBusWpCh3] [decimal](18, 5) NULL,
	[LinePlanBusWpCh4] [decimal](18, 5) NULL,
	[LinePlanBusWpCh5] [decimal](18, 5) NULL,
	[LinePlanBusTrCh1] [decimal](18, 5) NULL,
	[LinePlanBusTrCh2] [decimal](18, 5) NULL,
	[LinePlanBusTrCh3] [decimal](18, 5) NULL,
	[LinePlanBusTrCh4] [decimal](18, 5) NULL,
	[LinePlanBusTrCh5] [decimal](18, 5) NULL,
	[LinePlanBus1] [nvarchar](50) NULL,
	[LinePlanBus2] [nvarchar](50) NULL,
	[LinePlanBus3] [nvarchar](50) NULL,
	[LinePlanBus4] [nvarchar](50) NULL,
	[LinePlanBus5] [nvarchar](50) NULL,
	[LinePlanBus6] [nvarchar](50) NULL,
	[LinePlanBus7] [nvarchar](50) NULL,
	[LinePlanBus8] [nvarchar](50) NULL,
	[LinePlanBus9] [nvarchar](50) NULL,
	[LinePlanBus10] [nvarchar](50) NULL,
	[LinePlanBus11] [nvarchar](50) NULL,
	[LinePlanBus12] [nvarchar](50) NULL,
	[LinePlanBus13] [nvarchar](50) NULL,
	[LinePlanBus14] [nvarchar](50) NULL,
	[LinePlanBus15] [nvarchar](50) NULL,
	[LinePlanBus16] [nvarchar](50) NULL,
	[LinePlanBus17] [nvarchar](50) NULL,
	[LinePlanBus18] [nvarchar](50) NULL,
	[LinePlanBus19] [nvarchar](50) NULL,
	[LinePlanBus20] [nvarchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pLinePlanBusinessRollUp] PRIMARY KEY CLUSTERED 
(
	[LinePlanBusinessRollUpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

-----------------
-- Constraints --
-----------------
ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusinessRollUpID]  DEFAULT (newid()) FOR [LinePlanBusinessRollUpID]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanFinancialID]  DEFAULT (newid()) FOR [LinePlanFinancialID]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_RangePlan]  DEFAULT ((0)) FOR [RangePlan]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusLYCh1]  DEFAULT ((0)) FOR [LinePlanBusLYCh1]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusLYCh2]  DEFAULT ((0)) FOR [LinePlanBusLYCh2]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusLYCh3]  DEFAULT ((0)) FOR [LinePlanBusLYCh3]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusLYCh4]  DEFAULT ((0)) FOR [LinePlanBusLYCh4]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusLYCh5]  DEFAULT ((0)) FOR [LinePlanBusLYCh5]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusPnCh1]  DEFAULT ((0)) FOR [LinePlanBusPnCh1]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusPnCh2]  DEFAULT ((0)) FOR [LinePlanBusPnCh2]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusPnCh3]  DEFAULT ((0)) FOR [LinePlanBusPnCh3]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusPnCh4]  DEFAULT ((0)) FOR [LinePlanBusPnCh4]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusPnCh5]  DEFAULT ((0)) FOR [LinePlanBusPnCh5]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusCuCh1]  DEFAULT ((0)) FOR [LinePlanBusCuCh1]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusCuCh2]  DEFAULT ((0)) FOR [LinePlanBusCuCh2]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusCuCh3]  DEFAULT ((0)) FOR [LinePlanBusCuCh3]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusCuCh4]  DEFAULT ((0)) FOR [LinePlanBusCuCh4]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusCuCh5]  DEFAULT ((0)) FOR [LinePlanBusCuCh5]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusWpCh1]  DEFAULT ((0)) FOR [LinePlanBusWpCh1]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusWpCh2]  DEFAULT ((0)) FOR [LinePlanBusWpCh2]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusWpCh3]  DEFAULT ((0)) FOR [LinePlanBusWpCh3]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusWpCh4]  DEFAULT ((0)) FOR [LinePlanBusWpCh4]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusWpCh5]  DEFAULT ((0)) FOR [LinePlanBusWpCh5]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusTrCh1]  DEFAULT ((0)) FOR [LinePlanBusTrCh1]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusTrCh2]  DEFAULT ((0)) FOR [LinePlanBusTrCh2]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusTrCh3]  DEFAULT ((0)) FOR [LinePlanBusTrCh3]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusTrCh4]  DEFAULT ((0)) FOR [LinePlanBusTrCh4]
GO

ALTER TABLE [dbo].[pLinePlanBusinessRollUp] ADD  CONSTRAINT [DF_pLinePlanBusinessRollUp_LinePlanBusTrCh5]  DEFAULT ((0)) FOR [LinePlanBusTrCh5]
GO


-------------
-- Indexes --
-------------
CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_LinePlanID] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_LinePlanFinancialID] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanFinancialID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_LinePlanAttributeItemID1] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanAttributeItemID1] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_LinePlanAttributeItemID2] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanAttributeItemID2] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_LinePlanAttributeItemID3] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanAttributeItemID3] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_LinePlanAttributeItemID4] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanAttributeItemID4] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_TopDownJoin] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanID] ASC,
	[LinePlanFinancialID] ASC,
	[LinePlanAttributeItemID1] ASC,
	[LinePlanAttributeItemID2] ASC,
	[LinePlanAttributeItemID3] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_pLinePlanBusinessRollUp_TopDownDelete] ON [dbo].[pLinePlanBusinessRollUp] 
(
	[LinePlanID] ASC,
	[LinePlanAttributeItemID1] ASC,
	[LinePlanAttributeItemID2] ASC,
	[LinePlanAttributeItemID3] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02289', GetDate())
GO

SET NOCOUNT Off
GO
