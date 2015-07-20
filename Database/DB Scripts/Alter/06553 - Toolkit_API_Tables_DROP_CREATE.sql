-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 07 November 2013                                                                           */
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
-- tlk_APIRequest --
--------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tlk_APIRequest') AND type in (N'U'))
BEGIN
	ALTER TABLE tlk_APIRequest DROP CONSTRAINT [DF_tlk_APIRequest_APIRequestRepID]
	DROP TABLE tlk_APIRequest
END
GO

CREATE TABLE tlk_APIRequest(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Verb] [nvarchar](50) NOT NULL,
	[URL] [nvarchar](max) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[Comment] [nvarchar](2048) NULL,
	[GUID] [nvarchar](256) NOT NULL,
	[Hash] [nvarchar](512) NOT NULL,
	[CUser] [nvarchar](128) NOT NULL,
	[CDate] [datetime] NOT NULL,
	[APIRequestRepID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tlk_APIRequest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE tlk_APIRequest ADD CONSTRAINT [DF_tlk_APIRequest_APIRequestRepID] DEFAULT (newid()) FOR [APIRequestRepID]
GO


-------------
-- tlk_Job --
-------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tlk_Job') AND type in (N'U'))
BEGIN
	ALTER TABLE tlk_Job DROP CONSTRAINT [DF_tlk_Job_JobRepID]
	DROP TABLE tlk_Job
END
GO

CREATE TABLE tlk_Job(
	[ID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[Description] [nvarchar](2048) NULL,
	[JobGUID] [nvarchar](256) NULL,
	[Hash] [nvarchar](256) NULL,
	[CUser] [nvarchar](128) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](128) NULL,
	[MDate] [datetime] NULL,
	[JobRepID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tlk_Job] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE tlk_Job ADD CONSTRAINT [DF_tlk_Job_JobRepID] DEFAULT (newid()) FOR [JobRepID]
GO


--------------------
-- tlk_JobRequest --
--------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tlk_JobRequest') AND type in (N'U'))
BEGIN
	ALTER TABLE tlk_JobRequest DROP CONSTRAINT [DF_tlk_JobRequest_JobRequestRepID]
	DROP TABLE tlk_JobRequest
END
GO

CREATE TABLE tlk_JobRequest(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NULL,
	[RequestID] [int] NULL,
	[JobRequestRepID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tlk_JobRequest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE tlk_JobRequest ADD CONSTRAINT [DF_tlk_JobRequest_JobRequestRepID] DEFAULT (newid()) FOR [JobRequestRepID]
GO


-----------------
-- tlk_Machine --
-----------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tlk_Machine') AND type in (N'U'))
BEGIN
	ALTER TABLE tlk_Machine DROP CONSTRAINT [DF_tlk_Machine_MachineRepID]
	DROP TABLE tlk_Machine
END
GO

CREATE TABLE tlk_Machine(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MachineGUID] [nvarchar](128) NULL,
	[Name] [nvarchar](256) NULL,
	[Description] [nvarchar](2048) NULL,
	[IPAddress] [nvarchar](512) NULL,
	[APIEndpoint] [nvarchar](256) NULL,
	[PLMUrl] [nvarchar](256) NULL,
	[Port] [int] NULL,
	[Protocol] [nvarchar](32) NULL,
	[Username] [nvarchar](256) NULL,
	[Password] [nvarchar](256) NULL,
	[CUser] [nvarchar](256) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](256) NULL,
	[MDate] [datetime] NULL,
	[MachineRepID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tlk_Machine] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE tlk_Machine ADD CONSTRAINT [DF_tlk_Machine_MachineRepID] DEFAULT (newid()) FOR [MachineRepID]
GO


------------------
-- Initial Data --
------------------
INSERT INTO [dbo].[tlk_Job]
           ([Name]
           ,[Description]
           ,[JobGUID]
           ,[Hash]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate])
     VALUES
           ('Current Working Set'
           ,'The current work on DEV not yet packaged as a JOB'
           ,'00000000-0000-0000-0000-000000000000'
           ,''
           ,'Administrator'
           ,GetDate()
           ,'Administrator'
           ,GetDate())
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06553', GetDate())
GO
