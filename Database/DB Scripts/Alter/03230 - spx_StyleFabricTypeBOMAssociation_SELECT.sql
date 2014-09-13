/****** Object:  StoredProcedure [dbo].[spx_StyleFabricTypeBOMAssociation_SELECT]    Script Date: 03/14/2012 15:09:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFabricTypeBOMAssociation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFabricTypeBOMAssociation_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleFabricTypeBOMAssociation_SELECT]    Script Date: 03/14/2012 15:09:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleFabricTypeBOMAssociation_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ModelID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @ModelID IS NULL
	BEGIN
		-- select all style associations
		SELECT c.*, p.Model_Name as ModelName FROM pCADModel2BOM c
		LEFT JOIN pBodyPatternSheetModel p ON c.ModelId = p.Id
		WHERE c.StyleId = @StyleID AND c.StyleSet = @StyleSet
		ORDER BY ModelName, c.FabricType
	END
	ELSE
	BEGIN
		-- select associations for specific model
		SELECT c.*, p.Model_Name as ModelName FROM pCADModel2BOM c
		LEFT JOIN pBodyPatternSheetModel p ON c.ModelId = p.Id
		WHERE c.StyleId = @StyleID AND c.StyleSet = @StyleSet AND c.ModelId = @ModelID
		ORDER BY ModelName, c.FabricType
	END
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03230'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03230', GetDate())

END

GO 