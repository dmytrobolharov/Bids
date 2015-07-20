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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestStyleBOMColorwayTemp_SampleRequestStyleColorwayID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestStyleBOMColorwayTemp] DROP CONSTRAINT [DF_pSampleRequestStyleBOMColorwayTemp_SampleRequestStyleColorwayID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestStyleBOMColorwayTemp_SampleRequestStyleColorwayTempId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestStyleBOMColorwayTemp] DROP CONSTRAINT [DF_pSampleRequestStyleBOMColorwayTemp_SampleRequestStyleColorwayTempId]
END

GO



/****** Object:  Table [dbo].[pSampleRequestStyleBOMColorwayTemp]    Script Date: 12/18/2011 17:35:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyleBOMColorwayTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestStyleBOMColorwayTemp]
GO


/****** Object:  Table [dbo].[pSampleRequestStyleBOMColorwayTemp]    Script Date: 12/18/2011 17:35:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestStyleBOMColorwayTemp](
	[SampleRequestStyleColorwayID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestGroupID] [uniqueidentifier] NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[StyleSet] [int] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[Submit] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[RecDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Status] [nvarchar](200) NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[SampleRequestStyleColorwayTempID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestStyleBOMColorwayTemp] ADD  CONSTRAINT [DF_pSampleRequestStyleBOMColorwayTemp_SampleRequestStyleColorwayID]  DEFAULT (newid()) FOR [SampleRequestStyleColorwayID]
GO

ALTER TABLE [dbo].[pSampleRequestStyleBOMColorwayTemp] ADD  CONSTRAINT [DF_pSampleRequestStyleBOMColorwayTemp_SampleRequestStyleColorwayTempId]  DEFAULT (newid()) FOR [SampleRequestStyleColorwayTempID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02345'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02345', GetDate())

END

GO
