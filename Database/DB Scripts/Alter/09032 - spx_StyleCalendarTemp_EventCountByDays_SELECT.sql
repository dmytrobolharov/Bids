/****** Object:  StoredProcedure [dbo].[spx_StyleCalendarTemp_EventCountByDays_SELECT]    Script Date: 09/01/2014 18:26:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCalendarTemp_EventCountByDays_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCalendarTemp_EventCountByDays_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleCalendarTemp_EventCountByDays_SELECT]    Script Date: 09/01/2014 18:26:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleCalendarTemp_EventCountByDays_SELECT]
	@CalendarID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT CAST(CalendarDate AS DATE) AS CalDay, COUNT(*) AS EventCount 
	FROM pStyleCalendarTemp
	WHERE CalendarId = @CalendarID
	GROUP BY CAST(CalendarDate AS DATE)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09032', GetDate())
GO
