IF OBJECT_ID(N'[dbo].[spx_StyleMaterial_Replace_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMaterial_Replace_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_StyleMaterial_Replace_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT
)
AS

DECLARE @HeaderLocked INT 
SELECT @HeaderLocked  = HeaderLocked  FROM pStyleHeader WHERE StyleID = @StyleID 


IF @HeaderLocked = 0 
BEGIN 

	SELECT StyleMaterialID,
	CASE 
		WHEN MainMaterial = 1 THEN 'Yes'
		ELSE 'No'
	END AS MainMaterial	,MaterialName, MaterialNo, Placement,
	dbo.fnx_GetStreamingImageHTML(MaterialImageID, MaterialImageVersion, 50, '') AS MaterialImage
	FROM pStyleMaterials 
	WHERE StyleID = @StyleID  AND StyleSet = @StyleSet 
	ORDER BY MainMaterial DESC , MaterialName
END
ELSE
BEGIN 

	SELECT StyleMaterialID,
	CASE 
		WHEN MainMaterial = 1 THEN 'Yes'
		ELSE 'No'
	END AS MainMaterial	,MaterialName, MaterialNo, Placement,
	dbo.fnx_GetStreamingImageHTML(MaterialImageID, MaterialImageVersion, 50, '') AS MaterialImage
	FROM pStyleMaterials 
	WHERE StyleID = @StyleID  AND StyleSet = @StyleSet 
	AND  MainMaterial = 0
	ORDER BY MainMaterial DESC , MaterialName
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10387', GetUTCDate())
GO
