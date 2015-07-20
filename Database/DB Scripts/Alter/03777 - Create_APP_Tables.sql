
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select 1 
             from INFORMATION_SCHEMA.TABLES 
            where TABLE_TYPE='BASE TABLE' 
              and TABLE_NAME='sApp') 
 drop table sApp
GO

CREATE TABLE [dbo].[sApp](
	[ID] [nvarchar](8) NULL,
	[VendorID] [nvarchar](8) NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL
) ON [PRIMARY]

GO

IF EXISTS (select 1 
             from INFORMATION_SCHEMA.TABLES 
            where TABLE_TYPE='BASE TABLE' 
              and TABLE_NAME='sAppVendor') 
 drop table sAppVendor
GO

CREATE TABLE [dbo].[sAppVendor](
	[ID] [nvarchar](8) NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL
) ON [PRIMARY]

GO

IF EXISTS (select 1 
             from INFORMATION_SCHEMA.TABLES 
            where TABLE_TYPE='BASE TABLE' 
              and TABLE_NAME='sAppRoutingIgnores') 
 drop table sAppRoutingIgnores
GO

CREATE TABLE [dbo].[sAppRoutingIgnores](
	[AppDomain] [nvarchar](50) NULL,
	[VendorID] [nvarchar](8) NULL,
	[AppID] [nvarchar](8) NULL,
	[RouteName] [nvarchar](256) NULL,
	[RoutePattern] [nvarchar](1024) NULL,
	[Constraints] [nvarchar](2048) NULL
) ON [PRIMARY]

GO

IF EXISTS (select 1 
             from INFORMATION_SCHEMA.TABLES 
            where TABLE_TYPE='BASE TABLE' 
              and TABLE_NAME='sAppRouting') 
 drop table sAppRouting
GO

CREATE TABLE [dbo].[sAppRouting](
	[AppDomain] [nvarchar](50) NOT NULL,
	[VendorID] [nvarchar](8) NOT NULL,
	[AppID] [nvarchar](8) NOT NULL,
	[RouteName] [nvarchar](256) NOT NULL,
	[RoutePattern] [nvarchar](1024) NOT NULL,
	[PhysicalFile] [nvarchar](1024) NOT NULL,
	[DefaultValues] [nvarchar](2048) NULL,
	[Constraints] [nvarchar](2048) NULL,
	[DataTokens] [nvarchar](2048) NULL,
	[CheckPhysicalAccess] [int] NOT NULL,
	[RouteOrder] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAppRouting] ADD  CONSTRAINT [DF_sRouting5_RouteOrder]  DEFAULT ((2000000000)) FOR [RouteOrder]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03777', GetDate())
GO