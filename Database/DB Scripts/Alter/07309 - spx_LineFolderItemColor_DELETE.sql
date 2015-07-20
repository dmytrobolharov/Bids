IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColor_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItemColor_DELETE]
(
@LineFolderItemID uniqueidentifier,
@LineFolderID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleID uniqueidentifier
)
AS 
BEGIN
	DELETE FROM pLineFolderItemColor WHERE 
	LineFolderItemID = @LineFolderItemID AND 
	StyleColorID = @StyleColorID AND
	StyleID = @StyleID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07309', GetDate())
GO
