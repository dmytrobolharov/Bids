IF (EXISTS(SELECT * FROM pSampleRequestAMLMeasHdr h
           WHERE NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = h.SizeClassId)))
BEGIN  

  IF EXISTS(SELECT * FROM pSampleRequestAMLMeasHdr h
            WHERE NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = h.SizeClassId OR sc.Custom = h.SizeClass))
    INSERT INTO pSizeClass (Custom, CustomKey, Active, CUser, CDate)
	SELECT h.SizeClass, 'Unknown', 0, 'Update script', CURRENT_TIMESTAMP
	FROM pSampleRequestAMLMeasHdr h
    WHERE NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = h.SizeClassId OR sc.Custom = h.SizeClass)
	GROUP BY h.SizeClass
  
  UPDATE h
  SET h.SizeClassId = (SELECT TOP 1 sc.CustomId FROM pSizeClass sc WHERE sc.Custom = h.SizeClass)
  FROM pSampleRequestAMLMeasHdr h
  WHERE NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = h.SizeClassId)

END
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pSampleRequestAMLMeasHdr' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pSampleRequestAMLMeasHdr_SizeClass')
 ALTER TABLE pSampleRequestAMLMeasHdr 
 ADD CONSTRAINT FK_pSampleRequestAMLMeasHdr_SizeClass FOREIGN KEY (SizeClassId) 
 REFERENCES pSizeClass (CustomId) 
GO

IF (EXISTS(SELECT * FROM pSampleRequestAMLMeasHdr h
           WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = h.SizeRangeId)))
BEGIN

  IF EXISTS(SELECT * FROM pSampleRequestAMLMeasHdr h
            WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = h.SizeRangeId OR sr.SizeRangeCode = h.SizeRange))
    INSERT INTO pSizeRange(SizeRangeCode, Size0, Sel0, SizeDesc0, Active, CUser, CDate)
	SELECT h.SizeRange, 'Unknown', 1, 'Unknown size range', 0, 'Update script', CURRENT_TIMESTAMP
	FROM pSampleRequestAMLMeasHdr h
    WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = h.SizeRangeId OR sr.SizeRangeCode = h.SizeRange)
	GROUP BY h.SizeRange

  UPDATE h
  SET h.SizeRangeId = (SELECT TOP 1 sr.CustomId FROM pSizeRange sr WHERE sr.SizeRangeCode = h.SizeRange)
  FROM pSampleRequestAMLMeasHdr h
  WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = h.SizeRangeId)

END
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pSampleRequestAMLMeasHdr' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pSampleRequestAMLMeasHdr_SizeRange')
 ALTER TABLE pSampleRequestAMLMeasHdr 
 ADD CONSTRAINT FK_pSampleRequestAMLMeasHdr_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10016', GetUTCDate())
GO
