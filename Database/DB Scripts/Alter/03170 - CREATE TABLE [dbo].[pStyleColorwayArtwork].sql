
CREATE TABLE [dbo].[pStyleColorwayArtwork](
    [StyleColorwayArtworkID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleMaterialID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [nvarchar](10) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,	
	[MaterialArtworkImageID] [uniqueidentifier] NULL,
	[MaterialArtworkImageVersion] [int] NULL,
 CONSTRAINT [PK_pStyleColorwayArtwork] PRIMARY KEY CLUSTERED 
(
	[StyleColorwayArtworkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleColorwayArtwork] ADD  CONSTRAINT [DF_pStyleColorwayArtwork_StyleColorwayArtworkID]  DEFAULT (newid()) FOR [StyleColorwayArtworkID]
GO

ALTER TABLE [dbo].[pStyleColorwayArtwork] ADD  CONSTRAINT [DF_pStyleColorwayArtwork_MaterialArtworkImageID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [MaterialArtworkImageID]
GO

ALTER TABLE [dbo].[pStyleColorwayArtwork] ADD  CONSTRAINT [DF_pStyleColorwayArtwork_MaterialArtworkImageVersion]  DEFAULT ((0)) FOR [MaterialArtworkImageVersion]
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03170', GetDate())

GO
