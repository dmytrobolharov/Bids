
CREATE TABLE [dbo].[pStyleSourcingColor](
	[StyleSourcingColorID] [uniqueidentifier] NOT NULL,
	[StyleSourcingID] [uniqueidentifier] NOT NULL,
	[StyleColorID] [uniqueidentifier] NOT NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[ColorCustom1] [nvarchar](200) NULL,
	[ColorCustom2] [nvarchar](200) NULL,
	[ColorCustom3] [nvarchar](200) NULL,
 CONSTRAINT [PK_pStyleSourcingColor] PRIMARY KEY CLUSTERED 
(
	[StyleSourcingColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '095', GetDate())

GO



