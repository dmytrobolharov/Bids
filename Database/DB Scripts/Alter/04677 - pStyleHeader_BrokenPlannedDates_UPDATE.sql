UPDATE pStyleHeader SET PlannedDueDate = NULL
WHERE PlannedDueDate = '1900-01-01 00:00:00.000'

UPDATE pStyleHeader SET PlannedStartDate = NULL
WHERE PlannedStartDate = '1900-01-01 00:00:00.000'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04677', GetDate())
GO
