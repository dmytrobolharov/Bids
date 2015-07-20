
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternSheetPiece_GET_UPDATE]    Script Date: 09/10/2010 15:33:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_BodyPatternSheetPiece_GET_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_BodyPatternSheetPiece_GET_UPDATE
GO

CREATE PROC  spx_BodyPatternSheetPiece_GET_UPDATE
(
--@BodyID uniqueidentifier,
  @Model_Code int
)
AS
declare @RowCnt int
declare @Piece_Code int
declare @MaxRows int

BEGIN

declare  @ID uniqueidentifier

SELECT ROW_NUMBER() OVER(ORDER BY Model_Code DESC) AS 'rownum', * 
into #tempTblPBody
FROM pBodyPatternSheetPiece where Model_Code = @Model_Code -- and BodyID = @BodyID and Linked = 1



select @RowCnt = 1
select @MaxRows=count(*) from #tempTblPBody

while @RowCnt <= @MaxRows
begin

------------------------------------------------
set @Model_Code = (select Model_Code from #tempTblPBody where rownum = @RowCnt) 
--set @BodyID =  (select BodyID from #tempTblPBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblPBody where rownum = @RowCnt)
Set @Piece_Code = (select Piece_Code from #tempTblPBody where rownum = @RowCnt)
------------------------------------------------
SELECT *
INTO #tempTBLpCAD
FROM Cad_Piece_Details
WHERE  Model_Code = @Model_Code and Piece_Code = @Piece_Code

Update pBodyPatternSheetPiece
SET	 
		Model_Code = (SELECT Model_Code from  #tempTBLpCAD) ,
		Piece_Code = (SELECT Piece_Code from  #tempTBLpCAD ) ,
		Piece_Name = (SELECT Piece_Name from  #tempTBLpCAD ) ,
		Piece_Description = (SELECT Piece_Description from  #tempTBLpCAD ),
		Material_Code = (SELECT Material_Code from  #tempTBLpCAD ),
--		Category = (SELECT Category from  #tempTBLpCAD ) ,
		Piece_Flip = (SELECT Piece_Flip from  #tempTBLpCAD),
--		NumberOfXFlip = (SELECT NumberOfXFlip from  #tempTBLpCAD ),
		Piece_nOpposite = (SELECT Piece_nOpposite from  #tempTBLpCAD ),
		Piece_Area = (SELECT Piece_Area from  #tempTBLpCAD ),
		Piece_Perimeter = (SELECT Piece_Perimeter from  #tempTBLpCAD ),
--		HalfPiece = (SELECT HalfPiece from  #tempTBLpCAD ),
		Piece_Bias  = (SELECT Piece_Bias from  #tempTBLpCAD ),
		Piece_Nap = (SELECT Piece_Nap from  #tempTBLpCAD ),
		Piece_XVariance = (SELECT Piece_XVariance from  #tempTBLpCAD ),
		Piece_XVar_Type = (SELECT Piece_XVar_Type from  #tempTBLpCAD ),
		Piece_YVariance = (SELECT Piece_YVariance from  #tempTBLpCAD ),
		Piece_YVar_Type = (SELECT Piece_YVar_Type from  #tempTBLpCAD),
		Piece_Ign_Splice = (SELECT Piece_Ign_Splice from  #tempTBLpCAD),
		Piece_Standard = (SELECT Piece_Standard from  #tempTBLpCAD ),
		Piece_Buffering = (SELECT Piece_Buffering from  #tempTBLpCAD ),

		Piece_nSplits = (SELECT Piece_nSplits from  #tempTBLpCAD),
		Piece_Tilt_CW = (SELECT Piece_Tilt_CW from  #tempTBLpCAD ),
		Piece_CW_Type = (SELECT Piece_CW_Type from  #tempTBLpCAD ),
		Piece_Tilt_CCW = (SELECT Piece_Tilt_CCW from  #tempTBLpCAD),
		Piece_CCW_Type = (SELECT Piece_CCW_Type from  #tempTBLpCAD ),
		Piece_DieBlock = (SELECT Piece_DieBlock from  #tempTBLpCAD ),

		Piece_nFilpY = (SELECT Piece_nFilpY from  #tempTBLpCAD),
		Piece_nFlipXY = (SELECT Piece_nFlipXY from  #tempTBLpCAD ),
		--Mirrored = (SELECT Mirrored from  #tempTBLpCAD ),
		--PiecePreRotation = (SELECT PiecePreRotation from  #tempTBLpCAD),
		Piece_Pri_XBlock  = (SELECT Piece_Pri_XBlock from  #tempTBLpCAD ),
		Piece_Pri_XBlkType = (SELECT Piece_Pri_XBlkType from  #tempTBLpCAD ),

		Piece_Pri_YBlock = (SELECT Piece_Pri_YBlock from  #tempTBLpCAD),
		Piece_Pri_YBlkType = (SELECT Piece_Pri_YBlkType from  #tempTBLpCAD ),
		Piece_Sec_XBlock = (SELECT Piece_Sec_XBlock from  #tempTBLpCAD ),
		Piece_Sec_XBlkType = (SELECT Piece_Sec_XBlkType from  #tempTBLpCAD),
		Piece_Sec_YBlock = (SELECT Piece_Sec_YBlock from  #tempTBLpCAD ),
		Piece_Sec_YBlkType = (SELECT Piece_Sec_YBlkType from  #tempTBLpCAD ),
		Piece_Comments = (SELECT Piece_Comments from  #tempTBLpCAD )
		--ImageID = (SELECT Piece_Image_SN from  #tempTBLpCAD )


		
Where pBodyPatternSheetPiece.Model_Code = (select Model_Code from #tempTblPBody where rownum = @RowCnt)
     
    Select @RowCnt = @RowCnt + 1
Drop Table #tempTBLpCAD
END

Drop Table #tempTBLPBody
END
GO

-------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '387', GetDate())
GO