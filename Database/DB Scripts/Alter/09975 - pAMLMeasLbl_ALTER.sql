ALTER TABLE pAMLMeasLbl ALTER COLUMN MeasLbl NVARCHAR(200);

IF (EXISTS(SELECT * FROM pAMLMeasLbl l
           WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = l.SizeRangeId)))
  INSERT INTO pSizeRange(CustomId, SizeRangeCode, Size0, Sel0, SizeDesc0, Active, CUser, CDate)
  SELECT l.SizeRangeId, 'Unknown', 'Unknown', 1, 'Unknown size range', 0, 'Update script', CURRENT_TIMESTAMP
  FROM pAMLMeasLbl l
  WHERE NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = l.SizeRangeId)
  GROUP BY l.SizeRangeId
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pAMLMeasLbl' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pAMLMeasLbl_SizeRange')
 ALTER TABLE pAMLMeasLbl 
 ADD CONSTRAINT FK_pAMLMeasLbl_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09975', GetUTCDate())
GO
