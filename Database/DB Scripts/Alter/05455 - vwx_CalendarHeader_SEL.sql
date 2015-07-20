IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_CalendarHeader_SEL]'))
DROP VIEW [dbo].[vwx_CalendarHeader_SEL]
GO


CREATE VIEW [dbo].[vwx_CalendarHeader_SEL]
AS
SELECT     dbo.pCalendarHeader.*, 
	STUFF(
		(SELECT ', ' + iCustom1.Custom
		FROM pCalendarHeaderToDivision LEFT JOIN iCustom1 ON pCalendarHeaderToDivision.DivisionID = iCustom1.CustomID
		WHERE pCalendarHeaderToDivision.CalendarHeaderID = pCalendarHeader.CalendarHeaderID
		ORDER BY iCustom1.CustomSort, iCustom1.Custom
		FOR XML PATH('')), 1, 2, '') AS Divisions
FROM         dbo.pCalendarHeader
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05455', GetDate())
GO
