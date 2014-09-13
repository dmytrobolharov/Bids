IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImageItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleImageItem_DELETE]
(@StyleImageItemID uniqueidentifier)
AS 

-- check if it is image from Text-Form bubble (table pStyleDetailForm)
IF EXISTS (SELECT * FROM pStyleDetailForm WHERE StyleDetailFormID = @StyleImageItemID)
BEGIN
	DELETE FROM pStyleDetailForm WHERE StyleDetailFormID = @StyleImageItemID
END
ELSE -- other bubbles: Design Detail, Design Detail Custom, etc (table pStyleImageItem)
BEGIN

	DECLARE @StyleImageItemMasterId uniqueidentifier
	SELECT @StyleImageItemMasterId = StyleImageItemMasterId FROM pStyleImageItem WITH (NOLOCK) WHERE StyleImageItemId  = @StyleImageItemId 

	DELETE FROM pStyleImageItem WHERE (StyleImageItemMasterId = @StyleImageItemMasterId)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03687', GetDate())
GO