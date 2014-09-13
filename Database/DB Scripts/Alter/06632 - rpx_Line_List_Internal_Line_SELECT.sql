IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Line_List_Internal_Line_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Line_List_Internal_Line_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Line_List_Internal_Line_SELECT]
	@SeasonYearID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @LineListTypeID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS
BEGIN
	
	IF @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
	
	DECLARE @tmpLineListTypes TABLE (LineListTypeID UNIQUEIDENTIFIER)
	INSERT INTO @tmpLineListTypes VALUES (@LineListTypeID)
	IF @LineListTypeID = '00000000-0000-0000-0000-000000000000'
		INSERT INTO @tmpLineListTypes SELECT LineListTypeID FROM pLineListType WHERE Active = 1
	
	SELECT '(ALL)' AS LineFolderDescription, '00000000-0000-0000-0000-000000000000' AS LineFolderID
	UNION
	SELECT LineFolderDescription, LineFolderID
	FROM pLineFolder lf INNER JOIN @tmpLineListTypes ll ON lf.LineListTypeID = ll.LineListTypeID
	WHERE Active = 1 AND SeasonYearID = @SeasonYearID
	ORDER BY LineFolderDescription
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06632', GetDate())
GO
