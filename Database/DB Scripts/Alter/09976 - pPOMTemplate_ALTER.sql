IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pPOMTemplate' AND c.column_name = 'SizeClassId')
 ALTER TABLE pPOMTemplate ADD SizeClassId UNIQUEIDENTIFIER;
GO

IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pPOMTemplate' AND c.column_name = 'SizeRangeId')
 ALTER TABLE pPOMTemplate ADD SizeRangeId UNIQUEIDENTIFIER;
GO

UPDATE t
SET t.SizeClassId = CASE WHEN t.SizeClassId IS NULL THEN sc.CustomId ELSE t.SizeClassId END,
    t.SizeRangeId = CASE WHEN t.SizeRangeId IS NULL THEN sr.CustomId ELSE t.SizeRangeId END
FROM pPOMTemplate t
LEFT JOIN pSizeClass sc ON sc.Custom = t.SizeClass
LEFT JOIN pSizeRange sr ON sr.SizeRangeCode = t.SizeRange
WHERE t.SizeClassId IS NULL OR t.SizeRangeId IS NULL;
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09976', GetUTCDate())
GO
