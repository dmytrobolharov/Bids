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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestStyleSourcingBOMTemp_SampleRequestStyleSourcingTempId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestStyleSourcingBOMTemp] DROP CONSTRAINT [DF_pSampleRequestStyleSourcingBOMTemp_SampleRequestStyleSourcingTempId]
END

GO


/****** Object:  Table [dbo].[pSampleRequestStyleSourcingBOMTemp]    Script Date: 12/18/2011 17:38:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyleSourcingBOMTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestStyleSourcingBOMTemp]
GO



/****** Object:  Table [dbo].[pSampleRequestStyleSourcingBOMTemp]    Script Date: 12/18/2011 17:38:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestStyleSourcingBOMTemp](
	[SampleRequestGroupID] [uniqueidentifier] NOT NULL,
	[StyleSourcingID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[SampleRequestStyleSourcingTempId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleSet] [int] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestStyleSourcingBOMTemp] ADD  CONSTRAINT [DF_pSampleRequestStyleSourcingBOMTemp_SampleRequestStyleSourcingTempId]  DEFAULT (newid()) FOR [SampleRequestStyleSourcingTempId]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02348'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02348', GetDate())

END

GO
