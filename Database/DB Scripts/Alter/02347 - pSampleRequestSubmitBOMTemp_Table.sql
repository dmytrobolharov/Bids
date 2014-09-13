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

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pSampleRequestSubmitBOMTemp_pSampleRequestWorkflowBOMTemp]') AND parent_object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOMTemp]'))
ALTER TABLE [dbo].[pSampleRequestSubmitBOMTemp] DROP CONSTRAINT [FK_pSampleRequestSubmitBOMTemp_pSampleRequestWorkflowBOMTemp]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSubmitBOMTemp_SampleRequestSubmitID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSubmitBOMTemp] DROP CONSTRAINT [DF_pSampleRequestSubmitBOMTemp_SampleRequestSubmitID]
END

GO



/****** Object:  Table [dbo].[pSampleRequestSubmitBOMTemp]    Script Date: 12/18/2011 17:37:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitBOMTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSubmitBOMTemp]
GO



/****** Object:  Table [dbo].[pSampleRequestSubmitBOMTemp]    Script Date: 12/18/2011 17:37:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSubmitBOMTemp](
	[SampleRequestSubmitID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestGroupID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[Submit] [int] NOT NULL,
	[Status] [int] NULL,
	[AssignedTo] [int] NULL,
	[StartDate] [datetime] NULL,
	[RecDate] [datetime] NULL,
	[RecBy] [nvarchar](100) NULL,
	[RecCarrier] [nvarchar](100) NULL,
	[RecTrackNo] [nvarchar](100) NULL,
	[RecWeight] [nvarchar](50) NULL,
	[VendorWeight] [nvarchar](50) NULL,
	[VendorDate] [datetime] NULL,
	[VendorName] [nvarchar](100) NULL,
	[SubmitDays] [int] NULL,
	[ResubmitDays] [int] NULL,
	[DueDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[EndBy] [nvarchar](100) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Comment] [nvarchar](4000) NULL,
	[InternalComment] [nvarchar](4000) NULL,
	[SampleWorkflowFinalDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOMTemp]  WITH NOCHECK ADD  CONSTRAINT [FK_pSampleRequestSubmitBOMTemp_pSampleRequestWorkflowBOMTemp] FOREIGN KEY([SampleRequestWorkflowID])
REFERENCES [dbo].[pSampleRequestWorkflowBOMTemp] ([SampleRequestWorkflowID])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOMTemp] NOCHECK CONSTRAINT [FK_pSampleRequestSubmitBOMTemp_pSampleRequestWorkflowBOMTemp]
GO

ALTER TABLE [dbo].[pSampleRequestSubmitBOMTemp] ADD  CONSTRAINT [DF_pSampleRequestSubmitBOMTemp_SampleRequestSubmitID]  DEFAULT (newid()) FOR [SampleRequestSubmitID]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02347'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02347', GetDate())

END

GO