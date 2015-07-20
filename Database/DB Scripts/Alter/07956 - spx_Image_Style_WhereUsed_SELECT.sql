IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_Style_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_Style_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Image_Style_WhereUsed_SELECT]
	@ImageID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
	, @WhereClause NVARCHAR(MAX)
AS
BEGIN
	
		SELECT * 
		INTO #tmp0
		FROM (
			SELECT *, DesignSketchVersion AS ImageVersion  FROM vwx_StyleHeader_SEL
				WHERE DesignSketchID = @ImageID
			UNION SELECT *, DesignSketchBackVersion AS ImageVersion  FROM vwx_StyleHeader_SEL
				WHERE DesignSketchBackID = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleMaterials.MaterialImageVersion AS ImageVersion  FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleMaterials ON vwx_StyleHeader_SEL.StyleID = pStyleMaterials.StyleID 
				WHERE pStyleMaterials.MaterialImageID = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleDetailForm.ImageVersion FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleDetailForm ON vwx_StyleHeader_SEL.StyleID = pStyleDetailForm.StyleID 
				WHERE ImageID = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImageItem.ImageVersion FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImageItem ON vwx_StyleHeader_SEL.StyleID = pStyleImageItem.StyleID 
				WHERE ImageID = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImage.SpecSketchVersion1 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImage ON vwx_StyleHeader_SEL.StyleID = pStyleImage.StyleID 
				WHERE pStyleImage.SpecSketchID1 = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImage.SpecSketchVersion2 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImage ON vwx_StyleHeader_SEL.StyleID = pStyleImage.StyleID 
				WHERE pStyleImage.SpecSketchID2 = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImage.SpecSketchVersion3 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImage ON vwx_StyleHeader_SEL.StyleID = pStyleImage.StyleID 
				WHERE pStyleImage.SpecSketchID3 = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImage.SpecSketchVersion4 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImage ON vwx_StyleHeader_SEL.StyleID = pStyleImage.StyleID 
				WHERE pStyleImage.SpecSketchID4 = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImageMeasurements.ImageVersionSet1 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImageMeasurements ON vwx_StyleHeader_SEL.StyleID = pStyleImageMeasurements.StyleID
				WHERE ImageSet1Id = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImageMeasurements.ImageVersionSet2 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImageMeasurements ON vwx_StyleHeader_SEL.StyleID = pStyleImageMeasurements.StyleID
				WHERE ImageSet2Id = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImageMeasurements.ImageVersionSet3 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImageMeasurements ON vwx_StyleHeader_SEL.StyleID = pStyleImageMeasurements.StyleID
				WHERE ImageSet3Id = @ImageID
			UNION SELECT vwx_StyleHeader_SEL.*, pStyleImageMeasurements.ImageVersionSet4 FROM vwx_StyleHeader_SEL
				LEFT JOIN pStyleImageMeasurements ON vwx_StyleHeader_SEL.StyleID = pStyleImageMeasurements.StyleID
				WHERE ImageSet4Id = @ImageID				
		) sh
			INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) perm ON sh.StyleType = perm.ProductTypeId
		WHERE (PermissionRoleID = 3 OR PermissionView = 1)
			
		EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
			
		DROP TABLE #tmp0


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07956', GetDate())
GO
