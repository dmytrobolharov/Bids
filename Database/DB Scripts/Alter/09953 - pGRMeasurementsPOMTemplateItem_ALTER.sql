DELETE ti FROM pGRMeasurementsPOMTemplateItem ti
WHERE NOT EXISTS(SELECT * FROM pGRMeasurementsPOMTemplate t
                 WHERE t.POMTempID = ti.POMTempID)
GO

UPDATE ti
SET ti.SizeClassId = t.SizeClassId,
    ti.SizeRangeId = t.SizeRangeId,
	ti.ClassRangeId = t.ClassRangeId
FROM pGRMeasurementsPOMTemplateItem ti
LEFT JOIN pGRMeasurementsPOMTemplate t ON t.POMTempID = ti.POMTempID
WHERE ti.SizeClassId != t.SizeClassId OR 
   	  ti.SizeRangeId != t.SizeRangeId OR
	  ti.ClassRangeId != t.ClassRangeId
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateItem' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateItem_SizeClass')
 ALTER TABLE pGRMeasurementsPOMTemplateItem 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateItem_SizeClass FOREIGN KEY (SizeClassId) 
 REFERENCES pSizeClass (CustomId) 
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateItem' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateItem_SizeRange')
 ALTER TABLE pGRMeasurementsPOMTemplateItem 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateItem_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateItem' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateItem_ClassRange')
 ALTER TABLE pGRMeasurementsPOMTemplateItem 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateItem_ClassRange FOREIGN KEY (ClassRangeId) 
 REFERENCES pGRMeasurementsClassRange (ClassRangeId) 
GO

IF NOT EXISTS(SELECT * FROM information_schema.table_constraints c
              WHERE c.table_name = 'pGRMeasurementsPOMTemplateItem' AND 
			        c.constraint_type = 'FOREIGN KEY' AND 
					c.constraint_name = 'FK_pGRMeasurementsPOMTemplateItem_POMTemplate')
 ALTER TABLE pGRMeasurementsPOMTemplateItem 
 ADD CONSTRAINT FK_pGRMeasurementsPOMTemplateItem_POMTemplate FOREIGN KEY (POMTempId) 
 REFERENCES pGRMeasurementsPOMTemplate (POMTempId) 
 ON DELETE CASCADE
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09953', GetUTCDate())
GO

