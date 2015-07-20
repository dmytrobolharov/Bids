
UPDATE i
SET i.QuickFillFieldName = 'drlSizeClassId', i.QuickFillFieldValue = COALESCE(sc.CustomID, '')
FROM pFlashEditQuickFillItem i
LEFT JOIN pSizeClass sc ON sc.Custom = i.QuickFillFieldValue
WHERE i.QuickFillFieldName = 'drlSizeClass'
GO

UPDATE i
SET i.QuickFillFieldName = 'drlSizeRangeId', i.QuickFillFieldValue = COALESCE(sr.CustomID, '')
FROM pFlashEditQuickFillItem i
LEFT JOIN pSizeRange sr ON sr.SizeRangeCode = i.QuickFillFieldValue
WHERE i.QuickFillFieldName = 'drlSizeRange'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09959', GetUTCDate())
GO
