
IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BodyMarker_SEL_Metric]'))
DROP VIEW [dbo].[vwx_BodyMarker_SEL_Metric]

/****** Object:  View [dbo].[vwx_ColorPalette_SEL]    Script Date: 03/08/2011 10:00:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create VIEW [dbo].[vwx_BodyMarker_SEL_Metric]
AS

SELECT [ID]
      ,[StyleID]
	  ,[BodyID]
      ,[Marker_Code]
      ,[Marker_Name]
      ,[Location]
      ,[Last_Updated]
      ,[IsActive]
	  ,IsLinkedBF
      ,IsLinked
	  ,Round((Usage/36)*0.9144,4) as Usage
      ,Round((LossFactor/36)*0.9144,4) as LossFactor
	  ,Round(LossFactor_pct,4) as LossFactor_pct
      ,Round((TotalUsage/36)*0.9144,4) as TotalUsage
	  ,Round((AdjustedUsage/36)*0.9144,4) as AdjustedUsage
	  ,CUser
      ,CDate
      ,MDate
      ,MUser      
      ,[Marker_Description]
      ,[Marker_CrOpId]
      ,[Marker_Create]
      ,[Marker_RevOp1]
      ,[Marker_Rev1]
      ,[Marker_RevOp2]
      ,[Marker_Rev2]
      ,Round([Marker_Width]*2.54,4) as Marker_Width
      ,Round(([Marker_Length]/36)*0.9144,4) as [Marker_Length]
      ,Round(([Marker_Total_Perim]/36)*0.9144,4) as [Marker_Total_Perim]
      ,Round(([Marker_Total_Area]/1296)*0.8361,4) as [Marker_Total_Area]
      ,[Marker_Goal]
      ,Round([Marker_Efficiency]*2.54,4) as [Marker_Efficiency]
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
      ,[mYield_per_Dozen] 
      ,[ImageId] FROM pBodyMarker 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01234', GetDate())
GO