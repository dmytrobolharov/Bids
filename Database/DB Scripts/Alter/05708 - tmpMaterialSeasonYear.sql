/****** Object:  Table [dbo].[tmpMaterialSeasonYear]    Script Date: 05/21/2013 12:02:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmpMaterialSeasonYear]') AND type in (N'U'))
DROP TABLE [dbo].[tmpMaterialSeasonYear]
GO

CREATE TABLE [dbo].[tmpMaterialSeasonYear](
	[MaterialID] [uniqueidentifier] NOT NULL,
	[SeasonYearID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tmpMaterialSeasonYear] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC,
	[SeasonYearID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05708', GetDate())
GO
