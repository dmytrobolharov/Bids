
/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_Insert]    Script Date: 09/13/2010 14:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_Style_Marker_Insert') and sysstat & 0xf = 4)
    drop procedure spx_Style_Marker_Insert
GO
CREATE procedure spx_Style_Marker_Insert (
@ID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER ,
@Marker_Code int
)
AS

IF not exists  (select * from dbo.pBodyMarker where ID = @ID)

BEGIN
Declare @Linked as int
Set @Linked = 1
Declare @BodyID as UNIQUEIDENTIFIER
Set @BodyID = null

INSERT INTO dbo.pBodyMarker
SELECT @ID as ID,@BodyID as BodyID 
--Eric, if I use 'f2d6a6d3-4367-4308-b113-376f4ac81484' as StyleID instead of "null", it works
	  ,@StyleID as StyleID 
      ,[Marker_Code]
      ,[Marker_Name]
      ,[Location]
      ,[Last_Updated]
      ,[IsActive]
      ,1 as [IsLinked]
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
      ,[Marker_Comments]
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
      ,[mYield_per_Dozen]

FROM Cad_Marker_Details
WHERE  Marker_Code = @Marker_Code
END
GO
----------------------------------------------------------------
----------------------------------------------------------------

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '391', GetDate())
GO