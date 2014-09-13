

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBodyPatternSheetPiece_ID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF_pBodyPatternSheetPiece_ID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__674B0354]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__674B0354]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__IsAct__683F278D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__IsAct__683F278D]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__IsLin__69334BC6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__IsLin__69334BC6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Model__6A276FFF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Model__6A276FFF]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__6B1B9438]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__6B1B9438]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__6C0FB871]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__6C0FB871]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__6D03DCAA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__6D03DCAA]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__6DF800E3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__6DF800E3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__6EEC251C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__6EEC251C]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pBodyPatt__Piece__6FE04955]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBodyPatternSheetPiece] DROP CONSTRAINT [DF__pBodyPatt__Piece__6FE04955]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBodyPatternSheetPiece]') AND type in (N'U'))
DROP TABLE [dbo].[pBodyPatternSheetPiece]
GO


CREATE TABLE [dbo].[pBodyPatternSheetPiece](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[BodyID] [uniqueidentifier] NULL,
	[Piece_Code] [int] NOT NULL,
	[Piece_Name] [varchar](64) NOT NULL,
	[Last_Updated] [datetime] NULL,
	[Active] [int] NULL,
	[IsLinked] [int] NULL,
	[Model_Code] [int] NULL,
	[Material_Code] [int] NULL,
	[Piece_Description] [varchar](510) NULL,
	[Piece_Category] [varchar](510) NULL,
	[Rule_Table_Name] [varchar](64) NULL,
	[Piece_CrOpId] [varchar](100) NULL,
	[Piece_Create] [datetime] NULL,
	[Piece_RevOp1] [varchar](100) NULL,
	[Piece_Rev1] [datetime] NULL,
	[Piece_RevOp2] [varchar](100) NULL,
	[Piece_Rev2] [datetime] NULL,
	[Piece_Message] [varchar](510) NULL,
	[Piece_HPTable] [varchar](100) NULL,
	[Piece_Bias] [int] NULL,
	[Piece_Flip] [int] NULL,
	[Piece_Nap] [int] NULL,
	[Piece_Ign_Splice] [int] NULL,
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
	[Piece_IsMirror] [int] NULL,
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
	[PiecePosition] [int] NOT NULL,
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
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF_pBodyPatternSheetPiece_ID]  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__674B0354]  DEFAULT ((0)) FOR [Piece_Code]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__IsAct__683F278D]  DEFAULT ((-1)) FOR [Active]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__IsLin__69334BC6]  DEFAULT ((0)) FOR [IsLinked]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Model__6A276FFF]  DEFAULT ((0)) FOR [Model_Code]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__6B1B9438]  DEFAULT ((0)) FOR [Piece_Bias]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__6C0FB871]  DEFAULT ((0)) FOR [Piece_Flip]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__6D03DCAA]  DEFAULT ((0)) FOR [Piece_Nap]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__6DF800E3]  DEFAULT ((0)) FOR [Piece_Ign_Splice]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__6EEC251C]  DEFAULT ((0)) FOR [Piece_IsMirror]
GO

ALTER TABLE [dbo].[pBodyPatternSheetPiece] ADD  CONSTRAINT [DF__pBodyPatt__Piece__6FE04955]  DEFAULT ((0)) FOR [PiecePosition]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01248', GetDate())
GO

