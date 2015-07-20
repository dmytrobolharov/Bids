
/****** Object:  StoredProcedure [dbo].[spx_StyleMarker_GET_UPDATE]    Script Date: 09/14/2010 09:43:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMarker_GET_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_StyleMarker_GET_UPDATE
GO
CREATE PROC  spx_StyleMarker_GET_UPDATE
(
  @StyleID uniqueidentifier,
@strSortOrder varchar(50)
)
AS


BEGIN



declare  @ID uniqueidentifier
declare @Marker_Code int
declare @Sortsql   nvarchar(max)


SELECT ROW_NUMBER() OVER(ORDER BY Marker_Code DESC) AS 'rownum', * 
into #tempTblBody

FROM pBodyMarker where StyleID = @StyleID and IsLinked = 1

declare @RowCnt int
select @RowCnt = 1
declare @MaxRows int
select @MaxRows=count(*) from #tempTblBody

while @RowCnt <= @MaxRows
begin

------------------------------------------------
set @Marker_Code = (select Marker_Code from #tempTblBody where rownum = @RowCnt) 
set @StyleID =  (select StyleID from #tempTblBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblBody where rownum = @RowCnt)

------------------------------------------------

Select *
INTO #tempTBLCAD
FROM Cad_Marker_Details
WHERE  Marker_Code = @Marker_Code 

Update pBodyMarker
SET	 
		Marker_Code = (SELECT Marker_Code from  #tempTBLCAD) ,
		Marker_Name = (SELECT Marker_Name from  #tempTBLCAD ) ,
		Marker_Description = (SELECT Marker_Description from  #tempTBLCAD ) ,
		Marker_Create = (SELECT Marker_Create from  #tempTBLCAD ),
        --IsActive= 1,
		IsLinked = 1,
		Category = (SELECT Category from  #tempTBLCAD ) ,
		Marker_Width = (SELECT Marker_Width from  #tempTBLCAD ),
		Marker_Length = (SELECT Marker_Length from  #tempTBLCAD ),
		Marker_Comments = (SELECT Marker_Comments from  #tempTBLCAD ),
		Marker_nSizes = (SELECT Marker_nSizes from  #tempTBLCAD ),
		--MadeToMeasure = (SELECT Model_MTMFile from  #tempTBLCAD ),
		Marker_Total_Perim = (SELECT Marker_Total_Perim from  #tempTBLCAD ),
		Marker_Goal  = (SELECT Marker_Goal from  #tempTBLCAD ),
		Marker_Total_Area  = (SELECT Marker_Total_Area from  #tempTBLCAD ),
--		CategoryPath = (SELECT CategoryPath from  #tempTBLCAD ),
--		CUser = (SELECT CUser from  #tempTBLCAD ),
--		CDate  = (SELECT CDate from  #tempTBLCAD ),
		Sizes = (SELECT Sizes from  #tempTBLCAD ),
		Marker_Efficiency = (SELECT Marker_Efficiency from  #tempTBLCAD),
		EfficiencyType = (SELECT EfficiencyType from  #tempTBLCAD ),
		Marker_Notches = (SELECT Marker_Notches from  #tempTBLCAD ),
		Marker_Corners = (SELECT Marker_Corners from  #tempTBLCAD )
		
		
Where pBodyMarker.Marker_Code = (select Marker_Code from #tempTblBody where rownum = @RowCnt)
       AND pBodyMarker.StyleID = (select StyleID from #tempTblBody where rownum = @RowCnt)
    Select @RowCnt = @RowCnt + 1



Drop Table #tempTBLCAD
END

Drop Table #tempTblBody

select @Sortsql = 'SELECT [ID]
      ,[StyleID]
      ,[BodyID]
      ,[Marker_Code]
      ,[Marker_Name]
      ,[Location]
      ,[Last_Updated]
      ,[IsActive]
      ,[IsLinked]
      ,[Marker_Description]
      ,[Marker_CrOpId]
      ,[Marker_Create]
      ,[Marker_RevOp1]
      ,[Marker_Rev1]
      ,[Marker_RevOp2]
      ,[Marker_Rev2]
      ,[Marker_Width]
      ,[Marker_Length]
      ,[Marker_Total_Perim]
      ,[Marker_Total_Area]
      ,[Marker_Goal]
      ,[Marker_Efficiency]
      ,[Marker_Notches]
      ,[Marker_Drillholes]
      ,[Marker_Corners]
      ,[Marker_Message]
      ,[Marker_nModels]
      ,[Marker_nPieces]
      ,[Marker_PlacPieces]
      ,[Marker_nSizes]
      ,[Marker_nBundles]
      ,[Marker_Plac_Bndl]
      ,[Marker_Bias]
      ,[Marker_Flip]
      ,[Marker_Nap]
      ,[Marker_NCEdits]
      ,[Marker_Spread]
      ,[Marker_Closed]
      ,[Marker_DieBlk]
      ,[Marker_Tubular]
      ,[Marker_StripePlaid]
      ,[Marker_nStripes]
      ,[Marker_nPlaids]
      ,[Marker_5_Star]
      ,[Marker_Max_Splice]
      ,[Marker_nSplices]
      ,[Marker_XVariance]
      ,[Marker_YVariance]
      ,[Marker_Image_SN]
      ,[Marker_Image_Name]
      ,convert (varchar(300),Marker_Comments) as [Marker_Comments]
      ,[CADCatId]
      ,[Category]
      ,[SubCat]
      ,[SubCatType]
      ,[Class]
      ,[UserDefined1]
      ,[UserDefined2]
      ,[UserDefined3]
      ,[UserDefined4]
      ,[UserDefined5]
      ,[PreferMetric]
      ,[IsCosting]
      ,[IsApproved]
      ,[Sizes]
      ,[EfficiencyType]
      ,[LastCADRefresh]
      ,[PlotFileLocation]
      ,[NotchFile]
      ,[AnnotationFile]
      ,[StorageType]
      ,[mMarker_Width]
      ,[mMarker_Length]
      ,[mMarker_Total_Perim]
      ,[mMarker_Total_Area]
      ,[Yield_per_Bundle]
      ,[Yield_per_Dozen]
      ,[mYield_per_Bundle]
      ,[mYield_per_Dozen] FROM pBodyMarker  WHERE (StyleID = ' + CHAR(39) + Convert(varchar(36),@StyleID) + CHAR(39) + ')' +'order by ' + @strSortOrder
EXEC(@Sortsql)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '389', GetDate())
GO