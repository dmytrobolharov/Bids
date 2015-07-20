
/****** Object:  Table [dbo].[pBodyPatternSheetPiece]    Script Date: 09/10/2010 15:29:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pBodyPatternSheetPiece](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pBodyPatternSheetPiece_ID]  DEFAULT (newid()),
	[Piece_Code] [int] NOT NULL CONSTRAINT [DF__pBodyPatt__Piece__674B0354]  DEFAULT ((0)),
	[Piece_Name] [varchar](64) NOT NULL,
	[Last_Updated] [datetime] NULL,
	[Active] [int] NULL CONSTRAINT [DF__pBodyPatt__IsAct__683F278D]  DEFAULT ((-1)),
	[IsLinked] [int] NULL CONSTRAINT [DF__pBodyPatt__IsLin__69334BC6]  DEFAULT ((0)),
	[Model_Code] [int] NULL CONSTRAINT [DF__pBodyPatt__Model__6A276FFF]  DEFAULT ((0)),
	[Material_Code] [int] NULL,
	[Piece_Description] [varchar](510) NULL,
	[Piece_Category] [varchar](510) NULL,
	[Piece_CrOpId] [varchar](100) NULL,
	[Piece_Create] [datetime] NULL,
	[Piece_RevOp1] [varchar](100) NULL,
	[Piece_Rev1] [datetime] NULL,
	[Piece_RevOp2] [varchar](100) NULL,
	[Piece_Rev2] [datetime] NULL,
	[Piece_Message] [varchar](510) NULL,
	[Piece_HPTable] [varchar](100) NULL,
	[Piece_Bias] [int] NULL CONSTRAINT [DF__pBodyPatt__Piece__6B1B9438]  DEFAULT ((0)),
	[Piece_Flip] [int] NULL CONSTRAINT [DF__pBodyPatt__Piece__6C0FB871]  DEFAULT ((0)),
	[Piece_Nap] [int] NULL CONSTRAINT [DF__pBodyPatt__Piece__6D03DCAA]  DEFAULT ((0)),
	[Piece_Ign_Splice] [int] NULL CONSTRAINT [DF__pBodyPatt__Piece__6DF800E3]  DEFAULT ((0)),
	[Piece_Standard] [int] NULL,
	[Piece_Buffering] [int] NULL,
	[Piece_nSplits] [int] NULL,
	[Piece_Tilt_CW] [float] NULL,
	[Piece_DieBlock] [float] NULL,
	[Piece_Pri_XBlock] [float] NULL,
	[Piece_Pri_XBlkType] [int] NULL,
	[Piece_Pri_YBlock] [float] NULL,
	[Piece_Pri_YBlkType] [int] NULL,
	[Piece_Sec_XBlock] [float] NULL,
	[Piece_Sec_XBlkType] [int] NULL,
	[Piece_Sec_YBlock] [float] NULL,
	[Piece_Sec_YBlkType] [int] NULL,
	[Piece_XVariance] [float] NULL,
	[Piece_XVar_Type] [int] NULL,
	[Piece_YVariance] [float] NULL,
	[Piece_YVar_Type] [int] NULL,
	[Piece_nUnflipped] [int] NULL,
	[Piece_nOpposite] [int] NULL,
	[Piece_nFilpY] [int] NULL,
	[Piece_nFlipXY] [int] NULL,
	[Piece_IsMirror] [int] NULL CONSTRAINT [DF__pBodyPatt__Piece__6EEC251C]  DEFAULT ((0)),
	[Piece_Area] [float] NULL,
	[Piece_Perimeter] [float] NULL,
	[Piece_PreRotation] [float] NULL,
	[Piece_Image_SN] [int] NULL,
	[Piece_Image_Name] [varchar](100) NULL,
	[Piece_Comments] [text] NULL,
	[UserDefined1] [varchar](100) NULL,
	[UserDefined2] [varchar](100) NULL,
	[UserDefined3] [varchar](100) NULL,
	[UserDefined4] [varchar](100) NULL,
	[UserDefined5] [varchar](100) NULL,
	[Piece_Size] [varchar](64) NULL,
	[Piece_Tilt_CCW] [float] NULL,
	[Piece_CW_Type] [int] NULL,
	[Piece_CCW_Type] [int] NULL,
	[Piece_PreRotationType] [int] NULL,
	[PiecePosition] [int] NOT NULL CONSTRAINT [DF__pBodyPatt__Piece__6FE04955]  DEFAULT ((0)),
	[mPiece_Area] [float] NULL,
	[mPiece_Perimeter] [float] NULL,
	[ImageID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBodyPatternSheetPiece_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF

-------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '383', GetDate())
GO