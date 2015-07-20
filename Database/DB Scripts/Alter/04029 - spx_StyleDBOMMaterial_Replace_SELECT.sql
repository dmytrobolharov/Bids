

/****** Object:  StoredProcedure [dbo].[spx_StyleDBOMMaterial_Replace_SELECT]    Script Date: 09/28/2012 16:27:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDBOMMaterial_Replace_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDBOMMaterial_Replace_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleDBOMMaterial_Replace_SELECT]    Script Date: 09/28/2012 16:27:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE  [dbo].[spx_StyleDBOMMaterial_Replace_SELECT](
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@StyleBOMDimensionId UNIQUEIDENTIFIER
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
	'<img src="../System/Control/ImageStream.ashx?S=50&V=' + CAST(MaterialImageVersion AS NVARCHAR(5)) + 
	'&IID=' + CAST( ISNULL(MaterialImageID,'00000000-0000-0000-0000-000000000000' ) AS NVARCHAR(40))  + '" /> '
	AS MaterialImage
	FROM pStyleBOM 
	WHERE StyleBOMDimensionId=@StyleBOMDimensionId  
	ORDER BY MainMaterial DESC , MaterialName
END
ELSE
BEGIN 

	SELECT StyleMaterialID,
	CASE 
		WHEN MainMaterial = 1 THEN 'Yes'
		ELSE 'No'
	END AS MainMaterial	,MaterialName, MaterialNo, Placement,
	'<img src="../System/Control/ImageStream.ashx?S=50&V=' + CAST(MaterialImageVersion AS NVARCHAR(5)) + 
	'&IID=' + CAST( ISNULL(MaterialImageID,'00000000-0000-0000-0000-000000000000' ) AS NVARCHAR(40))  + '" /> '
	AS MaterialImage
	FROM pStyleBOM 
	WHERE StyleBOMDimensionId=@StyleBOMDimensionId   
	AND  MainMaterial = 0
	ORDER BY MainMaterial DESC , MaterialName
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04029', GetDate())
GO