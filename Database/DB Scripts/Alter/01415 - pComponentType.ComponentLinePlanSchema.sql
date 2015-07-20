
	
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pComponentType'
    AND  COLUMN_NAME = 'ComponentLinePlanSearchSchema')
	ALTER TABLE pComponentType ADD ComponentLinePlanSearchSchema NVARCHAR(200)



IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pComponentType'
    AND  COLUMN_NAME = 'ComponentLinePlanSchema')
	ALTER TABLE pComponentType ADD ComponentLinePlanSchema NVARCHAR(200)

GO

UPDATE pComponentType SET ComponentLinePlanSearchSchema = 'Material_LinePlan_Search_Default.xml'
UPDATE pComponentType SET ComponentLinePlanSchema =  'Material_LinePlan_Default.xml'


GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01415', GetDate())

GO

