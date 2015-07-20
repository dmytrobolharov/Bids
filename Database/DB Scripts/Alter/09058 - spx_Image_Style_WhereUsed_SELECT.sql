IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_Style_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_Style_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Image_Style_WhereUsed_SELECT]
	@ImageID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
	, @WhereClause NVARCHAR(MAX)
AS
BEGIN
	
		SELECT vsh.*, sh.ImageVersion
		INTO #tmp0
		FROM (
			SELECT StyleID, DesignSketchVersion AS ImageVersion  FROM pStyleHeader
				WHERE DesignSketchID = @ImageID
			UNION SELECT StyleID, DesignSketchBackVersion AS ImageVersion  FROM pStyleHeader
				WHERE DesignSketchBackID = @ImageID
			UNION SELECT StyleID, pStyleMaterials.MaterialImageVersion AS ImageVersion  
				FROM pStyleMaterials
				WHERE pStyleMaterials.MaterialImageID = @ImageID
			UNION SELECT StyleID, pStyleDetailForm.ImageVersion 
				FROM pStyleDetailForm
				WHERE ImageID = @ImageID
			UNION SELECT StyleID, pStyleImageItem.ImageVersion 
				FROM pStyleImageItem
				WHERE ImageID = @ImageID
			UNION SELECT StyleID, pStyleImage.SpecSketchVersion1 
				FROM pStyleImage
				WHERE pStyleImage.SpecSketchID1 = @ImageID
			UNION SELECT StyleID, pStyleImage.SpecSketchVersion2 
				FROM pStyleImage
				WHERE pStyleImage.SpecSketchID2 = @ImageID
			UNION SELECT StyleID, pStyleImage.SpecSketchVersion3 
				FROM pStyleImage
				WHERE pStyleImage.SpecSketchID3 = @ImageID
			UNION SELECT StyleID, pStyleImage.SpecSketchVersion4 
				FROM pStyleImage
				WHERE pStyleImage.SpecSketchID4 = @ImageID
			UNION SELECT StyleID, pStyleImageMeasurements.ImageVersionSet1 
				FROM pStyleImageMeasurements
				WHERE ImageSet1Id = @ImageID
			UNION SELECT StyleID, pStyleImageMeasurements.ImageVersionSet2 
				FROM pStyleImageMeasurements
				WHERE ImageSet2Id = @ImageID
			UNION SELECT StyleID, pStyleImageMeasurements.ImageVersionSet3 
				FROM pStyleImageMeasurements
				WHERE ImageSet3Id = @ImageID
			UNION SELECT StyleID, pStyleImageMeasurements.ImageVersionSet4 
				FROM pStyleImageMeasurements
				WHERE ImageSet4Id = @ImageID				
		) sh
			INNER JOIN vwx_StyleHeader_SEL vsh ON sh.StyleID = vsh.StyleID
			INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) perm ON vsh.StyleType = perm.ProductTypeId
		WHERE (PermissionRoleID = 3 OR PermissionView = 1)
			
		EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
			
		DROP TABLE #tmp0


END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09058', GetDate())
GO
