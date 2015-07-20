alter table pWorkflowTemplate
  add ScheduleBy				char(1)		null,
      EnforceDependency			bit			null
go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03332', GetDate())
GO
