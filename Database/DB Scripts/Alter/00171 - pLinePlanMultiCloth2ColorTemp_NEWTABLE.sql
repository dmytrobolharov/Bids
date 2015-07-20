-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 June 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2ColorTemp_LinePlanMultiCloth2ColorTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_LinePlanMultiCloth2ColorTempID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2ColorTemp_MaterialCoreColorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_MaterialCoreColorID]
END

GO


/****** Object:  Table [dbo].[pLinePlanMultiCloth2ColorTemp]    Script Date: 06/16/2010 17:45:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMultiCloth2ColorTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanMultiCloth2ColorTemp]
GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2ColorTemp]    Script Date: 06/16/2010 17:45:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLinePlanMultiCloth2ColorTemp](
	[LinePlanMultiCloth2ColorTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanColorGroupID] [uniqueidentifier] NULL,
	[LinePlanColorItemID] [uniqueidentifier] NULL,
	[LinePlanRangeID] [uniqueidentifier] NULL,
	[LinePlanID] [uniqueidentifier] NULL,
	[MaterialColorID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,	
	[MaterialCoreColorID] [uniqueidentifier] NULL,
	[MainColor] [nvarchar](100) NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[StyleColorStandardID] [uniqueidentifier] NULL,
	[StyleColorNo] [nvarchar](200) NULL,
	[StyleColorName] [nvarchar](200) NULL,
	[StyleColorDelivery1] [int] NULL,
	[StyleColorDelivery2] [int] NULL,
	[StyleColorDelivery3] [int] NULL,
	[StyleColorDelivery4] [int] NULL,
	[PLMCode] [nvarchar](200) NULL,
	[SAPCode] [nvarchar](200) NULL,
	[StyleColorStatus] [int] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[Units] [int] NULL,
	[Yunique] [int] NULL,
	[ColorType] [nvarchar](50) NULL,
	[Sort] [nvarchar](10) NULL,
	[Version] [int] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,			
 CONSTRAINT [PK_pLinePlanMultiCloth2ColorTemp] PRIMARY KEY CLUSTERED 
(
	[LinePlanMultiCloth2ColorTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_LinePlanMultiCloth2ColorTempID]  DEFAULT (newsequentialid()) FOR [LinePlanMultiCloth2ColorTempID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_MaterialCoreColorID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [MaterialCoreColorID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '170', GetDate())
GO



