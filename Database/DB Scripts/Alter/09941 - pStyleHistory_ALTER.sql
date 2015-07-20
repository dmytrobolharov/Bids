IF NOT EXISTS(SELECT * FROM information_schema.columns c WHERE c.table_name = 'pStyleHistory' AND c.column_name = 'IsSilho')
	ALTER TABLE pStyleHistory ADD IsSilho BIT
GO

UPDATE pStyleHistory
SET IsSilho = stt.IsSilhouette
FROM pStyleHeader sh
	INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	INNER JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID
WHERE pStyleHistory.StyleID = sh.StyleID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09941', GetUTCDate())
GO
