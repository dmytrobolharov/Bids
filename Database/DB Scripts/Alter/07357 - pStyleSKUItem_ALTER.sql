IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleSKUItem' AND COLUMN_NAME = 'PlanningSKUHeaderID')
BEGIN
	ALTER TABLE pStyleSKUItem ADD PlanningSKUHeaderID UNIQUEIDENTIFIER	
END
GO

-- link already created sku plans to corresponding sku plans from Planning
UPDATE pStyleSKUItem SET PlanningSKUHeaderID = psh.PlanningSKUHeaderID
FROM pStyleSKUItem ssi
INNER JOIN pPlanningItem pli ON ssi.StyleSKUItemID = pli.StyleSKUHeaderID
INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN pPlanningSKUHeader psh ON pli.PlanningID = psh.PlanningID AND ssy.SeasonYearID = psh.SeasonYearID
WHERE ssi.PlanningSKUHeaderID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07357', GetDate())
GO
