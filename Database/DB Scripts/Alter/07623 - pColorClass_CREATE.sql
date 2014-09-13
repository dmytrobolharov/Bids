IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorClass_ColorClassID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorClass] DROP CONSTRAINT [DF_pColorClass_ColorClassID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorClass]') AND type in (N'U'))
DROP TABLE [dbo].[pColorClass]
GO


CREATE TABLE [dbo].[pColorClass](
	[ColorClassID] [uniqueidentifier] NOT NULL,
	[ColorClassDisplayID] [nvarchar](10) NULL,
	[ColorClassName] [nvarchar](200) NULL,
	[ColorClassSort] [nvarchar](5) NULL,
	[ColorClassDefault] [int] NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pColorClass] PRIMARY KEY CLUSTERED 
(
	[ColorClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pColorClass] ADD  CONSTRAINT [DF_pColorClass_ColorClassID]  DEFAULT (newid()) FOR [ColorClassID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07623', GetDate())
GO