
UPDATE    pworkflow
SET          workflow= 'Measurements'
WHERE     (workflowid = '40000000-0000-0000-0000-000000000050')
GO

UPDATE    Mapping
SET          MapDetail= 'Measurements'
WHERE     (Map = '40000000-0000-0000-0000-000000000050')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01123', GetDate())
GO