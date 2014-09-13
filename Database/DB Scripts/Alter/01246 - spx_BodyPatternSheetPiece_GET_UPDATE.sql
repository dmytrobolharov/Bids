
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_BodyPatternSheetPiece_GET_UPDATE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_BodyPatternSheetPiece_GET_UPDATE
GO

CREATE PROC  [dbo].[spx_BodyPatternSheetPiece_GET_UPDATE]
(
  @Model_Code int,
  @CADDB varchar(50),
  @Catalog varchar(50)
)
AS
DECLARE @RowCnt int
DECLARE @Piece_Code int
DECLARE @MaxRows int
DECLARE @strCADsql nvarchar(max)

BEGIN

DECLARE  @ID uniqueidentifier

SELECT ROW_NUMBER() OVER(ORDER BY Piece_Code DESC) AS 'rownum', *
INTO #tempTblPBody
FROM pBodyPatternSheetPiece where Model_Code = @Model_Code 

SELECT @RowCnt = 1
SELECT @MaxRows=count(*) from #tempTblPBody

WHILE @RowCnt <= @MaxRows
BEGIN

------------------------------------------------
set @Model_Code = (select Model_Code from #tempTblPBody where rownum = @RowCnt) 
--set @BodyID =  (select BodyID from #tempTblPBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblPBody where rownum = @RowCnt)
Set @Piece_Code = (select Piece_Code from #tempTblPBody where rownum = @RowCnt)
------------------------------------------------
CREATE TABLE [dbo].[#tempTBLpCAD]
(
[Piece_Code] [int] NOT NULL DEFAULT (0),
	[Piece_Name] [varchar](64)  NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL DEFAULT ((1)),
	[IsLinked] [int] NULL DEFAULT (1),
	[ClassifierId] [int] NULL,
	[SystemId] [int] NULL,
	[Model_Code] [int] NULL DEFAULT (0),
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
	[Piece_Bias] [int] NULL DEFAULT (0),
	[Piece_Flip] [int] NULL DEFAULT (0),
	[Piece_Nap] [int] NULL DEFAULT (0),
	[Piece_Ign_Splice] [int] NULL DEFAULT (0),
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
	[Piece_IsMirror] [int] NULL DEFAULT (0),
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
	[PiecePosition] [int] NOT NULL DEFAULT (0),
	[mPiece_Area] [float] NULL,
	[mPiece_Perimeter] [float] NULL,
    [Piece_Category] [varchar] (510) NULL,
	[Rule_Table_Name] [varchar] (64) NULL,

)
SELECT  @strCADsql = 'INSERT
INTO #tempTBLpCAD
SELECT *
FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Piece_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code) +'  and Piece_Code = ' + Convert(varchar(50), @Piece_Code )

EXEC (@strCADsql)

Update pBodyPatternSheetPiece
SET	 
	[Piece_Code] = (SELECT Piece_Code from  #tempTBLpCAD ),
	[Piece_Name] = (SELECT Piece_Name from  #tempTBLpCAD ),
	[Last_Updated]= (SELECT Last_Updated from  #tempTBLpCAD ),
--	[Active] = (SELECT IsActive from  #tempTBLpCAD ),
	[IsLinked] = (SELECT IsLinked from  #tempTBLpCAD ),
--	[ClassifierId] = (SELECT ClassifierId from  #tempTBLpCAD ),
--	[SystemId] = (SELECT SystemId from  #tempTBLpCAD ),
	[Model_Code] = (SELECT Model_Code from  #tempTBLpCAD ),
	[Material_Code] = (SELECT Material_Code from  #tempTBLpCAD ),
	[Piece_Description] = (SELECT Piece_Description from  #tempTBLpCAD ),
	[Piece_Category] = (SELECT Piece_Category from  #tempTBLpCAD ),
	[Rule_Table_Name] = (SELECT Rule_Table_Name from  #tempTBLpCAD ),
	[Piece_CrOpId] = (SELECT Piece_CrOpId from  #tempTBLpCAD ),
	[Piece_Create] = (SELECT Piece_Create from  #tempTBLpCAD ),
	[Piece_RevOp1] = (SELECT Piece_RevOp1 from  #tempTBLpCAD ),
	[Piece_Rev1] = (SELECT Piece_Rev1 from  #tempTBLpCAD ),
	[Piece_RevOp2] = (SELECT Piece_RevOp2 from  #tempTBLpCAD ),
	[Piece_Rev2] = (SELECT Piece_Rev2 from  #tempTBLpCAD ),
	[Piece_Message] = (SELECT Piece_Message from  #tempTBLpCAD ),
	[Piece_HPTable] = (SELECT Piece_HPTable from  #tempTBLpCAD ),
	[Piece_Bias] = (SELECT Piece_Bias from  #tempTBLpCAD ),
	[Piece_Flip] = (SELECT Piece_Flip from  #tempTBLpCAD ),
	[Piece_Nap] = (SELECT Piece_Nap from  #tempTBLpCAD ),
	[Piece_Ign_Splice] = (SELECT Piece_Ign_Splice from  #tempTBLpCAD ),
	[Piece_Standard] = (SELECT Piece_Standard from  #tempTBLpCAD ),
	[Piece_Buffering] = (SELECT Piece_Buffering from  #tempTBLpCAD ),
	[Piece_nSplits] = (SELECT Piece_nSplits from  #tempTBLpCAD ),
	[Piece_Tilt_CW] = (SELECT Piece_Tilt_CW from  #tempTBLpCAD ),
	[Piece_DieBlock] = (SELECT Piece_DieBlock from  #tempTBLpCAD ),
	[Piece_Pri_XBlock] = (SELECT Piece_Pri_XBlock from  #tempTBLpCAD ),
	[Piece_Pri_XBlkType] = (SELECT Piece_Pri_XBlkType from  #tempTBLpCAD ),
	[Piece_Pri_YBlock] = (SELECT Piece_Pri_YBlock from  #tempTBLpCAD ),
	[Piece_Pri_YBlkType] = (SELECT Piece_Pri_YBlkType from  #tempTBLpCAD ),
	[Piece_Sec_XBlock] = (SELECT Piece_Sec_XBlock from  #tempTBLpCAD ),
	[Piece_Sec_XBlkType] = (SELECT Piece_Sec_XBlkType from  #tempTBLpCAD ),
	[Piece_Sec_YBlock] = (SELECT Piece_Sec_YBlock from  #tempTBLpCAD ),
	[Piece_Sec_YBlkType] = (SELECT Piece_Sec_YBlkType from  #tempTBLpCAD ),
	[Piece_XVariance] = (SELECT Piece_XVariance from  #tempTBLpCAD ),
	[Piece_XVar_Type] = (SELECT Piece_XVar_Type from  #tempTBLpCAD ),
	[Piece_YVariance] = (SELECT Piece_YVariance from  #tempTBLpCAD ),
	[Piece_YVar_Type] = (SELECT Piece_YVar_Type from  #tempTBLpCAD ),
	[Piece_nUnflipped] = (SELECT Piece_nUnflipped from  #tempTBLpCAD ),
	[Piece_nOpposite] = (SELECT Piece_nOpposite from  #tempTBLpCAD ),
	[Piece_nFilpY] = (SELECT Piece_nFilpY from  #tempTBLpCAD ),
	[Piece_nFlipXY] = (SELECT Piece_nFlipXY from  #tempTBLpCAD ),
	[Piece_IsMirror] = (SELECT Piece_IsMirror from  #tempTBLpCAD ),
	[Piece_Area] = (SELECT Piece_Area from  #tempTBLpCAD ),
	[Piece_Perimeter] = (SELECT Piece_Perimeter from  #tempTBLpCAD ),
	[Piece_PreRotation] = (SELECT Piece_PreRotation from  #tempTBLpCAD ),
	[Piece_Image_SN] = (SELECT Piece_Image_SN from  #tempTBLpCAD ),
	[Piece_Image_Name] = (SELECT Piece_Image_Name from  #tempTBLpCAD ),
--	[Piece_Comments] = (SELECT Piece_Comments from  #tempTBLpCAD ),
--	[UserDefined1] = (SELECT UserDefined1 from  #tempTBLpCAD ),
--	[UserDefined2] = (SELECT UserDefined2 from  #tempTBLpCAD ),
--	[UserDefined3] = (SELECT UserDefined3 from  #tempTBLpCAD ),
--	[UserDefined4] = (SELECT UserDefined4 from  #tempTBLpCAD ),
--	[UserDefined5] = (SELECT UserDefined5 from  #tempTBLpCAD ),
	[Piece_Size] = (SELECT Piece_Size from  #tempTBLpCAD ),
	[Piece_Tilt_CCW] = (SELECT Piece_Tilt_CCW from  #tempTBLpCAD ),
	[Piece_CW_Type] = (SELECT Piece_CW_Type from  #tempTBLpCAD ),
	[Piece_CCW_Type] = (SELECT Piece_CCW_Type from  #tempTBLpCAD ),
	[Piece_PreRotationType] = (SELECT Piece_PreRotationType from  #tempTBLpCAD ),
	[PiecePosition] = (SELECT PiecePosition from  #tempTBLpCAD ),
	[mPiece_Area] = (SELECT mPiece_Area from  #tempTBLpCAD ),
	[mPiece_Perimeter] = (SELECT mPiece_Perimeter from  #tempTBLpCAD )
--	ImageID = (SELECT Piece_Image_SN from  #tempTBLpCAD )
	
Where pBodyPatternSheetPiece.Piece_Code = (select Piece_Code from #tempTblPBody where rownum = @RowCnt)
     
Select @RowCnt = @RowCnt + 1
Drop Table #tempTBLpCAD
END

Drop Table #tempTBLPBody
END


----------------------------------------------------------------
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01246', GetDate())
GO
