DELETE FROM pworkflow WHERE workflowid='40000000-0000-0000-0000-000000000081' or workflowid='40000000-0000-0000-0000-000000000082' or workflowid='40000000-0000-0000-0000-000000000083' 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06315', GetDate())
GO
