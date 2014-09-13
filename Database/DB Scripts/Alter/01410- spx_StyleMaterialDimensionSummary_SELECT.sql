IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialDimensionSummary_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterialDimensionSummary_SELECT]
GO


CREATE PROCEDURE dbo.spx_StyleMaterialDimensionSummary_SELECT(
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT 
)
AS 


SELECT '<img src="../System/Control/ImageStream.ashx?L=0&Comp=100&S=100&V=' + 
	CAST(a.MaterialImageVersion AS NVARCHAR(10)) + '&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) + '" />' AS ImagePath, a.*
FROM pStyleMaterials a WITH(NOLOCK)
WHERE a.StyleID = @StyleID 
	AND a.StyleSet = @StyleSet
ORDER BY a.MainMaterial DESC, a.MaterialType, a.MaterialSort, a.MaterialNo 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01410', GETDATE())
GO