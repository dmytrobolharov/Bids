UPDATE    pWorkflow
SET              workflow = 'Measurement Finished'
WHERE     workflowid = '40000000-0000-0000-0000-000000000050'


UPDATE    pWorkflow
SET   workflow = 'Measurement Preprocess'
WHERE  workflowid = '40000000-0000-0000-0000-000000000051'

UPDATE  mapping
SET    mapdetail = 'Measurement Finished'
WHERE   map= '40000000-0000-0000-0000-000000000050'


UPDATE  mapping
SET  mapdetail = 'Measurement Preprocess'
WHERE map = '40000000-0000-0000-0000-000000000051'


go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '506', GetDate())
go