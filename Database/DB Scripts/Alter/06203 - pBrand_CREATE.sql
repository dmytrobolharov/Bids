IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBrand_CustomID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBrand] DROP CONSTRAINT [DF_pBrand_CustomID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBrand]') AND type in (N'U'))
DROP TABLE [dbo].[pBrand]
GO


CREATE TABLE [dbo].[pBrand](
	[CustomID] [uniqueidentifier] NOT NULL,
	[CustomKey] [nvarchar](10) NULL,
	[Custom] [nvarchar](200) NULL,
	[CustomSort] [nvarchar](5) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pBrand] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBrand] ADD  CONSTRAINT [DF_pBrand_CustomID]  DEFAULT (newid()) FOR [CustomID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06203', GetDate())
GO
