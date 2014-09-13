IF NOT EXISTS (SELECT * FROM pControlBOMConfig)
BEGIN
	INSERT INTO pControlBOMConfig (DivisionID, StyleTypeID, StyleCategoryID)
	SELECT d.CustomID, st.StyleTypeID, sc.StyleCategoryId
	FROM iCustom1 d
		INNER JOIN pDivisionStyleType dst ON d.CustomID = dst.DivisionID
		INNER JOIN pStyleType st ON dst.StyleTypeID = st.StyleTypeID
		INNER JOIN pStyleCategoryStyleType scst ON st.StyleTypeID = scst.StyleTypeID
		INNER JOIN pStyleCategory sc ON scst.StyleCategoryID = sc.StyleCategoryId
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06140', GetDate())
GO
