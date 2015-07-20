IF (EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateGroup mpt
           WHERE mpt.SizeClassId IS NULL OR NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = mpt.SizeClassId)))
  UPDATE mpt
  SET mpt.SizeClassId = (SELECT TOP 1 sc.CustomId FROM pSizeClass sc WHERE sc.Custom = mpt.SizeClass)
  FROM pGRMeasurementsClassRange mpt
  WHERE mpt.SizeClassId IS NULL OR NOT EXISTS(SELECT * FROM pSizeClass sc WHERE sc.CustomId = mpt.SizeClassId)
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateGroup' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateGroup_SizeClass')
 ALTER TABLE pGRMeasurementsPOMTemplateGroup 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateGroup_SizeClass FOREIGN KEY (SizeClassId) 
 REFERENCES pSizeClass (CustomId) 
GO

IF (EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateGroup mpt
           WHERE mpt.SizeRangeId IS NULL OR NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = mpt.SizeRangeId)))
  UPDATE mpt
  SET mpt.SizeRangeId = (SELECT TOP 1 sr.CustomId FROM pSizeRange sr WHERE sr.SizeRangeCode = mpt.SizeRange)
  FROM pGRMeasurementsPOMTemplateGroup mpt
  WHERE mpt.SizeRangeId IS NULL OR NOT EXISTS(SELECT * FROM pSizeRange sr WHERE sr.CustomId = mpt.SizeRangeId)
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateGroup' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateGroup_SizeRange')
 ALTER TABLE pGRMeasurementsPOMTemplateGroup 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateGroup_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO

IF (EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateGroup mpt
           WHERE mpt.ClassRangeId IS NULL OR 
		         NOT EXISTS(SELECT * FROM pGRMeasurementsClassRange mcr 
		                    WHERE mcr.ClassRangeId = mpt.ClassRangeId AND
							      mcr.SizeRangeId = mpt.SizeRangeId AND 
								  mcr.SizeClassId = mpt.SizeClassId)))
BEGIN  
  IF EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateGroup mpt
            WHERE NOT EXISTS(SELECT * FROM pGRMeasurementsClassRange mcr 
		                     WHERE mcr.SizeRangeId = mpt.SizeRangeId AND 
								   mcr.SizeClassId = mpt.SizeClassId))
    INSERT INTO pGRMeasurementsClassRange(SizeClassId, SizeRangeId, Active, IsLinked, CDate, CUser)
	SELECT mpt.SizeClassId, mpt.SizeRangeId, 1, 1, CURRENT_TIMESTAMP, 'Update script' 
	FROM pGRMeasurementsPOMTemplateGroup mpt
    WHERE NOT EXISTS(SELECT * FROM pGRMeasurementsClassRange mcr 
	                 WHERE mcr.SizeRangeId = mpt.SizeRangeId AND mcr.SizeClassId = mpt.SizeClassId)
  
  UPDATE mpt
  SET mpt.ClassRangeId = (SELECT TOP 1 mcr.ClassRangeId FROM pGRMeasurementsClassRange mcr 
						  WHERE mcr.SizeRangeId = mpt.SizeRangeId AND
							    mcr.SizeClassId = mpt.SizeClassId)
  FROM pGRMeasurementsPOMTemplateGroup mpt
  WHERE mpt.ClassRangeId IS NULL OR 
        NOT EXISTS(SELECT * FROM pGRMeasurementsClassRange mcr 
		           WHERE mcr.ClassRangeId = mpt.ClassRangeId AND
						 mcr.SizeRangeId = mpt.SizeRangeId AND 
						 mcr.SizeClassId = mpt.SizeClassId)
END
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateGroup' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateGroup_ClassRange')
 ALTER TABLE pGRMeasurementsPOMTemplateGroup 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateGroup_ClassRange FOREIGN KEY (ClassRangeId) 
 REFERENCES pGRMeasurementsClassRange (ClassRangeId) 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09952', GetUTCDate())
GO
