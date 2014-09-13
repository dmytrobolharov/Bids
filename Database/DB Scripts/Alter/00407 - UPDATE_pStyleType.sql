
UPDATE    pStyleType
SET              SampleSearchSchema = 'Style_Sample_Search_Default.xml'
GO

INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '407', GetDate())

GO