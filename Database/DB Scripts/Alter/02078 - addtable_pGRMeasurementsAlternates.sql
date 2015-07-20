
/****** Object:  Table [dbo].[pGRMeasurementsAlternates]    Script Date: 11/01/2011 14:42:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsAlternates]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsAlternates]
GO

/****** Object:  Table [dbo].[pGRMeasurementsAlternates]    Script Date: 11/01/2011 14:42:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsAlternates](
	[AlternatesId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[AlternatesCode] [nvarchar](10) NULL,
	[AlternatesDesc] [nvarchar](100) NULL,
	[Sort] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRMeasurementsAlternates] PRIMARY KEY CLUSTERED 
(
	[AlternatesId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsAlternates] ADD  CONSTRAINT [DF_pGRMeasurementsAlternates_AlternatesId]  DEFAULT (newid()) FOR [AlternatesId]
GO

ALTER TABLE [dbo].[pGRMeasurementsAlternates] ADD  CONSTRAINT [DF_pGRMeasurementsAlternates_Sort]  DEFAULT ((0)) FOR [Sort]
GO

ALTER TABLE [dbo].[pGRMeasurementsAlternates] ADD  CONSTRAINT [DF_pGRMeasurementsAlternates_Active]  DEFAULT ((0)) FOR [Active]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02078'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02078', GetDate())
	END
GO