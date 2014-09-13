IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleSourcingBOLVariation_StyleSourcingBOLVariation]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSourcingBOLVariation] DROP CONSTRAINT [DF_pStyleSourcingBOLVariation_StyleSourcingBOLVariation]
END
GO

/****** Object:  Table [dbo].[pStyleSourcingBOLVariation]    Script Date: 11/04/2011 13:13:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSourcingBOLVariation]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleSourcingBOLVariation]
GO

/****** Object:  Table [dbo].[pStyleSourcingBOLVariation]    Script Date: 11/04/2011 13:13:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleSourcingBOLVariation](
	[StyleSourcingBOLVariationID] [uniqueidentifier] NOT NULL,
	[StyleSourcingID] [uniqueidentifier] NULL,
	[ExceptionID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](max) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [nvarchar](200) NULL,
	[CustomField8] [nvarchar](200) NULL,
	[CustomField9] [nvarchar](200) NULL,
	[CustomField10] [nvarchar](max) NULL,
 CONSTRAINT [PK_pStyleSourcingBOLVariation] PRIMARY KEY CLUSTERED 
(
	[StyleSourcingBOLVariationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleSourcingBOLVariation] ADD  CONSTRAINT [DF_pStyleSourcingBOLVariation_StyleSourcingBOLVariation]  DEFAULT (newid()) FOR [StyleSourcingBOLVariationID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02122'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02122', GetDate())
	END
GO