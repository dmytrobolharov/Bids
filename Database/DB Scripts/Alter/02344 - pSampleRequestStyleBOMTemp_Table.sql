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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestStyleBOMTemp_SampleRequestStyleID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestStyleBOMTemp] DROP CONSTRAINT [DF_pSampleRequestStyleBOMTemp_SampleRequestStyleID]
END

GO


/****** Object:  Table [dbo].[pSampleRequestStyleBOMTemp]    Script Date: 12/18/2011 17:34:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyleBOMTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestStyleBOMTemp]
GO


/****** Object:  Table [dbo].[pSampleRequestStyleBOMTemp]    Script Date: 12/18/2011 17:34:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestStyleBOMTemp](
	[SampleRequestStyleID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestGroupID] [uniqueidentifier] NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Submit] [int] NULL,
	[StyleType] [int] NULL,
	[WorkflowType] [uniqueidentifier] NULL,
	[RefNo] [int] NULL,
	[StyleNo] [nvarchar](20) NULL,
	[TempID] [nvarchar](20) NULL,
	[TempNo] [nvarchar](20) NULL,
	[CustomerNo] [nvarchar](50) NULL,
	[ConceptID] [uniqueidentifier] NULL,
	[ConceptNo] [nvarchar](50) NULL,
	[SpecNo] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
	[SizeRange] [nvarchar](50) NULL,
	[DueDate] [datetime] NULL,
	[RecDate] [datetime] NULL,
	[Customer] [nvarchar](200) NULL,
	[Buyer] [nvarchar](200) NULL,
	[Designer] [nvarchar](100) NULL,
	[SampleMaker] [nvarchar](100) NULL,
	[PatternMaker] [nvarchar](100) NULL,
	[ProductionManager] [nvarchar](100) NULL,
	[TechnicalDesigner] [nvarchar](100) NULL,
	[StyleStatus] [nvarchar](50) NULL,
	[StyleLocation] [nvarchar](50) NULL,
	[Pitch] [int] NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[MaterialImageID] [uniqueidentifier] NULL,
	[MaterialImageVersion] [int] NULL,
	[MaterialNo] [nvarchar](50) NULL,
	[MaterialName] [nvarchar](200) NULL,
	[StyleMaterialID] [uniqueidentifier] NULL,
	[DesignSketchID] [uniqueidentifier] NULL,
	[DesignSketchVersion] [int] NULL,
	[Markup] [numeric](18, 0) NULL,
	[TargetPrice] [money] NULL,
	[SellingPrice] [money] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [nvarchar](200) NULL,
	[CustomField8] [nvarchar](200) NULL,
	[CustomField9] [nvarchar](200) NULL,
	[CustomField10] [nvarchar](200) NULL,
	[CustomField11] [nvarchar](200) NULL,
	[CustomField12] [nvarchar](200) NULL,
	[CustomField13] [nvarchar](200) NULL,
	[CustomField14] [nvarchar](200) NULL,
	[CustomField15] [nvarchar](200) NULL,
	[Size0] [nvarchar](7) NULL,
	[Size1] [nvarchar](7) NULL,
	[Size2] [nvarchar](7) NULL,
	[Size3] [nvarchar](7) NULL,
	[Size4] [nvarchar](7) NULL,
	[Size5] [nvarchar](7) NULL,
	[Size6] [nvarchar](7) NULL,
	[Size7] [nvarchar](7) NULL,
	[Size8] [nvarchar](7) NULL,
	[Size9] [nvarchar](7) NULL,
	[Size10] [nvarchar](7) NULL,
	[Size11] [nvarchar](7) NULL,
	[Sel0] [bit] NULL,
	[Sel1] [bit] NULL,
	[Sel2] [bit] NULL,
	[Sel3] [bit] NULL,
	[Sel4] [bit] NULL,
	[Sel5] [bit] NULL,
	[Sel6] [bit] NULL,
	[Sel7] [bit] NULL,
	[Sel8] [bit] NULL,
	[Sel9] [bit] NULL,
	[Sel10] [bit] NULL,
	[Sel11] [bit] NULL,
	[Pc1] [nvarchar](50) NULL,
	[Pc2] [nvarchar](50) NULL,
	[Pc3] [nvarchar](50) NULL,
	[Pc4] [nvarchar](50) NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Change] [int] NULL,
	[Action] [nvarchar](200) NULL,
	[NoColorCombo] [int] NOT NULL,
	[CustomField16] [nvarchar](200) NULL,
	[CustomField17] [nvarchar](200) NULL,
	[CustomField18] [nvarchar](200) NULL,
	[CustomField19] [nvarchar](200) NULL,
	[CustomField20] [nvarchar](200) NULL,
	[CustomField21] [nvarchar](200) NULL,
	[CustomField22] [nvarchar](200) NULL,
	[CustomField23] [nvarchar](200) NULL,
	[CustomField24] [nvarchar](200) NULL,
	[CustomField25] [nvarchar](200) NULL,
	[CustomField26] [nvarchar](200) NULL,
	[CustomField27] [nvarchar](200) NULL,
	[CustomField28] [nvarchar](200) NULL,
	[CustomField29] [nvarchar](200) NULL,
	[CustomField30] [nvarchar](200) NULL,
	[StyleColorwaySeasonYearID] [uniqueidentifier] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestStyleBOMTemp] ADD  CONSTRAINT [DF_pSampleRequestStyleBOMTemp_SampleRequestStyleID]  DEFAULT (newid()) FOR [SampleRequestStyleID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02344'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02344', GetDate())

END

GO

