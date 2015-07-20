IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Copy_StyleModel_MaterialAssociations_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Copy_StyleModel_MaterialAssociations_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Copy_StyleModel_MaterialAssociations_INSERT]
(
	@OldStyleID UNIQUEIDENTIFIER
	, @NewStyleID UNIQUEIDENTIFIER
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
)
AS

BEGIN

	INSERT INTO pCADModel2BOM (ModelId, MaterialId, FabricType, StyleId, StyleSet, CUser, CDate)
	SELECT bpsm.ID, b.StyleMaterialID, a.FabricType, @NewStyleID, a.StyleSet, @CUser, @CDate
	FROM pCADModel2BOM a 
		INNER JOIN pStyleBOM b ON a.MaterialId = b.CopyStyleMaterialID
		INNER JOIN pBodyPatternSheetModel bpsm ON b.StyleID = bpsm.StyleID
		INNER JOIN pBodyPatternSheetModel bpsm2 ON bpsm.Model_Code = bpsm2.Model_Code AND a.ModelId = bpsm2.ID
	WHERE bpsm2.StyleID = @OldStyleID AND bpsm.StyleID = @NewStyleID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09162', GetDate())
GO
