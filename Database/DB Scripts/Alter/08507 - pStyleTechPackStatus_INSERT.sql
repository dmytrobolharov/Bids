INSERT INTO pStyleTechPackStatus(
	StyleID, StyleSeasonYearID, WorkStatus,
	CUser, CDate, MUser, MDate)
SELECT ssy.StyleID, ssy.StyleSeasonYearID, 1,
	'SYSTEM', GETDATE(), 'SYSTEM', GETDATE()
FROM pStyleSeasonYear ssy
LEFT JOIN pStyleTechPackStatus stps ON ssy.StyleSeasonYearID = stps.StyleSeasonYearID
WHERE stps.StyleTechPackStatusID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08507', GetDate())
GO
