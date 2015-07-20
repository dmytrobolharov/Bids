IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColorDrop_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColorDrop_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItemColorDrop_UPDATE]
(
@LineFolderItemID uniqueidentifier,
@LineFolderID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleID uniqueidentifier,
@DropStatus nvarchar(1),
@DropBy nvarchar(200),
@DropDate datetime
)
AS 

IF @DropStatus = 1 
	BEGIN
		UPDATE pLineFolderItemColor
		SET  LineFolderItemColorDrop = '1', 
			LineFolderItemColorDropUser = @DropBy, 
			LineFolderItemColorDropDate = @DropDate,
			MUser = @DropBy, MDate = @DropDate
		WHERE 
			(LineFolderItemID = @LineFolderItemID) AND 
			(LineFolderID = @LineFolderID) AND 
			(StyleColorID = @StyleColorID) AND 
			(StyleID = @StyleID)
	END
ELSE
	BEGIN
		UPDATE pLineFolderItemColor
		SET  LineFolderItemColorDrop = '0', 
			LineFolderItemColorDropUser = NULL, 
			LineFolderItemColorDropDate = NULL,
			MUser = @DropBy, MDate = @DropDate
		WHERE	
			(LineFolderItemID = @LineFolderItemID) AND 
			(LineFolderID = @LineFolderID) AND 
			(StyleColorID = @StyleColorID) AND 
			(StyleID = @StyleID)
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07310', GetDate())
GO
