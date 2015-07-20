IF NOT EXISTS(SELECT * FROM pPlanningType)
BEGIN
	INSERT INTO pPlanningType (PlanningCode, PlanningType, Active, Sort)
	VALUES('Default', 'Line Plan Default', 1, 0)
END
GO	

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sAccessGroupPlanningFolder' AND COLUMN_NAME = 'PlanningTypeId')
BEGIN
	ALTER TABLE sAccessGroupPlanningFolder DROP COLUMN PlanningTypeId
END
GO

ALTER TABLE sAccessGroupPlanningFolder ADD PlanningTypeId uniqueidentifier NULL
GO

UPDATE sAccessGroupPlanningFolder SET PlanningTypeId = (SELECT PlanningTypeID FROM pPlanningType WHERE PlanningCode = 'Default') 
WHERE PlanningTypeId IS NULL

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sAccessPlanningFolder' AND COLUMN_NAME = 'PlanningTypeId')
BEGIN	
	ALTER TABLE sAccessPlanningFolder DROP COLUMN PlanningTypeId
END
GO

ALTER TABLE sAccessPlanningFolder ADD PlanningTypeId uniqueidentifier NULL
GO

UPDATE sAccessPlanningFolder SET PlanningTypeId = (SELECT PlanningTypeID FROM pPlanningType WHERE PlanningCode = 'Default') WHERE PlanningTypeId IS NULL


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07462', GetDate())
GO