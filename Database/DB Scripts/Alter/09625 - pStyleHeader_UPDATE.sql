UPDATE pStyleHeader
SET SizeClassId = NULL, SizeRangeId = NULL
WHERE SizeClassId IS NOT NULL OR SizeRangeId IS NOT NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09625', GetDate())
GO
