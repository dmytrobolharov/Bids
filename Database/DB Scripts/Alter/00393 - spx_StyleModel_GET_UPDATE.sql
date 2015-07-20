/****** Object:  StoredProcedure [dbo].[spx_StyleModel_GET_UPDATE]    Script Date: 09/15/2010 21:22:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_StyleModel_GET_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleModel_GET_UPDATE
GO

CREATE PROC  spx_StyleModel_GET_UPDATE
(
  @StyleID uniqueidentifier,
@strSortOrder varchar(50)
)
AS

BEGIN

declare  @ID uniqueidentifier
declare @Model_Code int
declare @Sortsql   nvarchar(max)

SELECT ROW_NUMBER() OVER(ORDER BY Model_Code DESC) AS 'rownum', * 
into #tempTblBody

FROM pBodyPatternSheetModel where StyleID = @StyleID and IsLinked = 1

declare @RowCnt int
select @RowCnt = 1
declare @MaxRows int
select @MaxRows=count(*) from #tempTblBody

while @RowCnt <= @MaxRows
begin

------------------------------------------------
set @Model_Code = (select Model_Code from #tempTblBody where rownum = @RowCnt) 
set @StyleID =  (select StyleID from #tempTblBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblBody where rownum = @RowCnt)

------------------------------------------------

Select *
INTO #tempTBLCAD
FROM Cad_Model_Details
WHERE  Model_Code = @Model_Code

Update pBodyPatternSheetModel
SET	 
		Model_Code = (SELECT Model_Code from  #tempTBLCAD) ,
		Model_Name = (SELECT Model_Name from  #tempTBLCAD ) ,
		Model_Description = (SELECT Model_Description from  #tempTBLCAD ) ,
		Model_SampleSize = (SELECT Model_SampleSize from  #tempTBLCAD ),
		Active= 1,
		IsLinked = 1,
		Model_nSizes = (SELECT Model_nSizes from  #tempTBLCAD ) ,
		Model_nMaterials = (SELECT Model_nMaterials from  #tempTBLCAD ),
		Model_nPieces = (SELECT Model_nPieces from  #tempTBLCAD ),
		Model_Comments = (SELECT Model_Comments from  #tempTBLCAD ),
		Model_GRTable = (SELECT Model_GRTable from  #tempTBLCAD ),
		--MadeToMeasure = (SELECT Model_MTMFile from  #tempTBLCAD ),
		Model_SAName = (SELECT Model_SAName from  #tempTBLCAD ),
		Model_SYNTable  = (SELECT Model_SYNTable from  #tempTBLCAD ),
		Model_HPTable  = (SELECT Model_HPTable from  #tempTBLCAD ),
--		CategoryPath = (SELECT CategoryPath from  #tempTBLCAD ),
--		CUser = (SELECT CUser from  #tempTBLCAD ),
--		CDate  = (SELECT CDate from  #tempTBLCAD ),
		Model_Rev1 = (SELECT Model_Rev1 from  #tempTBLCAD ),
		Model_RevOp1 = (SELECT Model_RevOp1 from  #tempTBLCAD),
		Model_Rev2 = (SELECT Model_Rev2 from  #tempTBLCAD ),
		Model_RevOp2 = (SELECT Model_RevOp2 from  #tempTBLCAD )

		
Where pBodyPatternSheetModel.Model_Code = (select Model_Code from #tempTblBody where rownum = @RowCnt)
       AND pBodyPatternSheetModel.StyleID = (select StyleID from #tempTblBody where rownum = @RowCnt)
    Select @RowCnt = @RowCnt + 1

EXEC [spx_BodyPatternSheetPiece_GET_UPDATE]  @Model_Code -- @BodyID ,

Drop Table #tempTBLCAD
END

Drop Table #tempTblBody

select @Sortsql = 'SELECT 	[ID] ,
	[BodyID],
	[StyleID],
	[Model_Code],
	[Model_Name],
	[Last_Updated],
	[Active],
	[IsLinked],
	[Marker_Code],
	[Model_Description],
	[Model_CrOpId],
	[Model_Create],
	[Model_RevOp1],
	[Model_Rev1],
	[Model_RevOp2],
	[Model_Rev2],
	[Model_GRTable],
	[Model_MTMFile],
	[Model_SAName],
	[Model_SYNTable],
	[Model_HPTable],
	[Model_SampleSize],
	[Model_nMaterials],
	[Model_nPieces],
	[Model_nSizes],
	[Model_Image_SN],
	[Model_Image_Name],
	convert (varchar(300),Model_Comments) as Model_Comments,
	[PreferMetric],
	[UserDefined1],
	[UserDefined2],
	[UserDefined3],
	[UserDefined4],
	[UserDefined5],
	[Total_Area],
	[LastCADRefresh],
	[PlotFileLocation],
	[NotchFile],
	[AnnotationFile],
	[StorageType] FROM pBodyPatternSheetModel   WHERE (StyleID = ' + CHAR(39) + Convert(varchar(36),@StyleID) + CHAR(39) + ')' +'order by ' + @strSortOrder
EXEC(@Sortsql)
END
GO

------------------------
-------------------
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '393', GetDate())
GO