/****** Object:  StoredProcedure [dbo].[spx_MaterialColorTemp_DELETE]    Script Date: 05/21/2013 12:06:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialColorTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialColorTemp_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialColorTemp_DELETE]
	@MaterialID UNIQUEIDENTIFIER,
	@ColorPaletteID	UNIQUEIDENTIFIER	
AS
BEGIN
	DELETE FROM tmpMaterialColor WHERE MaterialID = @MaterialID AND ColorPaletteID = @ColorPaletteID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05714', GetDate())
GO
