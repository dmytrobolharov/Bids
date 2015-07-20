-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 August 2011                                                                             */
-- *                                                                                            */
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

GO

/****** Object:  Table [dbo].[pMaterialSampleWorkflowViewAgent]    Script Date: 08/25/2011 21:36:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSampleWorkflowViewAgent]') AND type = N'U' )
	DROP TABLE [dbo].[pMaterialSampleWorkflowViewAgent]	
GO


CREATE TABLE [dbo].[pMaterialSampleWorkflowViewAgent](
	[MaterialSampleWorkflowViewAgentId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[TeamId] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	CONSTRAINT [PK_pMaterialSampleWorkflowViewAgent] PRIMARY KEY CLUSTERED 
	(
	[MaterialSampleWorkflowViewAgentId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

GO
	ALTER TABLE [dbo].[pMaterialSampleWorkflowViewAgent] 
	ADD  CONSTRAINT [DF_pMaterialSampleWorkflowViewAgent_MaterialSampleWorkflowViewAgentId]  DEFAULT (newid()) FOR [MaterialSampleWorkflowViewAgentId]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01775'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01775', GetDate())
END
GO
