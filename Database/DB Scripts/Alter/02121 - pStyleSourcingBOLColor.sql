
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSourcingBOLColor_StyleSourcingBOLColorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSourcingBOLColor] DROP CONSTRAINT [DF_pStyleSourcingBOLColor_StyleSourcingBOLColorID]
END

GO

/****** Object:  Table [dbo].[pStyleSourcingBOLColor]    Script Date: 11/04/2011 13:12:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSourcingBOLColor]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleSourcingBOLColor]
GO

/****** Object:  Table [dbo].[pStyleSourcingBOLColor]    Script Date: 11/04/2011 13:12:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleSourcingBOLColor](
	[StyleSourcingBOLColorID] [uniqueidentifier] NOT NULL,
	[StyleSourcingID] [uniqueidentifier] NULL,
	[ExceptionID] [uniqueidentifier] NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleSourcingBOLColor] PRIMARY KEY CLUSTERED 
(
	[StyleSourcingBOLColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleSourcingBOLColor] ADD  CONSTRAINT [DF_pStyleSourcingBOLColor_StyleSourcingBOLColorID]  DEFAULT (newid()) FOR [StyleSourcingBOLColorID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02121'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02121', GetDate())
	END
GO