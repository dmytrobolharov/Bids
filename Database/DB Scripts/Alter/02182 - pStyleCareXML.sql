
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Nov 2011																				*/
-- * WorkItem #1605																				*/
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



/****** Object:  Table [dbo].[pStyleCareXML]    Script Date: 11/16/2011 12:52:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareXML]') AND type in (N'U'))
	DROP TABLE [dbo].[pStyleCareXML]
GO

CREATE TABLE [dbo].[pStyleCareXML](
	[XmlID] [int] IDENTITY(1,1) NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[SchemaXML] [xml] NULL
) ON [PRIMARY]

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02182'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02182', GetDate())
	END
GO

