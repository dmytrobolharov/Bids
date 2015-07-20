IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pPlanningConfig' AND c.column_name = 'SizeClassId')
 ALTER TABLE pPlanningConfig ADD SizeClassId UNIQUEIDENTIFIER;
GO

IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pPlanningConfig' AND c.column_name = 'SizeRangeId')
 ALTER TABLE pPlanningConfig ADD SizeRangeId UNIQUEIDENTIFIER;
GO

IF EXISTS(SELECT * FROM information_schema.columns c
          WHERE c.table_name = 'pPlanningConfig' AND c.column_name = 'SizeClassId') AND
   NOT EXISTS(SELECT * FROM information_schema.referential_constraints c
              WHERE c.constraint_name = 'FK_pPlanningConfig_SizeClass')
 ALTER TABLE pPlanningConfig 
 ADD CONSTRAINT FK_pPlanningConfig_SizeClass FOREIGN KEY (SizeClassId) 
 REFERENCES pSizeClass (CustomId) 
GO

IF EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pPlanningConfig' AND c.column_name = 'SizeRangeId') AND
   NOT EXISTS(SELECT * FROM information_schema.referential_constraints c
              WHERE c.constraint_name = 'FK_pPlanningConfig_SizeRange')
 ALTER TABLE pPlanningConfig 
 ADD CONSTRAINT FK_pPlanningConfig_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO

UPDATE pc
SET pc.SizeClassId = CASE WHEN pc.SizeClassId IS NULL THEN sc.CustomId ELSE pc.SizeClassId END,
    pc.SizeRangeId = CASE WHEN pc.SizeRangeId IS NULL THEN sr.CustomId ELSE pc.SizeRangeId END
FROM pPlanningConfig pc
LEFT JOIN pSizeClass sc ON sc.Custom = pc.SizeClass
LEFT JOIN pSizeRange sr ON sr.SizeRangeCode = pc.SizeRange
WHERE pc.SizeClassId IS NULL OR pc.SizeRangeId IS NULL;
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10000', GetUTCDate())
GO
