delete from pGRMeasurementsClassRange
where SizeRangeId not in (select CustomId from pSizeRange)

delete from pGRMeasurementsClassRange
where SizeClassId not in (select CustomId from pSizeClass)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07573', GetDate())
GO
