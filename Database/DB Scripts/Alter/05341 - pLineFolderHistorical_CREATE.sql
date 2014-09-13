/****** Object:  Table [dbo].[pLineFolderHistorical]    Script Date: 03/19/2013 15:21:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderHistorical]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderHistorical]
GO

CREATE TABLE [dbo].[pLineFolderHistorical](
	[LineFolderMasterID] [uniqueidentifier] NOT NULL,
	[LineFolderID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pLineFolderHistorical] PRIMARY KEY CLUSTERED 
(
	[LineFolderMasterID] ASC,
	[LineFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05341', GetDate())
GO
