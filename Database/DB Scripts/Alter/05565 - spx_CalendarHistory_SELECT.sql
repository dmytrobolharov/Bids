/****** Object:  StoredProcedure [dbo].[spx_CalendarHistory_SELECT]    Script Date: 04/15/2013 11:25:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_CalendarHistory_SELECT]    Script Date: 04/15/2013 11:25:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CalendarHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 
BEGIN
	SELECT chead.CalendarHeaderID, chead.CalendarName, chis.CDate
	FROM pCalendarHistory chis 
	INNER JOIN pCalendarHeader chead ON chis.CalendarHeaderID = chead.CalendarHeaderID
	WHERE chis.TeamID = @TeamID
	ORDER BY chis.CDate DESC
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05565', GetDate())
GO
