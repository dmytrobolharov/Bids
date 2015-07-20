ALTER TABLE pStyleHeader ALTER COLUMN SizeClass NVARCHAR(400);
ALTER TABLE pStyleHeader ALTER COLUMN SizeRange NVARCHAR(200);

IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pStyleHeader' AND c.column_name = 'SizeClassId')
 ALTER TABLE pStyleHeader ADD SizeClassId UNIQUEIDENTIFIER;
GO

IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pStyleHeader' AND c.column_name = 'SizeRangeId')
 ALTER TABLE pStyleHeader ADD SizeRangeId UNIQUEIDENTIFIER;
GO

UPDATE sh
SET sh.SizeClassId = sc.CustomId
FROM pStyleHeader sh
LEFT JOIN pSizeClass sc ON sc.Custom = sh.SizeClass
WHERE sh.SizeClassId IS NULL;

UPDATE sh
SET sh.SizeRangeId = sc.CustomId
FROM pStyleHeader sh
LEFT JOIN pSizeRange sc ON sc.SizeRangeCode = sh.SizeRange
WHERE sh.SizeRangeId IS NULL;
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09403', GetDate())
GO

