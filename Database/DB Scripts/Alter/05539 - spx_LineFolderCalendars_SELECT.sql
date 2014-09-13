/****** Object:  StoredProcedure [dbo].[spx_LineFolderCalendars_SELECT]    Script Date: 04/11/2013 14:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderCalendars_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderCalendars_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderCalendars_SELECT]    Script Date: 04/11/2013 14:00:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderCalendars_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @DivisionID UNIQUEIDENTIFIER
	SELECT @DivisionID = LineFolderDivisionID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	SELECT DISTINCT ch.CalendarHeaderID, ch.CalendarName, IsChecked =
	CASE 
	WHEN clf.CalendarHeaderID IS NULL THEN 
		'FALSE' 
	ELSE 
		'TRUE'
	END
	FROM pCalendarHeader ch
    INNER JOIN pCalendarHeaderToDivision chtd ON ch.CalendarHeaderID = chtd.CalendarHeaderID
    LEFT JOIN pCalendarLineFolder clf ON clf.CalendarHeaderID = ch.CalendarHeaderID AND clf.LineFolderID = @LineFolderID
    WHERE chtd.DivisionID = @DivisionID AND ch.Active = 1 AND ch.SeasonYearID = @SeasonYearID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05539', GetDate())
GO
