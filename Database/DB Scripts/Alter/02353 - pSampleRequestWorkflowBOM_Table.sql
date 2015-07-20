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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestWorkflowBOM_SampleRequestWorkflowID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] DROP CONSTRAINT [DF_pSampleRequestWorkflowBOM_SampleRequestWorkflowID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestWorkflowBOM_ResubmitDays]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] DROP CONSTRAINT [DF_pSampleRequestWorkflowBOM_ResubmitDays]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestWorkflowBOM_EndDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] DROP CONSTRAINT [DF_pSampleRequestWorkflowBOM_EndDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestWorkflowBOM_SampleWorkflowFinalDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] DROP CONSTRAINT [DF_pSampleRequestWorkflowBOM_SampleWorkflowFinalDate]
END

GO



/****** Object:  Table [dbo].[pSampleRequestWorkflowBOM]    Script Date: 12/18/2011 17:43:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestWorkflowBOM]
GO



/****** Object:  Table [dbo].[pSampleRequestWorkflowBOM]    Script Date: 12/18/2011 17:43:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestWorkflowBOM](
	[SampleRequestWorkflowID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleRequestWorkflowSetItemID] [uniqueidentifier] NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleWorkflowTempItemID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[Status] [int] NOT NULL,
	[Submit] [int] NOT NULL,
	[SubmitDays] [int] NULL,
	[ResubmitDays] [int] NULL,
	[AssignedTo] [int] NULL,
	[TechPackID] [uniqueidentifier] NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[TUser] [nvarchar](200) NULL,
	[TDate] [datetime] NULL,
	[FinalDate] [datetime] NULL,
	[SampleWorkflowFinalDate] [datetime] NULL,
 CONSTRAINT [PK_pSampleRequestWorkflowBOM] PRIMARY KEY CLUSTERED 
(
	[SampleRequestWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] ADD  CONSTRAINT [DF_pSampleRequestWorkflowBOM_SampleRequestWorkflowID]  DEFAULT (newid()) FOR [SampleRequestWorkflowID]
GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] ADD  CONSTRAINT [DF_pSampleRequestWorkflowBOM_ResubmitDays]  DEFAULT ((0)) FOR [ResubmitDays]
GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] ADD  CONSTRAINT [DF_pSampleRequestWorkflowBOM_EndDate]  DEFAULT ('1/1/1900') FOR [EndDate]
GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOM] ADD  CONSTRAINT [DF_pSampleRequestWorkflowBOM_SampleWorkflowFinalDate]  DEFAULT (getdate()) FOR [SampleWorkflowFinalDate]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02353'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02353', GetDate())

END

GO

