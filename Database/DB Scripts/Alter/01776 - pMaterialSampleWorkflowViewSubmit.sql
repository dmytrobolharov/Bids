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

/****** Object:  Table [dbo].[pMaterialSampleWorkflowViewSubmit]    Script Date: 08/25/2011 16:01:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSampleWorkflowViewSubmit]') AND type = N'U' )
	DROP TABLE [dbo].[pMaterialSampleWorkflowViewSubmit]	
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMaterialSampleWorkflowViewSubmit](
	[MaterialSampleWorkflowViewSubmitId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[WorkflowId] [uniqueidentifier] NULL,
	[SampleWorkflowId] [varchar](3) NULL,
	[TeamId] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	CONSTRAINT [PK_pMaterialSampleWorkflowViewSubmit] PRIMARY KEY CLUSTERED 
	(
	[MaterialSampleWorkflowViewSubmitId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

	ALTER TABLE [dbo].[pMaterialSampleWorkflowViewSubmit] ADD  CONSTRAINT [DF_pMaterialSampleWorkflowViewSubmit_MaterialSampleWorkflowViewSubmitId]  DEFAULT (newid()) FOR [MaterialSampleWorkflowViewSubmitId]
GO

	ALTER TABLE [dbo].[pMaterialSampleWorkflowViewSubmit] ADD  CONSTRAINT [DF_pMaterialSampleWorkflowViewSubmit_CDate]  DEFAULT (getdate()) FOR [CDate]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01776'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01776', GetDate())
END
GO
