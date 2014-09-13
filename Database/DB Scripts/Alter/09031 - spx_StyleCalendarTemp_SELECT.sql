/****** Object:  StoredProcedure [dbo].[spx_StyleCalendarTemp_SELECT]    Script Date: 09/01/2014 16:51:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCalendarTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCalendarTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleCalendarTemp_SELECT]    Script Date: 09/01/2014 16:51:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCalendarTemp_SELECT]
	@CalendarId nVARCHAR(50),
	@EventsAmountPerDay INT = -1
AS 

BEGIN

	IF @EventsAmountPerDay = -1
	BEGIN
		SELECT *
		FROM pStyleCalendarTemp WITH (NOLOCK) 
		WHERE CalendarId = @CalendarId
		ORDER BY CalendarType DESC, Calendardate DESC, CalendarStatus
	END
	ELSE
	BEGIN
		SELECT * FROM
		(
			SELECT *, ROW_NUMBER() OVER (PARTITION BY CAST(CalendarDate AS DATE) ORDER BY CalendarDescription) AS SortByDay
			FROM pStyleCalendarTemp WITH (NOLOCK) 
			WHERE CalendarId = @CalendarId
		) AS DataSource
		WHERE SortByDay <= @EventsAmountPerDay
		ORDER BY CalendarType DESC, Calendardate DESC, CalendarStatus
	END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09031', GetDate())
GO
