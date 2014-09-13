ALTER PROCEDURE [dbo].[spx_StyleBOM_Marker_Summary]
(
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @StyleBOMDimensionId UNIQUEIDENTIFIER         
)
AS

BEGIN    
	CREATE TABLE #tempBOMMarker (
		TableRow INT NOT NULL IDENTITY (0, 1)				 
		, FabricType NVARCHAR(510)	
		, Width FLOAT
		, TotalUsage FLOAT
	)
	
	INSERT #tempBOMMarker
	SELECT
		Marker_Image_Name
		, ROUND(Marker_Width, 4)
		, ROUND((AVG(TotalUsage/36)),4)
	FROM pBodyMarker
	WHERE StyleId = @StyleID
		AND StyleSet = @StyleSet
		AND IsActive = 1
		AND IsForAveraging = 1      
	GROUP BY Marker_Image_Name, Marker_Width

	UPDATE pStyleBOM SET Qty = t.TotalUsage
	FROM pStylebom b INNER JOIN #tempBOMMarker t ON b.z = t.FabricType AND b.width = t.Width
	WHERE b.StyleBOMDimensionID = @StyleBOMDimensionId 

	UPDATE pStyleBOMItem SET MaterialQuantity = t.TotalUsage
	FROM pStylebomitem p
		INNER JOIN pStylebom b ON p.styleMaterialId = b.styleMaterialId AND p.StyleBOMDimensionID = b.StyleBOMDimensionID
		INNER JOIN #tempBOMMarker t	ON b.z = t.FabricType AND b.width = t.Width
	WHERE p.StyleBOMDimensionID = @StyleBOMDimensionId

	DROP TABLE #tempBOMMarker   

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06117', GetDate())
GO
