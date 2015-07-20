IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Marker_2x0_Imperial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Marker_2x0_Imperial_SELECT]
GO


CREATE PROCEDURE rpx_Style_Marker_2x0_Imperial_SELECT
(
	@StyleId NVARCHAR(50)
)
AS


/*Create temp table.*/
CREATE TABLE #tempMain
(
	TableRow INT IDENTITY(0,1)
	,MarkerName NVARCHAR(100)
	,MaterialGroup NVARCHAR(550)
	,NoOfSizes INT
	,Sizes NVARCHAR(4000)
	,OrderedBundles INT
	,PlacedBundles INT
	,[Description] NVARCHAR (550)
	,Width NVARCHAR(20)					--Show in inches.
	,[Length] NVARCHAR(20)				--Show in yards.
	,Bias INT
	,Flip INT
	,Nap INT
	,Efficiency NVARCHAR(20)
	,LossFactor NVARCHAR(20)
	,Usage NVARCHAR(20)					--Show in yards.
	,TotalUsage NVARCHAR(20)			--Show in yards.
	,AdjustedUsage NVARCHAR(20)			--Show in yards.
	,TotalPerimeter NVARCHAR(20)		--Show in yards.
	,TotalArea NVARCHAR(20)				--Show in square yards.
	,Comments NVARCHAR(300)
	,ImageFilePath NVARCHAR(255)
)


/*Get records.*/
INSERT INTO #tempMain
(
	MarkerName
	,MaterialGroup
	,NoOfSizes
	,Sizes
	,OrderedBundles
	,PlacedBundles
	,[Description]
	,Width
	,[Length]
	,Bias
	,Flip
	,Nap
	,Efficiency
	,LossFactor
	,Usage
	,TotalUsage
	,AdjustedUsage
	,TotalPerimeter
	,TotalArea
	,Comments
	,ImageFilePath
)
SELECT
	Marker_Name
	,Marker_Image_Name
	,Marker_nSizes AS NoOfSizes
	,Sizes
	,Marker_nBundles AS OrderedBundles
	,Marker_Plac_Bndl AS PlacedBundles
	,Marker_Description AS [Description]
	,ISNULL(CAST(ROUND(Marker_Width, 4) AS NVARCHAR(20)), '') + ' IN' AS Width
	,ISNULL(CAST(ROUND(Marker_Length / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS [Length]
	,Marker_Bias AS Bias
	,Marker_Flip AS Flip
	,Marker_Nap AS Nap
	,ISNULL(CAST(ROUND(Marker_Efficiency, 4) AS NVARCHAR(20)), '') AS Efficiency
	,ISNULL(CAST(ROUND(LossFactor_pct, 4) AS NVARCHAR(20)), '') AS LossFactor
	,ISNULL(CAST(ROUND(Usage / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS Usage
	,ISNULL(CAST(ROUND(TotalUsage / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS TotalUsage
	,ISNULL(CAST(ROUND(AdjustedUsage / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS AdjustedUsage
	,ISNULL(CAST(ROUND(Marker_Total_Perim / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS TotalPerimeter
	,ISNULL(CAST(ROUND(Marker_Total_Area / 1296, 4) AS NVARCHAR(20)), '') + ' SQ YD' AS TotalArea
	,REPLACE(REPLACE(CAST(Marker_Comments AS NVARCHAR(300)), CHAR(13), ' '), CHAR(10), '') AS Comments
	,dbo.fnx_GetStreamingImageCADStyleMarkerPath(StyleId, Id) AS ImageFilePath
FROM pBodyMarker
WHERE StyleId = @StyleId
ORDER BY MDate DESC


/*Final select.*/
SELECT
	TableRow / 2 AS Row
	,TableRow % 2 AS [Column]
	,*
FROM #tempMain
ORDER BY TableRow


/*Drop temp table.*/
DROP TABLE #tempMain
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01375', GetDate())
GO