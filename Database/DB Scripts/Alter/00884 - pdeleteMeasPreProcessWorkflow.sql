delete from pWorkFlow where WorkflowID='40000000-0000-0000-0000-000000000051'

delete from Mapping where map='40000000-0000-0000-0000-000000000051'

Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '884', GetDate())
GO   