/****** Object:  Table [dbo].[uTradePartnerInfrastructureType]    Script Date: 11/28/2012 13:52:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerInfrastructureType]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerInfrastructureType]
GO

/****** Object:  Table [dbo].[uTradePartnerInfrastructureType]    Script Date: 11/28/2012 13:52:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uTradePartnerInfrastructureType](
	[InfrastructureTypeID] [int] NOT NULL,
	[InfrastructureTypeName] [nvarchar](200) NULL,
	[InfrastructureTypeSchema] [varchar](200) NULL,
 CONSTRAINT [PK_uTradePartnerInfrastructureType] PRIMARY KEY CLUSTERED 
(
	[InfrastructureTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

INSERT [dbo].[uTradePartnerInfrastructureType] ([InfrastructureTypeID], [InfrastructureTypeName], [InfrastructureTypeSchema]) VALUES (1, N'Information Technology ', N'Vendor_FolderPageInformationTechnology_Default.xml')
INSERT [dbo].[uTradePartnerInfrastructureType] ([InfrastructureTypeID], [InfrastructureTypeName], [InfrastructureTypeSchema]) VALUES (2, N'Factory Location', N'Vendor_FolderPageInfrastructure_Default.xml')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04476', GetDate())
GO