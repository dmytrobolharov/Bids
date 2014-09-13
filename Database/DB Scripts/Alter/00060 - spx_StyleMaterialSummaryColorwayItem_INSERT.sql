IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialSummaryColorwayItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialSummaryColorwayItem_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialSummaryColorwayItem_INSERT]
(
@StyleColorId uniqueidentifier,
@StyleSet int,
@StyleMaterialId uniqueidentifier
)
AS 


IF  (SELECT COUNT(*) FROM pStyleColorwayItem WHERE StyleColorID = @StyleColorId AND StyleMaterialID = @StyleMaterialId
	AND StyleSet = @StyleSet ) = 0
	INSERT INTO pStyleColorwayItem (StyleColorID, StyleMaterialID, StyleID, StyleSet, MaterialID )  
	SELECT @StyleColorID, StyleMaterialID, StyleID, @StyleSet, MaterialID FROM pStyleMaterials WITH (NOLOCK) 
	WHERE  (StyleMaterialID = @StyleMaterialId)

 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '060', GetDate())

GO