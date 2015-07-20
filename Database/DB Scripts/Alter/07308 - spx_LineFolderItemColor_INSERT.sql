IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColor_INSERT]
GO


CREATE  PROCEDURE [dbo].[spx_LineFolderItemColor_INSERT]
(@StyleID uniqueidentifier,
@StyleColorID uniqueidentifier,
@LineFolderItemID uniqueidentifier,
@LineFolderID uniqueidentifier,
@ModifiedDate datetime,
@ModifiedBy nvarchar(200))
AS 
BEGIN
	INSERT INTO dbo.pLineFolderItemColor
						  (LineFolderItemID, LineFolderID, StyleColorID, StyleID, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, 
						  MDate, MUser, LineFolderItemColorDrop)
	SELECT     @LineFolderItemID, @LineFolderID, StyleColorID, StyleID, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, 
						  CUser, @ModifiedDate, @ModifiedBy, 0 AS LineFolderItemColorDrop
	FROM         dbo.pStyleColorway WITH (NOLOCK) 
	WHERE     (StyleID = @StyleID) AND  (StyleColorID = @StyleColorID)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07308', GetDate())
GO
