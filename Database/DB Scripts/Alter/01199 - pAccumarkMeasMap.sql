
/****** Object:  Table [dbo].[pAccumarkMeasMap]    Script Date: 02/25/2011 17:03:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pAccumarkMeasMap](
	[AccMeasMapId] [uniqueidentifier] NOT NULL,
	[AMLMeasHdrId] [uniqueidentifier] NOT NULL,
	[sizecol] [nvarchar](10) NOT NULL,
	[sizeDesc] [nvarchar](20) NULL,
	[TextSizeCol] [nvarchar](10) NULL,
	[TextSizeDesc] [nvarchar](20) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pAccumarkMeasMap] PRIMARY KEY CLUSTERED 
(
	[AccMeasMapId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pAccumarkMeasMap] ADD  CONSTRAINT [DF_pAccumarkMeasMap_AccMeasMapId]  DEFAULT (newid()) FOR [AccMeasMapId]
GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01199', GetDate())
