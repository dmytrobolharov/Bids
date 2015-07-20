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
VALUES ('DB_Version', '6.1.0000', '09916', GetDate())
GO
