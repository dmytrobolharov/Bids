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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSetBOMItemTemp_StyleRequestWorkflowSetItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSetBOMItemTemp] DROP CONSTRAINT [DF_pSampleRequestSetBOMItemTemp_StyleRequestWorkflowSetItemID]
END

GO



/****** Object:  Table [dbo].[pSampleRequestSetBOMItemTemp]    Script Date: 12/18/2011 17:33:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSetBOMItemTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSetBOMItemTemp]
GO



/****** Object:  Table [dbo].[pSampleRequestSetBOMItemTemp]    Script Date: 12/18/2011 17:33:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSetBOMItemTemp](
	[StyleRequestWorkflowSetItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestGroupID] [uniqueidentifier] NULL,
	[SampleWorkflowTempID] [uniqueidentifier] NULL,
	[SampleScheduleType] [nvarchar](10) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_pSampleRequestSetBOMItemTemp] PRIMARY KEY CLUSTERED 
(
	[StyleRequestWorkflowSetItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSetBOMItemTemp] ADD  CONSTRAINT [DF_pSampleRequestSetBOMItemTemp_StyleRequestWorkflowSetItemID]  DEFAULT (newid()) FOR [StyleRequestWorkflowSetItemID]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02343'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02343', GetDate())

END

GO 

