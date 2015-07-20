/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemSeasonal_INSERT]    Script Date: 08/14/2013 15:15:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemSeasonal_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemSeasonal_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemSeasonal_INSERT]    Script Date: 08/14/2013 15:15:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_LineFolderItemSeasonal_INSERT](
	@StyleID uniqueidentifier,
	@LineFolderItemID uniqueidentifier,
	@LineFolderID uniqueidentifier,
	@CreatedDate datetime,
	@CreatedBy nvarchar(200)
)

AS 

DECLARE @StyleColorID UNIQUEIDENTIFIER

-- add LineFolder season to style if needed
declare @LineFolderSeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID)
if (NOT EXISTS (SELECT * FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @LineFolderSeasonYearID))
	AND @LineFolderSeasonYearID <> '00000000-0000-0000-0000-000000000000'
begin
	declare @Sort INT = (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID)
	exec spx_StyleSeasonYearTrans_INSERT @StyleID, @LineFolderSeasonYearID, @CreatedBy, @CreatedDate, 
										 NULL, NULL, NULL, @Sort
end


declare @StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @LineFolderSeasonYearID)

INSERT INTO dbo.pLineFolderItem (LineFolderItemID , LineFolderID, StyleID, StyleSeasonYearID, CUser, CDate, MUser, MDate) 
VALUES (@LineFolderItemID, @LineFolderID, @StyleID, @StyleSeasonYearID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)



CREATE TABLE #tempColor(
	RecID INT IDENTITY(1,1) NOT NULL,
	StyleColorIDVal UNIQUEIDENTIFIER
) ON [PRIMARY]


INSERT INTO #tempColor(StyleColorIDVal)
SELECT StyleColorwayID FROM pStyleColorwaySeasonYear  WITH (NOLOCK)
WHERE StyleID=@StyleID AND StyleSeasonYearID=@StyleSeasonYearID


DECLARE @ROWCOUNTCOLORS INT
DECLARE @ROWCOUNTCOLORSFINAL INT
DECLARE @tempStyleColorID UNIQUEIDENTIFIER

SET @ROWCOUNTCOLORS = 1
SET @ROWCOUNTCOLORSFINAL = (SELECT COUNT(*) FROM #tempColor)

WHILE @ROWCOUNTCOLORS <= @ROWCOUNTCOLORSFINAL
	BEGIN 
		SELECT @tempStyleColorID = StyleColorIDVal FROM #tempColor where RecID = @ROWCOUNTCOLORS
		exec spx_LineFolderItemColor_INSERT @StyleID, @tempStyleColorID,@LineFolderItemID,@LineFolderID,@CreatedDate,@CreatedBy

		SET @ROWCOUNTCOLORS=@ROWCOUNTCOLORS+1
	END
	
DROP TABLE #tempColor

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06151', GetDate())
GO

