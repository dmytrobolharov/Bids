alter table pStyleHeader
  add StartDate					datetime		null
go


alter table pWorkflowTemplate
  add StartDate					datetime		null,
	  DueDate					datetime		null
go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03328', GetDate())
GO
