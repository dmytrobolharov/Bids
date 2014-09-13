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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestBOMActivity_SampleRequestActivityId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestBOMActivity] DROP CONSTRAINT [DF_pSampleRequestBOMActivity_SampleRequestActivityId]
END

GO



/****** Object:  Table [dbo].[pSampleRequestBOMActivity]    Script Date: 12/18/2011 17:41:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestBOMActivity]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestBOMActivity]
GO



/****** Object:  Table [dbo].[pSampleRequestBOMActivity]    Script Date: 12/18/2011 17:41:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pSampleRequestBOMActivity](
	[SampleActivityId] [int] IDENTITY(1,1) NOT NULL,
	[SampleRequestTradeId] [uniqueidentifier] NULL,
	[SampleRequestSubmitID] [uniqueidentifier] NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[TradePartnerVendorId] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[TechPackId] [uniqueidentifier] NULL,
	[SampleActivity] [nvarchar](50) NULL,
	[ActivityType] [varchar](2) NULL,
	[TeamId] [uniqueidentifier] NULL,
	[TradePartner] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[SampleRequestActivityId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pSampleRequestBOMActivity] PRIMARY KEY CLUSTERED 
(
	[SampleActivityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pSampleRequestBOMActivity] ADD  CONSTRAINT [DF_pSampleRequestBOMActivity_SampleRequestActivityId]  DEFAULT (newid()) FOR [SampleRequestActivityId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02352'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02352', GetDate())

END

GO

