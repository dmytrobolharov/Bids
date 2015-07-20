IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageRouting_RouteOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageRouting] DROP CONSTRAINT [DF_sPackageRouting_RouteOrder]
END

GO

/****** Object:  Table [dbo].[sPackageRouting]    Script Date: 02/03/2014 15:11:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRouting]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageRouting]
GO

/****** Object:  Table [dbo].[sPackageRouting]    Script Date: 02/03/2014 15:11:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sPackageRouting](
	[AppDomain] [nvarchar](50) NOT NULL,
	[PackageVendorID] [nvarchar](8) NOT NULL,
	[PackageID] [nvarchar](8) NOT NULL,
	[RouteName] [nvarchar](256) NOT NULL,
	[RoutePattern] [nvarchar](1024) NOT NULL,
	[PhysicalFile] [nvarchar](1024) NOT NULL,
	[DefaultValues] [nvarchar](2048) NULL,
	[Constraints] [nvarchar](2048) NULL,
	[DataTokens] [nvarchar](2048) NULL,
	[CheckPhysicalAccess] [int] NOT NULL,
	[RouteOrder] [int] NOT NULL,
 CONSTRAINT [PK_sPackageRouting] PRIMARY KEY CLUSTERED 
(
	[PackageVendorID] ASC,
	[PackageID] ASC,
	[RouteName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sPackageRouting] ADD  CONSTRAINT [DF_sPackageRouting_RouteOrder]  DEFAULT ((2000000000)) FOR [RouteOrder]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07076', GetDate())
GO
