IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKUHeader_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKUHeader_Info_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSKUHeader_Info_SELECT]
	@StyleSKUItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT skut.*, skui.StyleSKUItemID FROM pStyleSKUTemplate skut
    INNER JOIN pStyleSKUItem skui ON skut.StyleSKUTemplateID = skui.StyleSKUTemplateID
    WHERE skui.StyleSKUItemID = @StyleSKUItemID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08342', GetDate())
GO