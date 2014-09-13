
/****** Object:  Table [dbo].[pGRMeasurementsAlternates]    Script Date: 11/01/2011 14:42:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOM]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsPOM]
GO
/****** Object:  Table [dbo].[pGRMeasurementsPOM]    Script Date: 11/01/2011 14:44:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsPOM](
	[POMId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[POMCode] [nvarchar](50) NOT NULL,
	[POMDesc] [nvarchar](200) NOT NULL,
	[How2MeasName] [nvarchar](200) NULL,
	[How2MeasText] [nvarchar](4000) NULL,
	[Sort] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[ImageId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[Muser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRMeasurementsPOM] PRIMARY KEY CLUSTERED 
(
	[POMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsPOM] ADD  CONSTRAINT [DF_pGRMeasurementsPOM_POMId]  DEFAULT (newid()) FOR [POMId]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOM] ADD  CONSTRAINT [DF_pGRMeasurementsPOM_SortField]  DEFAULT ((0)) FOR [Sort]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOM] ADD  CONSTRAINT [DF_pGRMeasurementsPOM_Active]  DEFAULT ((0)) FOR [Active]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02079'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02079', GetDate())
	END
GO