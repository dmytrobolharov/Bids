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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_SampleRequestSpecSizeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_SampleRequestSpecSizeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Sel19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecSizeBOM_Col19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] DROP CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col19]
END

GO



/****** Object:  Table [dbo].[pSampleRequestSpecSizeBOM]    Script Date: 12/18/2011 17:45:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSpecSizeBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSpecSizeBOM]
GO



/****** Object:  Table [dbo].[pSampleRequestSpecSizeBOM]    Script Date: 12/18/2011 17:45:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSpecSizeBOM](
	[SampleRequestSpecSizeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[SizeRange] [nvarchar](50) NULL,
	[Size0] [nvarchar](9) NULL,
	[Size1] [nvarchar](9) NULL,
	[Size2] [nvarchar](9) NULL,
	[Size3] [nvarchar](9) NULL,
	[Size4] [nvarchar](9) NULL,
	[Size5] [nvarchar](9) NULL,
	[Size6] [nvarchar](9) NULL,
	[Size7] [nvarchar](9) NULL,
	[Size8] [nvarchar](9) NULL,
	[Size9] [nvarchar](9) NULL,
	[Size10] [nvarchar](9) NULL,
	[Size11] [nvarchar](9) NULL,
	[Size12] [nvarchar](9) NULL,
	[Size13] [nvarchar](9) NULL,
	[Size14] [nvarchar](9) NULL,
	[Size15] [nvarchar](9) NULL,
	[Size16] [nvarchar](9) NULL,
	[Size17] [nvarchar](9) NULL,
	[Size18] [nvarchar](9) NULL,
	[Size19] [nvarchar](9) NULL,
	[Sel0] [bit] NOT NULL,
	[Sel1] [bit] NOT NULL,
	[Sel2] [bit] NOT NULL,
	[Sel3] [bit] NOT NULL,
	[Sel4] [bit] NOT NULL,
	[Sel5] [bit] NOT NULL,
	[Sel6] [bit] NOT NULL,
	[Sel7] [bit] NOT NULL,
	[Sel8] [bit] NOT NULL,
	[Sel9] [bit] NOT NULL,
	[Sel10] [bit] NOT NULL,
	[Sel11] [bit] NOT NULL,
	[Sel12] [bit] NOT NULL,
	[Sel13] [bit] NOT NULL,
	[Sel14] [bit] NOT NULL,
	[Sel15] [bit] NOT NULL,
	[Sel16] [bit] NOT NULL,
	[Sel17] [bit] NOT NULL,
	[Sel18] [bit] NOT NULL,
	[Sel19] [bit] NOT NULL,
	[Col0] [bit] NOT NULL,
	[Col1] [bit] NOT NULL,
	[Col2] [bit] NOT NULL,
	[Col3] [bit] NOT NULL,
	[Col4] [bit] NOT NULL,
	[Col5] [bit] NOT NULL,
	[Col6] [bit] NOT NULL,
	[Col7] [bit] NOT NULL,
	[Col8] [bit] NOT NULL,
	[Col9] [bit] NOT NULL,
	[Col10] [bit] NOT NULL,
	[Col11] [bit] NOT NULL,
	[Col12] [bit] NOT NULL,
	[Col13] [bit] NOT NULL,
	[Col14] [bit] NOT NULL,
	[Col15] [bit] NOT NULL,
	[Col16] [bit] NOT NULL,
	[Col17] [bit] NOT NULL,
	[Col18] [bit] NOT NULL,
	[Col19] [bit] NOT NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[FitComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_pSampleRequestSpecSizeBOM] PRIMARY KEY CLUSTERED 
(
	[SampleRequestSpecSizeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_SampleRequestSpecSizeID]  DEFAULT (newid()) FOR [SampleRequestSpecSizeID]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel0]  DEFAULT ((0)) FOR [Sel0]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel1]  DEFAULT ((0)) FOR [Sel1]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel2]  DEFAULT ((0)) FOR [Sel2]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel3]  DEFAULT ((0)) FOR [Sel3]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel4]  DEFAULT ((0)) FOR [Sel4]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel5]  DEFAULT ((0)) FOR [Sel5]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel6]  DEFAULT ((0)) FOR [Sel6]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel7]  DEFAULT ((0)) FOR [Sel7]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel8]  DEFAULT ((0)) FOR [Sel8]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel9]  DEFAULT ((0)) FOR [Sel9]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel10]  DEFAULT ((0)) FOR [Sel10]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel11]  DEFAULT ((0)) FOR [Sel11]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel12]  DEFAULT ((0)) FOR [Sel12]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel13]  DEFAULT ((0)) FOR [Sel13]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel14]  DEFAULT ((0)) FOR [Sel14]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel15]  DEFAULT ((0)) FOR [Sel15]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel16]  DEFAULT ((0)) FOR [Sel16]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel17]  DEFAULT ((0)) FOR [Sel17]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel18]  DEFAULT ((0)) FOR [Sel18]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Sel19]  DEFAULT ((0)) FOR [Sel19]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col0]  DEFAULT ((0)) FOR [Col0]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col1]  DEFAULT ((0)) FOR [Col1]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col2]  DEFAULT ((0)) FOR [Col2]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col3]  DEFAULT ((0)) FOR [Col3]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col4]  DEFAULT ((0)) FOR [Col4]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col5]  DEFAULT ((0)) FOR [Col5]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col6]  DEFAULT ((0)) FOR [Col6]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col7]  DEFAULT ((0)) FOR [Col7]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col8]  DEFAULT ((0)) FOR [Col8]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col9]  DEFAULT ((0)) FOR [Col9]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col10]  DEFAULT ((0)) FOR [Col10]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col11]  DEFAULT ((0)) FOR [Col11]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col12]  DEFAULT ((0)) FOR [Col12]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col13]  DEFAULT ((0)) FOR [Col13]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col14]  DEFAULT ((0)) FOR [Col14]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col15]  DEFAULT ((0)) FOR [Col15]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col16]  DEFAULT ((0)) FOR [Col16]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col17]  DEFAULT ((0)) FOR [Col17]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col18]  DEFAULT ((0)) FOR [Col18]
GO

ALTER TABLE [dbo].[pSampleRequestSpecSizeBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecSizeBOM_Col19]  DEFAULT ((0)) FOR [Col19]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02355'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02355', GetDate())

END

GO