ALTER TABLE pSampleRequestAMLMeasLbl ALTER COLUMN MeasLbl NVARCHAR(200);

IF (EXISTS(SELECT * FROM pSampleRequestAMLMeasLbl l
           WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = l.SizeRangeId)))
  INSERT INTO pSizeRange(CustomId, SizeRangeCode, Size0, Sel0, SizeDesc0, Active, CUser, CDate)
  SELECT l.SizeRangeId, 'Unknown', 'Unknown', 1, 'Unknown size range', 0, 'Update script', CURRENT_TIMESTAMP
  FROM pSampleRequestAMLMeasLbl l
  WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = l.SizeRangeId)
  GROUP BY l.SizeRangeId
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pSampleRequestAMLMeasLbl' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pSampleRequestAMLMeasLbl_SizeRange')
 ALTER TABLE pSampleRequestAMLMeasLbl 
 ADD CONSTRAINT FK_pSampleRequestAMLMeasLbl_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10017', GetUTCDate())
GO
