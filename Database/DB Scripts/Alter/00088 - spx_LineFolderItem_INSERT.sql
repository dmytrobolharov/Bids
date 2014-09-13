
ALTER  PROCEDURE [dbo].[spx_LineFolderItem_INSERT]
(@StyleSeasonYearID uniqueidentifier,
@LineFolderItemID uniqueidentifier,
@LineFolderID uniqueidentifier,
@CreatedDate datetime,
@CreatedBy nvarchar(200))
AS 

DECLARE @StyleID UNIQUEIDENTIFIER
SELECT @StyleID = StyleID FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID


INSERT INTO dbo.pLineFolderItem (LineFolderItemID , LineFolderID, StyleID, StyleSeasonYearID, CUser, CDate, MUser, MDate) 
VALUES (@LineFolderItemID, @LineFolderID, @StyleID, @StyleSeasonYearID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '086', GetDate())

GO
