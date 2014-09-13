
/****** Object:  Table [dbo].[pBodyMarker]    Script Date: 09/10/2010 15:30:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pBodyMarker](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pBodyMarker_ID]  DEFAULT (newid()),
	[BodyID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[Marker_Code] [int] NOT NULL CONSTRAINT [DF__pBodyMark__Marke__72BCB600]  DEFAULT ((0)),
	[Marker_Name] [varchar](64) NOT NULL,
	[Location] [varchar](510) NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL CONSTRAINT [DF__pBodyMark__IsAct__73B0DA39]  DEFAULT ((-1)),
	[IsLinkedBF] [int] NULL,
	[IsLinked] [int] NULL CONSTRAINT [DF__pBodyMark__IsLin__74A4FE72]  DEFAULT ((0)),
	[Usage] [float] NULL,
	[LossFactor] [float] NULL,
	[LossFactor_pct] [float] NULL,
	[TotalUsage] [float] NULL,
	[AdjustedUsage] [float] NULL,
	[Marker_Description] [varchar](510) NULL,
	[Marker_CrOpId] [varchar](100) NULL,
	[Marker_Create] [datetime] NULL,
	[Marker_RevOp1] [varchar](100) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Marker_Rev1] [datetime] NULL,
	[Marker_RevOp2] [varchar](100) NULL,
	[Marker_Rev2] [datetime] NULL,
	[Marker_Width] [float] NULL,
	[Marker_Length] [float] NULL,
	[Marker_Total_Perim] [float] NULL,
	[Marker_Total_Area] [float] NULL,
	[Marker_Goal] [float] NULL,
	[Marker_Efficiency] [float] NULL,
	[Marker_Notches] [int] NULL,
	[Marker_Drillholes] [int] NULL,
	[Marker_Corners] [int] NULL,
	[Marker_Message] [varchar](100) NULL,
	[Marker_nModels] [int] NULL,
	[Marker_nPieces] [int] NULL,
	[Marker_PlacPieces] [int] NULL,
	[Marker_nSizes] [int] NULL,
	[Marker_nBundles] [int] NULL,
	[Marker_Plac_Bndl] [int] NULL,
	[Marker_Bias] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__759922AB]  DEFAULT ((0)),
	[Marker_Flip] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__768D46E4]  DEFAULT ((0)),
	[Marker_Nap] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__77816B1D]  DEFAULT ((0)),
	[Marker_NCEdits] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__78758F56]  DEFAULT ((0)),
	[Marker_Spread] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__7969B38F]  DEFAULT ((0)),
	[Marker_Closed] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__7A5DD7C8]  DEFAULT ((0)),
	[Marker_DieBlk] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__7B51FC01]  DEFAULT ((0)),
	[Marker_Tubular] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__7C46203A]  DEFAULT ((0)),
	[Marker_StripePlaid] [int] NULL CONSTRAINT [DF__pBodyMark__Marke__7D3A4473]  DEFAULT ((0)),
	[Marker_nStripes] [int] NULL,
	[Marker_nPlaids] [int] NULL,
	[Marker_5_Star] [int] NULL,
	[Marker_Max_Splice] [float] NULL,
	[Marker_nSplices] [int] NULL,
	[Marker_XVariance] [float] NULL,
	[Marker_YVariance] [float] NULL,
	[Marker_Image_SN] [int] NULL,
	[Marker_Image_Name] [varchar](510) NULL,
	[Marker_Comments] [text] NULL,
	[CADCatId] [int] NOT NULL,
	[Category] [varchar](100) NULL,
	[SubCat] [varchar](100) NULL,
	[SubCatType] [varchar](100) NULL,
	[Class] [varchar](100) NULL,
	[UserDefined1] [varchar](100) NULL,
	[UserDefined2] [varchar](100) NULL,
	[UserDefined3] [varchar](100) NULL,
	[UserDefined4] [varchar](100) NULL,
	[UserDefined5] [varchar](100) NULL,
	[PreferMetric] [int] NULL CONSTRAINT [DF__pBodyMark__Prefe__7E2E68AC]  DEFAULT ((0)),
	[IsCosting] [int] NULL CONSTRAINT [DF__pBodyMark__IsCos__7F228CE5]  DEFAULT ((0)),
	[IsApproved] [int] NULL CONSTRAINT [DF__pBodyMark__IsApp__0016B11E]  DEFAULT ((0)),
	[Sizes] [varchar](4000) NULL,
	[EfficiencyType] [int] NULL,
	[LastCADRefresh] [datetime] NULL,
	[PlotFileLocation] [varchar](510) NULL,
	[NotchFile] [varchar](100) NULL,
	[AnnotationFile] [varchar](100) NULL,
	[StorageType] [int] NULL,
	[mMarker_Width] [float] NULL,
	[mMarker_Length] [float] NULL,
	[mMarker_Total_Perim] [float] NULL,
	[mMarker_Total_Area] [float] NULL,
	[Yield_per_Bundle] [float] NULL,
	[Yield_per_Dozen] [float] NULL,
	[mYield_per_Bundle] [float] NULL,
	[mYield_per_Dozen] [float] NULL,
 CONSTRAINT [PK_pBodyMarker] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(newid())' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pBodyMarker', @level2type=N'COLUMN',@level2name=N'ID'
GO
-------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '381', GetDate())
GO