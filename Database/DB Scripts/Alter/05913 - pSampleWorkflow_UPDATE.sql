-- some pages uses trimmed workflow names as column names, 
-- so trim whitespaces from all workflow names
UPDATE pSampleWorkflow SET SampleWorkflow = RTRIM(LTRIM(SampleWorkflow))
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05913', GetDate())
GO
