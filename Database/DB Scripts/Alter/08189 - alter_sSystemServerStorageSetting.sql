ALTER TABLE sSystemServerStorageSetting ADD PlanningPath nVARCHAR(200) NULL

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08189', GetDate())

GO