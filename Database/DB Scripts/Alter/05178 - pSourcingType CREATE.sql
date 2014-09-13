IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingType_SourcingTypeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingType] DROP CONSTRAINT [DF_pSourcingType_SourcingTypeId]
END

GO
/****** Object:  Table [dbo].[pSourcingType]    Script Date: 02/27/2013 17:13:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingType]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingType]
GO

/****** Object:  Table [dbo].[pSourcingType]    Script Date: 02/27/2013 17:13:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingType](
	[SourcingTypeId] [uniqueidentifier] NOT NULL,
	[SourcingCode] [nvarchar](50) NULL,
	[SourcingTypeName] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Sort] [int] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingType] ADD  CONSTRAINT [DF_pSourcingType_SourcingTypeId]  DEFAULT (newid()) FOR [SourcingTypeId]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05178', GetDate())
GO