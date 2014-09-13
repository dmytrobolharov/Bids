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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_SampleRequestSpecID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_SampleRequestSpecID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Critical]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Critical]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_SpecID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_SpecID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_TOL]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_TOL]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_TOLN]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_TOLN]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Ask]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Ask]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Spec]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Spec]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Vendor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Vendor]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Var]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Var]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Rev]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Rev]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Final]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Final]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Proto19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Grade19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Size19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSpecItemBOM_Sample]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] DROP CONSTRAINT [DF_pSampleRequestSpecItemBOM_Sample]
END

GO



/****** Object:  Table [dbo].[pSampleRequestSpecItemBOM]    Script Date: 12/18/2011 17:50:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSpecItemBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestSpecItemBOM]
GO


/****** Object:  Table [dbo].[pSampleRequestSpecItemBOM]    Script Date: 12/18/2011 17:50:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestSpecItemBOM](
	[SampleRequestSpecID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestSpecSizeID] [uniqueidentifier] NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[SpecMasterID] [uniqueidentifier] NULL,
	[POMTempItemID] [uniqueidentifier] NULL,
	[POMLibraryID] [uniqueidentifier] NULL,
	[ModelSpecID] [uniqueidentifier] NULL,
	[ModelID] [uniqueidentifier] NULL,
	[POMTempID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[Submit] [int] NULL,
	[Critical] [int] NULL,
	[SpecID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[POM] [nvarchar](10) NULL,
	[PointMeasur] [nvarchar](225) NULL,
	[TOL] [numeric](18, 4) NOT NULL,
	[TOLN] [numeric](18, 4) NOT NULL,
	[Ask] [numeric](18, 4) NOT NULL,
	[Spec] [numeric](18, 4) NOT NULL,
	[Vendor] [numeric](18, 4) NOT NULL,
	[Var] [numeric](18, 4) NOT NULL,
	[Rev] [numeric](18, 4) NOT NULL,
	[Final] [numeric](18, 4) NOT NULL,
	[Proto0] [numeric](18, 4) NOT NULL,
	[Proto1] [numeric](18, 4) NOT NULL,
	[Proto2] [numeric](18, 4) NOT NULL,
	[Proto3] [numeric](18, 4) NOT NULL,
	[Proto4] [numeric](18, 4) NOT NULL,
	[Proto5] [numeric](18, 4) NOT NULL,
	[Proto6] [numeric](18, 4) NOT NULL,
	[Proto7] [numeric](18, 4) NOT NULL,
	[Proto8] [numeric](18, 4) NOT NULL,
	[Proto9] [numeric](18, 4) NOT NULL,
	[Proto10] [numeric](18, 4) NOT NULL,
	[Proto11] [numeric](18, 4) NOT NULL,
	[Proto12] [numeric](18, 4) NOT NULL,
	[Proto13] [numeric](18, 4) NOT NULL,
	[Proto14] [numeric](18, 4) NOT NULL,
	[Proto15] [numeric](18, 4) NOT NULL,
	[Proto16] [numeric](18, 4) NOT NULL,
	[Proto17] [numeric](18, 4) NOT NULL,
	[Proto18] [numeric](18, 4) NOT NULL,
	[Proto19] [numeric](18, 4) NOT NULL,
	[Grade0] [numeric](18, 4) NOT NULL,
	[Grade1] [numeric](18, 4) NOT NULL,
	[Grade2] [numeric](18, 4) NOT NULL,
	[Grade3] [numeric](18, 4) NOT NULL,
	[Grade4] [numeric](18, 4) NOT NULL,
	[Grade5] [numeric](18, 4) NOT NULL,
	[Grade6] [numeric](18, 4) NOT NULL,
	[Grade7] [numeric](18, 4) NOT NULL,
	[Grade8] [numeric](18, 4) NOT NULL,
	[Grade9] [numeric](18, 4) NOT NULL,
	[Grade10] [numeric](18, 4) NOT NULL,
	[Grade11] [numeric](18, 4) NOT NULL,
	[Grade12] [numeric](18, 4) NOT NULL,
	[Grade13] [numeric](18, 4) NOT NULL,
	[Grade14] [numeric](18, 4) NOT NULL,
	[Grade15] [numeric](18, 4) NOT NULL,
	[Grade16] [numeric](18, 4) NOT NULL,
	[Grade17] [numeric](18, 4) NOT NULL,
	[Grade18] [numeric](18, 4) NOT NULL,
	[Grade19] [numeric](18, 4) NOT NULL,
	[Size0] [numeric](18, 4) NOT NULL,
	[Size1] [numeric](18, 4) NOT NULL,
	[Size2] [numeric](18, 4) NOT NULL,
	[Size3] [numeric](18, 4) NOT NULL,
	[Size4] [numeric](18, 4) NOT NULL,
	[Size5] [numeric](18, 4) NOT NULL,
	[Size6] [numeric](18, 4) NOT NULL,
	[Size7] [numeric](18, 4) NOT NULL,
	[Size8] [numeric](18, 4) NOT NULL,
	[Size9] [numeric](18, 4) NOT NULL,
	[Size10] [numeric](18, 4) NOT NULL,
	[Size11] [numeric](18, 4) NOT NULL,
	[Size12] [numeric](18, 4) NOT NULL,
	[Size13] [numeric](18, 4) NOT NULL,
	[Size14] [numeric](18, 4) NOT NULL,
	[Size15] [numeric](18, 4) NOT NULL,
	[Size16] [numeric](18, 4) NOT NULL,
	[Size17] [numeric](18, 4) NOT NULL,
	[Size18] [numeric](18, 4) NOT NULL,
	[Size19] [numeric](18, 4) NOT NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Change] [int] NULL,
	[Sort] [nvarchar](5) NULL,
	[HowToMeasurText] [nvarchar](4000) NULL,
	[HowToMeasurImage] [nvarchar](100) NULL,
	[Sample] [numeric](18, 4) NOT NULL,
 CONSTRAINT [PK_pSampleRequestSpecItemBOM] PRIMARY KEY CLUSTERED 
(
	[SampleRequestSpecID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_SampleRequestSpecID]  DEFAULT (newid()) FOR [SampleRequestSpecID]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Critical]  DEFAULT ((0)) FOR [Critical]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_SpecID]  DEFAULT (newid()) FOR [SpecID]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_TOL]  DEFAULT ((0)) FOR [TOL]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_TOLN]  DEFAULT ((0)) FOR [TOLN]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Ask]  DEFAULT ((0)) FOR [Ask]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Spec]  DEFAULT ((0)) FOR [Spec]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Vendor]  DEFAULT ((0)) FOR [Vendor]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Var]  DEFAULT ((0)) FOR [Var]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Rev]  DEFAULT ((0)) FOR [Rev]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Final]  DEFAULT ((0)) FOR [Final]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto0]  DEFAULT ((0)) FOR [Proto0]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto1]  DEFAULT ((0)) FOR [Proto1]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto2]  DEFAULT ((0)) FOR [Proto2]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto3]  DEFAULT ((0)) FOR [Proto3]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto4]  DEFAULT ((0)) FOR [Proto4]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto5]  DEFAULT ((0)) FOR [Proto5]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto6]  DEFAULT ((0)) FOR [Proto6]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto7]  DEFAULT ((0)) FOR [Proto7]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto8]  DEFAULT ((0)) FOR [Proto8]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto9]  DEFAULT ((0)) FOR [Proto9]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto10]  DEFAULT ((0)) FOR [Proto10]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto11]  DEFAULT ((0)) FOR [Proto11]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto12]  DEFAULT ((0)) FOR [Proto12]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto13]  DEFAULT ((0)) FOR [Proto13]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto14]  DEFAULT ((0)) FOR [Proto14]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto15]  DEFAULT ((0)) FOR [Proto15]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto16]  DEFAULT ((0)) FOR [Proto16]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto17]  DEFAULT ((0)) FOR [Proto17]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto18]  DEFAULT ((0)) FOR [Proto18]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Proto19]  DEFAULT ((0)) FOR [Proto19]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade0]  DEFAULT ((0)) FOR [Grade0]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade1]  DEFAULT ((0)) FOR [Grade1]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade2]  DEFAULT ((0)) FOR [Grade2]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade3]  DEFAULT ((0)) FOR [Grade3]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade4]  DEFAULT ((0)) FOR [Grade4]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade5]  DEFAULT ((0)) FOR [Grade5]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade6]  DEFAULT ((0)) FOR [Grade6]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade7]  DEFAULT ((0)) FOR [Grade7]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade8]  DEFAULT ((0)) FOR [Grade8]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade9]  DEFAULT ((0)) FOR [Grade9]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade10]  DEFAULT ((0)) FOR [Grade10]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade11]  DEFAULT ((0)) FOR [Grade11]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade12]  DEFAULT ((0)) FOR [Grade12]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade13]  DEFAULT ((0)) FOR [Grade13]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade14]  DEFAULT ((0)) FOR [Grade14]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade15]  DEFAULT ((0)) FOR [Grade15]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade16]  DEFAULT ((0)) FOR [Grade16]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade17]  DEFAULT ((0)) FOR [Grade17]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade18]  DEFAULT ((0)) FOR [Grade18]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Grade19]  DEFAULT ((0)) FOR [Grade19]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size0]  DEFAULT ((0)) FOR [Size0]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size1]  DEFAULT ((0)) FOR [Size1]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size2]  DEFAULT ((0)) FOR [Size2]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size3]  DEFAULT ((0)) FOR [Size3]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size4]  DEFAULT ((0)) FOR [Size4]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size5]  DEFAULT ((0)) FOR [Size5]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size6]  DEFAULT ((0)) FOR [Size6]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size7]  DEFAULT ((0)) FOR [Size7]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size8]  DEFAULT ((0)) FOR [Size8]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size9]  DEFAULT ((0)) FOR [Size9]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size10]  DEFAULT ((0)) FOR [Size10]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size11]  DEFAULT ((0)) FOR [Size11]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size12]  DEFAULT ((0)) FOR [Size12]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size13]  DEFAULT ((0)) FOR [Size13]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size14]  DEFAULT ((0)) FOR [Size14]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size15]  DEFAULT ((0)) FOR [Size15]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size16]  DEFAULT ((0)) FOR [Size16]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size17]  DEFAULT ((0)) FOR [Size17]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size18]  DEFAULT ((0)) FOR [Size18]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Size19]  DEFAULT ((0)) FOR [Size19]
GO

ALTER TABLE [dbo].[pSampleRequestSpecItemBOM] ADD  CONSTRAINT [DF_pSampleRequestSpecItemBOM_Sample]  DEFAULT ((0)) FOR [Sample]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02359'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02359', GetDate())

END

GO

