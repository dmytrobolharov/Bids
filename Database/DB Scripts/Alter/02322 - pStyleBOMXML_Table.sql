
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Dec 2011                                                                               */
-- * WorkItem #5300                                                                             */
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

/****** Object:  Table [dbo].[pStyleBOMXML]    Script Date: 12/16/2011 12:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMXML]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleBOMXML]
GO



/****** Object:  Table [dbo].[pStyleBOMXML]    Script Date: 12/16/2011 12:38:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMXML](
	[XmlID] [int] IDENTITY(1,1) NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[WorkflowItemID] [uniqueidentifier] NULL,
	[SchemaXML] [xml] NULL
) ON [PRIMARY]


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02322'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02322', GetDate())

END

GO
