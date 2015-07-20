IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningColor' AND COLUMN_NAME = 'PlanningColorDrop')
ALTER TABLE pPlanningColor ADD PlanningColorDrop INT DEFAULT 0
GO

UPDATE pPlanningColor SET PlanningColorDrop = 0
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningColor' AND COLUMN_NAME = 'PlanningColorDropUser')
ALTER TABLE pPlanningColor ADD PlanningColorDropUser NVARCHAR(200) DEFAULT 'NONE'
GO

UPDATE pPlanningColor SET PlanningColorDropUser = 'NONE'
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningColor' AND COLUMN_NAME = 'PlanningColorDropDate')
ALTER TABLE pPlanningColor ADD PlanningColorDropDate DATETIME
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06440', GetDate())
GO
