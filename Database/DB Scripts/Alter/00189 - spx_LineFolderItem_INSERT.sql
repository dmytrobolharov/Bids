IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_INSERT]
GO

CREATE  PROCEDURE [dbo].[spx_LineFolderItem_INSERT]
(@StyleSeasonYearID uniqueidentifier,
@LineFolderItemID uniqueidentifier,
@LineFolderID uniqueidentifier,
@CreatedDate datetime,
@CreatedBy nvarchar(200))
AS 

DECLARE @StyleColorID UNIQUEIDENTIFIER
DECLARE @StyleID UNIQUEIDENTIFIER
SELECT @StyleID = StyleID FROM pStyleSeasonYear WHERE StyleSeasonYearID = @StyleSeasonYearID


INSERT INTO dbo.pLineFolderItem (LineFolderItemID , LineFolderID, StyleID, StyleSeasonYearID, CUser, CDate, MUser, MDate) 
VALUES (@LineFolderItemID, @LineFolderID, @StyleID, @StyleSeasonYearID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)

CREATE TABLE #tempColor
(
	RecID INT IDENTITY(1,1) NOT NULL,
	StyleColorIDVal UNIQUEIDENTIFIER
) ON [PRIMARY]

BEGIN
	INSERT INTO #tempColor(StyleColorIDVal)
	SELECT StyleColorwayID FROM pStyleColorwaySeasonYear  WITH (NOLOCK)
	WHERE StyleID=@StyleID AND StyleSeasonYearID=@StyleSeasonYearID
END

DECLARE @ROWCOUNTCOLORS INT
DECLARE @ROWCOUNTCOLORSFINAL INT
DECLARE @tempStyleColorID UNIQUEIDENTIFIER

SET @ROWCOUNTCOLORS =1

SET @ROWCOUNTCOLORSFINAL=(SELECT COUNT(*) FROM #tempColor)

WHILE @ROWCOUNTCOLORS <= @ROWCOUNTCOLORSFINAL
	BEGIN 
		SELECT @tempStyleColorID= StyleColorIDVal FROM #tempColor where RecID=@ROWCOUNTCOLORS
	  BEGIN
		exec spx_LineFolderItemColor_INSERT @StyleID, @tempStyleColorID,@LineFolderItemID,@LineFolderID,@CreatedDate,@CreatedBy
	  END
		SET @ROWCOUNTCOLORS=@ROWCOUNTCOLORS+1
	END

DROP TABLE #tempColor

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '189', GetDate())

GO