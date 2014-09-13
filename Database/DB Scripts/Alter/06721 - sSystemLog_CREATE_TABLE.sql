-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 04 December 2013                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


--------------------
-- sSystemLog --
--------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'sSystemLog') AND type in (N'U'))
BEGIN
	DROP TABLE sSystemLog
END
GO

CREATE TABLE [dbo].[sSystemLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[TimeStamp] [datetime] NULL,
	[Thread] [int] NULL,
	[Severity] [int] NULL,
	[AppContext] [nvarchar](100) NULL,
	[MessageGroup] [nvarchar](100) NULL,
	[Message] [nvarchar](200) NULL,
	[ExceptionMessage] [nvarchar](3000) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[UserName] [nvarchar](100) NULL
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)
)
GO

SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06721', GetDate())
GO
