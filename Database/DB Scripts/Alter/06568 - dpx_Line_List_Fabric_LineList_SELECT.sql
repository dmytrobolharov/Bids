IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Line_List_Fabric_LineList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Line_List_Fabric_LineList_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Line_List_Fabric_LineList_SELECT]
	@SeasonYearID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
	
	SELECT '(ALL)' AS LineFolderDescription, '00000000-0000-0000-0000-000000000000' AS LineFolderID
	UNION
	SELECT LineFolderDescription, LineFolderID
	FROM pLineFolder
	WHERE Active = 1 AND SeasonYearID = @SeasonYearID
	ORDER BY LineFolderDescription
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06568', GetDate())
GO
