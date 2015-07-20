IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BodyMarker_SEL_Imperial]'))
DROP VIEW [dbo].[vwx_BodyMarker_SEL_Imperial]
GO

/****** Object:  View [dbo].[vwx_BodyMarker_SEL_Imperial]    Script Date: 12/01/2011 12:41:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create VIEW [dbo].[vwx_BodyMarker_SEL_Imperial]
AS
SELECT     ID, StyleID, BodyID, Marker_Code, Marker_Name, Location, Last_Updated, IsActive, IsLinkedBF, IsLinked, ROUND(Usage / 36, 4) AS Usage, ROUND(LossFactor / 36, 
                      4) AS LossFactor, ROUND(LossFactor_pct, 4) AS LossFactor_pct, ROUND(TotalUsage / 36, 4) AS TotalUsage, ROUND(AdjustedUsage / 36, 4) AS AdjustedUsage, CUser, 
                      CDate, MDate, MUser, Marker_Description, Marker_CrOpId, Marker_Create, Marker_RevOp1, Marker_Rev1, Marker_RevOp2, Marker_Rev2, ROUND(Marker_Width, 4) 
                      AS Marker_Width, ROUND(Marker_Length / 36, 4) AS Marker_Length, ROUND(Marker_Total_Perim / 36, 4) AS Marker_Total_Perim, ROUND(Marker_Total_Area / 1296, 
                      4) AS Marker_Total_Area, Marker_Goal, ROUND(Marker_Efficiency, 4) AS Marker_Efficiency, Marker_Notches, Marker_Drillholes, Marker_Corners, Marker_Message, 
                      Marker_nModels, Marker_nPieces, Marker_PlacPieces, Marker_nSizes, Marker_nBundles, Marker_Plac_Bndl, Marker_Bias, Marker_Flip, Marker_Nap, 
                      Marker_NCEdits, Marker_Spread, Marker_Closed, Marker_DieBlk, Marker_Tubular, Marker_StripePlaid, Marker_nStripes, Marker_nPlaids, Marker_5_Star, 
                      Marker_Max_Splice, Marker_nSplices, Marker_XVariance, Marker_YVariance, Marker_Image_SN, Marker_Image_Name, CONVERT(nvarchar(300), Marker_Comments) 
                      AS Marker_Comments, CADCatId, Category, SubCat, SubCatType, Class, UserDefined1, UserDefined2, UserDefined3, UserDefined4, UserDefined5, PreferMetric, 
                      IsCosting, IsApproved, Sizes, EfficiencyType, LastCADRefresh, PlotFileLocation, NotchFile, AnnotationFile, StorageType, mMarker_Width, mMarker_Length, 
                      mMarker_Total_Perim, mMarker_Total_Area, Yield_per_Bundle, Yield_per_Dozen, mYield_per_Bundle, mYield_per_Dozen, ImageID, IsForAveraging
FROM         dbo.pBodyMarker

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02264'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02264', GetDate())
END	
GO
