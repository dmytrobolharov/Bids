/****** Object:  Table [dbo].[tmpMaterialColor]    Script Date: 05/21/2013 12:03:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmpMaterialColor]') AND type in (N'U'))
DROP TABLE [dbo].[tmpMaterialColor]
GO

CREATE TABLE [dbo].[tmpMaterialColor](
	[MaterialID] [uniqueidentifier] NOT NULL,
	[ColorPaletteID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tmpMaterialColors] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC,
	[ColorPaletteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05709', GetDate())
GO
