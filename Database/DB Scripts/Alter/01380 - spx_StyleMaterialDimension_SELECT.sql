IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialDimension_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterialDimension_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialDimension_SELECT](
	@StyleID varchar(255), 	
	@StyleSet INT
)
AS 

SELECT StyleMaterialID, MaterialNo, MaterialName, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, 
	MaterialSizeA3, MaterialSizeA4, MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, MaterialSizeA11, 
	MaterialSizeA12, MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
	MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, 
	MaterialSizeB9, MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, 
	MaterialSizeB17, MaterialSizeB18, MaterialSizeB19
FROM pStyleMaterials WITH (NOLOCK)
WHERE StyleSet = @StyleSet
	AND StyleID = @StyleID
	AND MaterialDimension = 1
ORDER BY MaterialNo, MaterialSize



GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01380', GETDATE())
GO