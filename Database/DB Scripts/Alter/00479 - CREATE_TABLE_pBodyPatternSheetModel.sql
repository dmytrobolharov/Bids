
/****** Object:  Table [dbo].[pBodyPatternSheetModel]    Script Date: 10/06/2010 12:37:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.tables WHERE table_name = N'pBodyPatternSheetModel') 
DROP TABLE pBodyPatternSheetModel
GO
CREATE TABLE [dbo].[pBodyPatternSheetModel](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pBodyPatternSheetModel_ID]  DEFAULT (newid()),
	[BodyID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[Model_Code] [int] NOT NULL CONSTRAINT [DF__pBodyPatt__Model__62864E37]  DEFAULT ((0)),
	[Model_Name] [varchar](32) NOT NULL,
	[Last_Updated] [datetime] NULL,
	[Active] [int] NULL,
	[IsLinkedBF] [int] NULL,
	[IsLinked] [int] NULL CONSTRAINT [DF__pBodyPatt__IsLin__637A7270]  DEFAULT ((0)),
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Marker_Code] [int] NULL,
	[Model_Description] [varchar](255) NULL,
	[Model_CrOpId] [varchar](50) NULL,
	[Model_Create] [datetime] NULL,
	[Model_RevOp1] [varchar](50) NULL,
	[Model_Rev1] [datetime] NULL,
	[Model_RevOp2] [varchar](50) NULL,
	[Model_Rev2] [datetime] NULL,
	[Model_GRTable] [varchar](50) NULL,
	[Model_MTMFile] [varchar](50) NULL,
	[Model_SAName] [varchar](50) NULL,
	[Model_SYNTable] [varchar](50) NULL,
	[Model_HPTable] [varchar](50) NULL,
	[Model_SampleSize] [varchar](32) NULL,
	[Model_nMaterials] [int] NULL,
	[Model_nPieces] [int] NULL,
	[Model_nSizes] [int] NULL,
	[Model_Image_SN] [int] NULL,
	[Model_Image_Name] [varchar](255) NULL,
	[Model_Comments] [text] NULL,
	[PreferMetric] [int] NULL CONSTRAINT [DF__pBodyPatt__Prefe__646E96A9]  DEFAULT ((0)),
	[UserDefined1] [varchar](50) NULL,
	[UserDefined2] [varchar](50) NULL,
	[UserDefined3] [varchar](50) NULL,
	[UserDefined4] [varchar](50) NULL,
	[UserDefined5] [varchar](50) NULL,
	[Total_Area] [float] NULL,
	[LastCADRefresh] [datetime] NULL,
	[PlotFileLocation] [varchar](255) NULL,
	[NotchFile] [varchar](50) NULL,
	[AnnotationFile] [varchar](50) NULL,
	[StorageType] [int] NULL,
	[ImageID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBodyPatternSheetModel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '479', GetDate())
GO