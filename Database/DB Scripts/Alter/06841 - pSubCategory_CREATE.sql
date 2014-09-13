IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSubCategory_CustomID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSubCategory] DROP CONSTRAINT [DF_pSubCategory_CustomID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSubCategory]') AND type in (N'U'))
DROP TABLE [dbo].[pSubCategory]
GO

CREATE TABLE [dbo].[pSubCategory](
	[CustomID] [uniqueidentifier] NOT NULL,
	[Custom] [nvarchar](200) NULL,
	[CustomKey] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CustomSort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pSubCategory] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSubCategory] ADD  CONSTRAINT [DF_pSubCategory_CustomID]  DEFAULT (newid()) FOR [CustomID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06841', GetDate())
GO
