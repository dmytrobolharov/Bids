INSERT INTO pSubCategory (CustomKey, Custom, Active, CustomSort)
SELECT 'L', 'Low', 1, '00001'
UNION
SELECT 'M', 'Medium', 1, '00002'
UNION
SELECT 'H', 'High', 1, '00003'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06842', GetDate())
GO
