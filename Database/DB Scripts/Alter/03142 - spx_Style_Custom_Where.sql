IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Custom_Where]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Custom_Where]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_Style_Custom_Where](
@MaterialID uniqueidentifier,
@MaterialVersion int,
@TeamID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER = null,
@StyleSet int,
@FieldSeason varchar (100), 
@FieldYear varchar (100)

)

AS 

	SELECT top 1 c.*  FROM pCADModel2BOM c 
	inner JOIN pStyleBOM p ON c.MaterialId = p.StyleMaterialID 
	WHERE c.StyleId = @StyleId AND c.StyleSet = @StyleSet
	AND p.MaterialId = @MaterialID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03142'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03142', GetDate())

END
GO

