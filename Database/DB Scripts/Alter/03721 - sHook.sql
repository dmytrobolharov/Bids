-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 Juky 2012                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sHook_HookID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sHook] DROP CONSTRAINT [DF_sHook_HookID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sHook_RunWSAsync]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sHook] DROP CONSTRAINT [DF_sHook_RunWSAsync]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sHook_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sHook] DROP CONSTRAINT [DF_sHook_Active]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sHook]') AND type in (N'U'))
DROP TABLE [dbo].[sHook]
GO


CREATE TABLE [dbo].[sHook](
	[HookID] [uniqueidentifier] NOT NULL,
	[PageName] [nvarchar](300) NOT NULL,
	[CRUDID] [uniqueidentifier] NOT NULL,
	[HookTypeID] [uniqueidentifier] NOT NULL,
	[WebServiceURL] [nvarchar](400) NOT NULL,
	[WSFiltersXML] [xml],
	[WSClientName] [nvarchar](25) NULL,
	[RunWSAsync] [int] NOT NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sHook] PRIMARY KEY CLUSTERED 
(
	[HookID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[sHook] ADD  CONSTRAINT [DF_sHook_HookID]  DEFAULT (newid()) FOR [HookID]
GO

ALTER TABLE [dbo].[sHook] ADD  CONSTRAINT [DF_sHook_RunWSAsync]  DEFAULT ((0)) FOR [RunWSAsync]
GO

ALTER TABLE [dbo].[sHook] ADD  CONSTRAINT [DF_sHook_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03721', GetDate())
GO

SET NOCOUNT Off
GO
