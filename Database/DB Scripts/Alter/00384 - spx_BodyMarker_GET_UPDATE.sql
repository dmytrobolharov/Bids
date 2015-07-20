-- Exec [spx_BodyMarker_GET_UPDATE] 'f4b01dca-e14f-43b6-8bd8-326b224b0212', 'Marker_Name'
/****** Object:  StoredProcedure [dbo].[spx_BodyMarker_GET_UPDATE]    Script Date: 09/10/2010 15:09:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_BodyMarker_GET_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_BodyMarker_GET_UPDATE
GO

CREATE PROC  spx_BodyMarker_GET_UPDATE
(
  @BodyID uniqueidentifier,
@strSortOrder varchar(50)
)
AS
BEGIN
declare  @ID uniqueidentifier
declare @Marker_Code int
declare @Sortsql   nvarchar(max)


SELECT ROW_NUMBER() OVER(ORDER BY Marker_Code DESC) AS 'rownum', * 
into #tempTblBody

FROM pBodyMarker where BodyID = @BodyID and IsLinked = 1

declare @RowCnt int
select @RowCnt = 1
declare @MaxRows int
select @MaxRows=count(*) from #tempTblBody

while @RowCnt <= @MaxRows
begin

------------------------------------------------
set @Marker_Code = (select Marker_Code from #tempTblBody where rownum = @RowCnt) 
set @BodyID =  (select BodyID from #tempTblBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblBody where rownum = @RowCnt)

------------------------------------------------

Select *
INTO #tempTBLCAD
FROM Cad_Marker_Details
WHERE  Marker_Code = @Marker_Code 
Declare @Usage1 float
Declare @LossFactor1 float
Declare @pctLossFactor1 float
Declare @TotalUsage1 float
Declare @Length as float
Declare @Marker_Plac_Bndl as int
set @Length = (SELECT [Marker_Length] FROM Cad_Marker_Details
				WHERE  Marker_Code = @Marker_Code)
set @Marker_Plac_Bndl = (SELECT [Marker_Plac_Bndl] FROM Cad_Marker_Details
				WHERE  Marker_Code = @Marker_Code)
Exec [spx_Body_Marker_CALCULATE] 

    @Length, 
    @Marker_Plac_Bndl ,
	@Usage = @Usage1 OUTPUT  ,
	@LossFactor  = @LossFactor1 OUTPUT ,
	@pctLossFactor  = @pctLossFactor1 OUTPUT ,
	@TotalUsage  = @TotalUsage1 OUTPUT  

Update pBodyMarker
SET	 
  
	   [Marker_Code] = (SELECT Marker_Code from  #tempTBLCAD) 
      ,[Marker_Name] = (SELECT Marker_Name from  #tempTBLCAD )
      ,[Location] = (SELECT Location from  #tempTBLCAD )
      ,[Last_Updated] = (SELECT Last_Updated from  #tempTBLCAD )
      ,[IsActive] = 1
      ,[IsLinkedBF] = null
      ,[IsLinked] = 1
       ,Usage = @Usage1
       ,LossFactor = @LossFactor1 
       ,LossFactor_pct = @pctLossFactor1
       ,TotalUsage = @TotalUsage1 
--       ,null as AdjustedUsage
      ,[Marker_Description] = (SELECT Marker_Description from  #tempTBLCAD )
      ,[Marker_CrOpId] = (SELECT Marker_CrOpId from  #tempTBLCAD )
      ,[Marker_Create] = (SELECT Marker_Create from  #tempTBLCAD ) 
      ,[Marker_RevOp1] = (SELECT Marker_RevOp1 from  #tempTBLCAD )
--      ,[CDate] = (SELECT CDate from  #tempTBLCAD )
--      ,[CUser] = (SELECT CUser from  #tempTBLCAD )
--      ,[MDate] = (SELECT MDate from  #tempTBLCAD )
--      ,[MUser] = (SELECT MUser from  #tempTBLCAD )
      ,[Marker_Rev1] = (SELECT Marker_Rev1 from  #tempTBLCAD )
      ,[Marker_RevOp2] = (SELECT Marker_RevOp2 from  #tempTBLCAD )
      ,[Marker_Rev2] = (SELECT Marker_Rev2 from  #tempTBLCAD )
      ,[Marker_Width] = (SELECT Marker_Width from  #tempTBLCAD )
      ,[Marker_Length] = (SELECT Marker_Length from  #tempTBLCAD )
      ,[Marker_Total_Perim] = (SELECT Marker_Total_Perim from  #tempTBLCAD )
      ,[Marker_Total_Area] = (SELECT Marker_Total_Area from  #tempTBLCAD )
      ,[Marker_Goal] = (SELECT Marker_Goal from  #tempTBLCAD )
      ,[Marker_Efficiency] = (SELECT Marker_Efficiency from  #tempTBLCAD )
      ,[Marker_Notches] = (SELECT Marker_Notches from  #tempTBLCAD )
      ,[Marker_Drillholes] = (SELECT Marker_Drillholes from  #tempTBLCAD )
      ,[Marker_Corners] = (SELECT Marker_Corners from  #tempTBLCAD )
      ,[Marker_Message] = (SELECT Marker_Message from  #tempTBLCAD )
      ,[Marker_nModels] = (SELECT Marker_nModels from  #tempTBLCAD )
      ,[Marker_nPieces] = (SELECT Marker_nPieces from  #tempTBLCAD )
      ,[Marker_PlacPieces] = (SELECT Marker_PlacPieces from  #tempTBLCAD )
      ,[Marker_nSizes] = (SELECT Marker_nSizes from  #tempTBLCAD )
      ,[Marker_nBundles] = (SELECT Marker_nBundles from  #tempTBLCAD )
      ,[Marker_Plac_Bndl] = (SELECT Marker_nBundles from  #tempTBLCAD )
      ,[Marker_Bias] = (SELECT Marker_Bias from  #tempTBLCAD )
      ,[Marker_Flip] = (SELECT Marker_Flip from  #tempTBLCAD )
      ,[Marker_Nap] = (SELECT Marker_Nap from  #tempTBLCAD )
      ,[Marker_NCEdits] = (SELECT Marker_NCEdits from  #tempTBLCAD )
      ,[Marker_Spread] = (SELECT Marker_Spread from  #tempTBLCAD )
      ,[Marker_Closed] = (SELECT Marker_Closed from  #tempTBLCAD )
      ,[Marker_DieBlk] = (SELECT Marker_DieBlk from  #tempTBLCAD )
      ,[Marker_Tubular] = (SELECT Marker_Tubular from  #tempTBLCAD )
      ,[Marker_StripePlaid] = (SELECT Marker_StripePlaid from  #tempTBLCAD )
      ,[Marker_nStripes] = (SELECT Marker_nStripes from  #tempTBLCAD )
      ,[Marker_nPlaids] = (SELECT Marker_nPlaids from  #tempTBLCAD )
      ,[Marker_5_Star] = (SELECT Marker_5_Star from  #tempTBLCAD )
      ,[Marker_Max_Splice] = (SELECT Marker_Max_Splice from  #tempTBLCAD )
      ,[Marker_nSplices] = (SELECT Marker_nSplices from  #tempTBLCAD )
      ,[Marker_XVariance] = (SELECT Marker_XVariance from  #tempTBLCAD )
      ,[Marker_YVariance] = (SELECT Marker_YVariance from  #tempTBLCAD )
      ,[Marker_Image_SN] = (SELECT Marker_Image_SN from  #tempTBLCAD )
      ,[Marker_Image_Name] = (SELECT Marker_Image_Name from  #tempTBLCAD )
     -- ,[Marker_Comments] = (SELECT Marker_Comments from  #tempTBLCAD )
      ,[CADCatId] = (SELECT CADCatId from  #tempTBLCAD )
      ,[Category] = (SELECT Category from  #tempTBLCAD )
      ,[SubCat] = (SELECT SubCat from  #tempTBLCAD )
      ,[SubCatType] = (SELECT SubCatType from  #tempTBLCAD )
      ,[Class] = (SELECT Class from  #tempTBLCAD )
--      ,[UserDefined1] = (SELECT UserDefined1 from  #tempTBLCAD )
--      ,[UserDefined2] = (SELECT UserDefined2 from  #tempTBLCAD )
--      ,[UserDefined3] = (SELECT UserDefined3 from  #tempTBLCAD )
--      ,[UserDefined4] = (SELECT UserDefined4 from  #tempTBLCAD )
--      ,[UserDefined5] = (SELECT UserDefined5 from  #tempTBLCAD )
      ,[PreferMetric] = (SELECT PreferMetric from  #tempTBLCAD )
      ,[IsCosting] = (SELECT IsCosting from  #tempTBLCAD )
      ,[IsApproved] = (SELECT IsApproved from  #tempTBLCAD )
      ,[Sizes] = (SELECT Sizes from  #tempTBLCAD )
      ,[EfficiencyType] = (SELECT EfficiencyType from  #tempTBLCAD )
      ,[LastCADRefresh] = (SELECT LastCADRefresh from  #tempTBLCAD )
      ,[PlotFileLocation] = (SELECT PlotFileLocation from  #tempTBLCAD )
      ,[NotchFile] = (SELECT NotchFile from  #tempTBLCAD )
      ,[AnnotationFile] = (SELECT AnnotationFile from  #tempTBLCAD )
      ,[StorageType] = (SELECT StorageType from  #tempTBLCAD )
      ,[mMarker_Width] = (SELECT mMarker_Width from  #tempTBLCAD )
      ,[mMarker_Length] = (SELECT mMarker_Length from  #tempTBLCAD )
      ,[mMarker_Total_Perim] = (SELECT mMarker_Total_Perim from  #tempTBLCAD )
      ,[mMarker_Total_Area] = (SELECT mMarker_Total_Area from  #tempTBLCAD )
      ,[Yield_per_Bundle] = (SELECT Yield_per_Bundle from  #tempTBLCAD )
      ,[Yield_per_Dozen] = (SELECT Yield_per_Dozen from  #tempTBLCAD )
      ,[mYield_per_Bundle] = (SELECT mYield_per_Bundle from  #tempTBLCAD )
      ,[mYield_per_Dozen] = (SELECT mYield_per_Dozen from  #tempTBLCAD )
		
		
Where pBodyMarker.Marker_Code = (select Marker_Code from #tempTblBody where rownum = @RowCnt)
       AND pBodyMarker.BodyID = (select BodyID from #tempTblBody where rownum = @RowCnt)
    Select @RowCnt = @RowCnt + 1



Drop Table #tempTBLCAD
END

Drop Table #tempTblBody

select @Sortsql = 'SELECT [ID]
      ,[BodyID]
      ,[StyleID]
      ,[Marker_Code]
      ,[Marker_Name]
      ,[Location]
      ,[Last_Updated]
      ,[IsActive]
	  ,IsLinkedBF
      ,IsLinked
	  ,Round((Usage/36),4) as Usage
      ,Round((LossFactor/36),4) as LossFactor
	  ,Round(LossFactor_pct,4) as LossFactor_pct
      ,Round((TotalUsage/36),4) as TotalUsage
	  ,AdjustedUsage
	  ,CUser
      ,CDate
      ,MDate
      ,MUser
      ,[IsLinked]
      ,[Marker_Description]
      ,[Marker_CrOpId]
      ,[Marker_Create]
      ,[Marker_RevOp1]
      ,[Marker_Rev1]
      ,[Marker_RevOp2]
      ,[Marker_Rev2]
      ,Round([Marker_Width],4) as Marker_Width
      ,Round(([Marker_Length]/36),4) as [Marker_Length]
      ,Round([Marker_Total_Perim],4) as [Marker_Total_Perim]
      ,Round([Marker_Total_Area],4) as [Marker_Total_Area]
      ,[Marker_Goal]
      ,Round([Marker_Efficiency],4) as [Marker_Efficiency]
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
      ,[mYield_per_Dozen] FROM pBodyMarker  WHERE (BodyID = ' + CHAR(39) + Convert(varchar(36),@BodyID) + CHAR(39) + ' and IsActive = 1 and StyleID is null)' +'order by ' + @strSortOrder 
EXEC(@Sortsql)
END
GO

-------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '384', GetDate())
GO