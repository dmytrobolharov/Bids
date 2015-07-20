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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSubmitBOM_SampleRequestSubmitID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSubmitBOM] DROP CONSTRAINT [DF_pSampleRequestSubmitBOM_SampleRequestSubmitID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSubmitBOM_GradeRefresh]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSubmitBOM] DROP CONSTRAINT [DF_pSampleRequestSubmitBOM_GradeRefresh]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSubmitBOM_AgentView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSubmitBOM] DROP CONSTRAINT [DF_pSampleRequestSubmitBOM_AgentView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSubmitBOM_NoTolence]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSubmitBOM] DROP CONSTRAINT [DF_pSampleRequestSubmitBOM_NoTolence]
END

GO



/****** Object:  Table [dbo].[pSampleRequestSubmitBOM]    Script Date: 12/18/2011 17:44:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSubmitBOM]
GO



/****** Object:  Table [dbo].[pSampleRequestSubmitBOM]    Script Date: 12/18/2011 17:44:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSubmitBOM](
	[SampleRequestSubmitID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[Submit] [int] NOT NULL,
	[Status] [int] NULL,
	[AssignedTo] [int] NULL,
	[StartDate] [datetime] NULL,
	[RecDate] [datetime] NULL,
	[RecBy] [nvarchar](200) NULL,
	[RecCarrier] [nvarchar](200) NULL,
	[RecTrackNo] [nvarchar](100) NULL,
	[RecWeight] [nvarchar](50) NULL,
	[VendorWeight] [nvarchar](50) NULL,
	[VendorDate] [datetime] NULL,
	[VendorName] [nvarchar](200) NULL,
	[SubmitDays] [int] NULL,
	[ResubmitDays] [int] NULL,
	[DueDate] [datetime] NULL,
	[RevDate] [datetime] NULL,
	[RevBy] [nvarchar](200) NULL,
	[EndDate] [datetime] NULL,
	[EndBy] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[TUser] [nvarchar](200) NULL,
	[TDate] [datetime] NULL,
	[GradeRefresh] [int] NOT NULL,
	[Comment] [ntext] NULL,
	[AgentView] [int] NULL,
	[VendorComment] [ntext] NULL,
	[InternalComment] [ntext] NULL,
	[NoTolerance] [int] NULL,
 CONSTRAINT [PK_pSampleRequestSubmitBOM] PRIMARY KEY CLUSTERED 
(
	[SampleRequestSubmitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOM] ADD  CONSTRAINT [DF_pSampleRequestSubmitBOM_SampleRequestSubmitID]  DEFAULT (newid()) FOR [SampleRequestSubmitID]
GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOM] ADD  CONSTRAINT [DF_pSampleRequestSubmitBOM_GradeRefresh]  DEFAULT ((1)) FOR [GradeRefresh]
GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOM] ADD  CONSTRAINT [DF_pSampleRequestSubmitBOM_AgentView]  DEFAULT ((0)) FOR [AgentView]
GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOM] ADD  CONSTRAINT [DF_pSampleRequestSubmitBOM_NoTolence]  DEFAULT ((1)) FOR [NoTolerance]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02354'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02354', GetDate())

END

GO
