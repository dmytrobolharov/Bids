-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestBOMTrade_SampleRequestTradeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestBOMTrade] DROP CONSTRAINT [DF_pSampleRequestBOMTrade_SampleRequestTradeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestBOMTrade_MessageSent]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestBOMTrade] DROP CONSTRAINT [DF_pSampleRequestBOMTrade_MessageSent]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestBOMTrade_SamplrRequestShare]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestBOMTrade] DROP CONSTRAINT [DF_pSampleRequestBOMTrade_SamplrRequestShare]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestBOMTrade_AgentView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestBOMTrade] DROP CONSTRAINT [DF_pSampleRequestBOMTrade_AgentView]
END

GO



/****** Object:  Table [dbo].[pSampleRequestBOMTrade]    Script Date: 12/18/2011 17:40:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestBOMTrade]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestBOMTrade]
GO



/****** Object:  Table [dbo].[pSampleRequestBOMTrade]    Script Date: 12/18/2011 17:40:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestBOMTrade](
	[SampleRequestTradeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[TechPackID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MessageSent] [bit] NULL,
	[SampleRequestShare] [int] NULL,
	[AgentView] [int] NULL,
	[StyleSourcingID] [uniqueidentifier] NULL,
	[StyleColorwaySeasonYearID] [uniqueidentifier] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSampleRequestBOMTrade] PRIMARY KEY CLUSTERED 
(
	[SampleRequestTradeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestBOMTrade] ADD  CONSTRAINT [DF_pSampleRequestBOMTrade_SampleRequestTradeID]  DEFAULT (newid()) FOR [SampleRequestTradeID]
GO

ALTER TABLE [dbo].[pSampleRequestBOMTrade] ADD  CONSTRAINT [DF_pSampleRequestBOMTrade_MessageSent]  DEFAULT ((0)) FOR [MessageSent]
GO

ALTER TABLE [dbo].[pSampleRequestBOMTrade] ADD  CONSTRAINT [DF_pSampleRequestBOMTrade_SamplrRequestShare]  DEFAULT ((0)) FOR [SampleRequestShare]
GO

ALTER TABLE [dbo].[pSampleRequestBOMTrade] ADD  CONSTRAINT [DF_pSampleRequestBOMTrade_AgentView]  DEFAULT ((0)) FOR [AgentView]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02351'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02351', GetDate())

END

GO
