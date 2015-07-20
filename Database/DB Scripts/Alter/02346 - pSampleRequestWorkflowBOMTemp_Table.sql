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

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pSampleRequestWorkflowBOMTemp_pSampleRequestSetItemTemp]') AND parent_object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOMTemp]'))
ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp] DROP CONSTRAINT [FK_pSampleRequestWorkflowBOMTemp_pSampleRequestSetItemTemp]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestWorkflowBOMTemp_SampleRequestWorkflowID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp] DROP CONSTRAINT [DF_pSampleRequestWorkflowBOMTemp_SampleRequestWorkflowID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestWorkflowBOMTemp_SampleWorkflowFinalDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp] DROP CONSTRAINT [DF_pSampleRequestWorkflowBOMTemp_SampleWorkflowFinalDate]
END

GO



/****** Object:  Table [dbo].[pSampleRequestWorkflowBOMTemp]    Script Date: 12/18/2011 17:36:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowBOMTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestWorkflowBOMTemp]
GO



/****** Object:  Table [dbo].[pSampleRequestWorkflowBOMTemp]    Script Date: 12/18/2011 17:36:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestWorkflowBOMTemp](
	[SampleRequestWorkflowID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleRequestWorkflowSetItemID] [uniqueidentifier] NULL,
	[SampleRequestGroupID] [uniqueidentifier] NULL,
	[SampleWorkflowTempItemID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[StyleSet] [int] NULL,
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
	[FinalDate] [datetime] NULL,
	[SampleWorkflowFinalDate] [datetime] NULL,
 CONSTRAINT [PK_pSampleRequestWorkflowBOMTemp] PRIMARY KEY CLUSTERED 
(
	[SampleRequestWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp]  WITH NOCHECK ADD  CONSTRAINT [FK_pSampleRequestWorkflowBOMTemp_pSampleRequestSetItemTemp] FOREIGN KEY([StyleRequestWorkflowSetItemID])
REFERENCES [dbo].[pSampleRequestSetBOMItemTemp] ([StyleRequestWorkflowSetItemID])
GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp] NOCHECK CONSTRAINT [FK_pSampleRequestWorkflowBOMTemp_pSampleRequestSetItemTemp]
GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp] ADD  CONSTRAINT [DF_pSampleRequestWorkflowBOMTemp_SampleRequestWorkflowID]  DEFAULT (newid()) FOR [SampleRequestWorkflowID]
GO

ALTER TABLE [dbo].[pSampleRequestWorkflowBOMTemp] ADD  CONSTRAINT [DF_pSampleRequestWorkflowBOMTemp_SampleWorkflowFinalDate]  DEFAULT (getdate()) FOR [SampleWorkflowFinalDate]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02346'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02346', GetDate())

END

GO
