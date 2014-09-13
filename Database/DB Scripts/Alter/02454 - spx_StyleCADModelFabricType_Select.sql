
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCADModelFabricType_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCADModelFabricType_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleCADModelFabricType_Select]
	@StyleId UNIQUEIDENTIFIER,
	@StyleSet INT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT DISTINCT p.Piece_Image_Name as FabricType, m.Model_Name, m.ID FROM pBodyPatternSheetPiece p
	LEFT JOIN pBodyPatternSheetModel m ON p.ModelID = m.ID 
	WHERE m.StyleID = @StyleId AND m.StyleSet = @StyleSet
	AND m.Active = 1 AND p.Active = 1
	ORDER BY m.Model_Name

END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02454'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02454', GetDate())

END

GO