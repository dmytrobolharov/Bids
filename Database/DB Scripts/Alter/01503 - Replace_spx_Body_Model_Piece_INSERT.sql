
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Body_Model_Piece_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Body_Model_Piece_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[spx_Body_Model_Piece_INSERT]
(
@ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet int,
@CADDB varchar(50),
@Catalog varchar(50),
@Model_Code int
)
AS
BEGIN
DECLARE @strCADPiece nvarchar(max) 
Declare @strPiece nvarchar(max)


CREATE TABLE #tempTblPiece(
	[Piece_Code] [int]  NULL DEFAULT ((0)),
	[Piece_Name] [varchar](64)  NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL DEFAULT ((-1)),
	[IsLinked] [int] NULL DEFAULT ((0)),
	[ClassifierId] [int] NULL,
	[SystemId] [int] NULL,
	[Model_Code] [int] NULL DEFAULT ((0)),
	[Material_Code] [int] NULL,
	[Piece_Description] [varchar](510) NULL,

	[Piece_CrOpId] [varchar](100) NULL,
	[Piece_Create] [datetime] NULL,
	[Piece_RevOp1] [varchar](100) NULL,
	[Piece_Rev1] [datetime] NULL,
	[Piece_RevOp2] [varchar](100) NULL,
	[Piece_Rev2] [datetime] NULL,
	[Piece_Message] [varchar](510) NULL,
	[Piece_HPTable] [varchar](100) NULL,
	[Piece_Bias] [int] NULL DEFAULT ((0)),
	[Piece_Flip] [int] NULL DEFAULT ((0)),
	[Piece_Nap] [int] NULL DEFAULT ((0)),
	[Piece_Ign_Splice] [int] NULL DEFAULT ((0)),
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
	[Piece_IsMirror] [int] NULL DEFAULT ((0)),
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
	[PiecePosition] [int] NOT NULL DEFAULT ((0)),
	[mPiece_Area] [float] NULL,
	[mPiece_Perimeter] [float] NULL,
	[Piece_Category] [varchar](510) NULL,
	[Rule_Table_Name] [varchar](64) NULL)
	
SELECT @strPiece = 'INSERT INTO #tempTblPiece 
          ([Piece_Code]
           ,[Piece_Name]
           ,[Last_Updated]
           ,[IsActive]
           ,[IsLinked]
           ,[ClassifierId]
           ,[SystemId]
           ,[Model_Code]
           ,[Material_Code]
           ,[Piece_Description]
           ,[Piece_Category]
		   ,[Rule_Table_Name]
           ,[Piece_CrOpId]
           ,[Piece_Create]
           ,[Piece_RevOp1]
           ,[Piece_Rev1]
           ,[Piece_RevOp2]
           ,[Piece_Rev2]
           ,[Piece_Message]
           ,[Piece_HPTable]
           ,[Piece_Bias]
           ,[Piece_Flip]
           ,[Piece_Nap]
           ,[Piece_Ign_Splice]
           ,[Piece_Standard]
           ,[Piece_Buffering]
           ,[Piece_nSplits]
           ,[Piece_Tilt_CW]
           ,[Piece_DieBlock]
           ,[Piece_Pri_XBlock]
           ,[Piece_Pri_XBlkType]
           ,[Piece_Pri_YBlock]
           ,[Piece_Pri_YBlkType]
           ,[Piece_Sec_XBlock]
           ,[Piece_Sec_XBlkType]
           ,[Piece_Sec_YBlock]
           ,[Piece_Sec_YBlkType]
           ,[Piece_XVariance]
           ,[Piece_XVar_Type]
           ,[Piece_YVariance]
           ,[Piece_YVar_Type]
           ,[Piece_nUnflipped]
           ,[Piece_nOpposite]
           ,[Piece_nFilpY]
           ,[Piece_nFlipXY]
           ,[Piece_IsMirror]
           ,[Piece_Area]
           ,[Piece_Perimeter]
           ,[Piece_PreRotation]
           ,[Piece_Image_SN]
           ,[Piece_Image_Name]
           ,[Piece_Comments]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[Piece_Size]
           ,[Piece_Tilt_CCW]
           ,[Piece_CW_Type]
           ,[Piece_CCW_Type]
           ,[Piece_PreRotationType]
           ,[PiecePosition]
           ,[mPiece_Area]
           ,[mPiece_Perimeter]          
           )' +
' SELECT [Piece_Code]
      ,[Piece_Name]
      ,[Last_Updated]
      ,[IsActive]
      ,[IsLinked]
      ,[ClassifierId]
      ,[SystemId]
      ,[Model_Code]
      ,[Material_Code]
      ,[Piece_Description]
      ,[Piece_Category]
      ,[Rule_Table_Name]
      ,[Piece_CrOpId]
      ,[Piece_Create]
      ,[Piece_RevOp1]
      ,[Piece_Rev1]
      ,[Piece_RevOp2]
      ,[Piece_Rev2]
      ,[Piece_Message]
      ,[Piece_HPTable]
      ,[Piece_Bias]
      ,[Piece_Flip]
      ,[Piece_Nap]
      ,[Piece_Ign_Splice]
      ,[Piece_Standard]
      ,[Piece_Buffering]
      ,[Piece_nSplits]
      ,[Piece_Tilt_CW]
      ,[Piece_DieBlock]
      ,[Piece_Pri_XBlock]
      ,[Piece_Pri_XBlkType]
      ,[Piece_Pri_YBlock]
      ,[Piece_Pri_YBlkType]
      ,[Piece_Sec_XBlock]
      ,[Piece_Sec_XBlkType]
      ,[Piece_Sec_YBlock]
      ,[Piece_Sec_YBlkType]
      ,[Piece_XVariance]
      ,[Piece_XVar_Type]
      ,[Piece_YVariance]
      ,[Piece_YVar_Type]
      ,[Piece_nUnflipped]
      ,[Piece_nOpposite]
      ,[Piece_nFilpY]
      ,[Piece_nFlipXY]
      ,[Piece_IsMirror]
      ,[Piece_Area]
      ,[Piece_Perimeter]
      ,[Piece_PreRotation]
      ,[Piece_Image_SN]
      ,[Piece_Image_Name]
      ,[Piece_Comments]
      ,[UserDefined1]
      ,[UserDefined2]
      ,[UserDefined3]
      ,[UserDefined4]
      ,[UserDefined5]
      ,[Piece_Size]
      ,[Piece_Tilt_CCW]
      ,[Piece_CW_Type]
      ,[Piece_CCW_Type]
      ,[Piece_PreRotationType]
      ,[PiecePosition]
      ,[mPiece_Area]
      ,[mPiece_Perimeter] FROM '
 +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Piece_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)

print @strPiece
Exec (@strPiece) 

--IF  (select Count(*) from dbo.pBodyPatternSheetPiece where Model_Code = @Model_Code) = 0
--Begin

INSERT INTO [dbo].[pBodyPatternSheetPiece]
 (StyleID,StyleSet,[Piece_Code],[Piece_Name],[Last_Updated],[Active],IsLinked,Model_Code,
[Material_Code],[Piece_Description],[Piece_Category],[Rule_Table_Name],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter] , ImageID, ModelID ) 
           
SELECT  @StyleID, @StyleSet, [Piece_Code],[Piece_Name],[Last_Updated], 1 as active ,1 as Linked
, Model_Code,[Material_Code],[Piece_Description],[Piece_Category],[Rule_Table_Name],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter] ,null as ImageID, @ID 
FROM #tempTblPiece  

Drop Table #tempTblPiece
END
---------------------------------------------------------------

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01503', GetDate())
GO