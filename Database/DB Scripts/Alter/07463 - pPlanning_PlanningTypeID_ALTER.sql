IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
				WHERE TABLE_NAME='pPlanning' AND COLUMN_NAME='PlanningTypeID')
BEGIN
	ALTER TABLE pPlanning ADD PlanningTypeID UNIQUEIDENTIFIER
END

GO

UPDATE pPlanning SET PlanningTypeID = (SELECT PlanningTypeID FROM pPlanningType WHERE PlanningCode = 'Default')
WHERE PlanningTypeID IS NULL OR PlanningTypeID NOT IN (SELECT PlanningTypeID FROM pPlanningType)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07463', GetDate())
GO