IF (EXISTS(SELECT * FROM pGRMeasurementsClassRange mcr
           WHERE mcr.SizeClassId IS NULL OR NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = mcr.SizeClassId)))
  UPDATE mcr
  SET mcr.SizeClassId = (SELECT TOP 1 sc.CustomId FROM pSizeClass sc WHERE sc.Custom = mcr.SizeClass)
  FROM pGRMeasurementsClassRange mcr
  WHERE mcr.SizeClassId IS NULL OR NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = mcr.SizeClassId)
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsClassRange' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsClassRange_SizeClass')
 ALTER TABLE pGRMeasurementsClassRange 
 ADD CONSTRAINT FK_pGRMeasurementsClassRange_SizeClass FOREIGN KEY (SizeClassId) 
 REFERENCES pSizeClass (CustomId) 
GO

IF (EXISTS(SELECT * FROM pGRMeasurementsClassRange mcr
           WHERE mcr.SizeRangeId IS NULL OR NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = mcr.SizeRangeId)))
  UPDATE mcr
  SET mcr.SizeRangeId = (SELECT TOP 1 sr.CustomId FROM pSizeRange sr WHERE sr.SizeRangeCode = mcr.SizeRange)
  FROM pGRMeasurementsClassRange mcr
  WHERE mcr.SizeRangeId IS NULL OR NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = mcr.SizeRangeId)
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsClassRange' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsClassRange_SizeRange')
 ALTER TABLE pGRMeasurementsClassRange 
 ADD CONSTRAINT FK_pGRMeasurementsClassRange_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09931', GetDate())
GO
