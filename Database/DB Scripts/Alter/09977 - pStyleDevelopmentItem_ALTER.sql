IF NOT EXISTS(SELECT * FROM information_schema.columns c
              WHERE c.table_name = 'pStyleDevelopmentItem' AND c.column_name = 'SizeRangeId')
 ALTER TABLE pStyleDevelopmentItem ADD SizeRangeId UNIQUEIDENTIFIER;
GO

IF EXISTS(SELECT * FROM information_schema.columns c
          WHERE c.table_name = 'pStyleDevelopmentItem' AND c.column_name = 'SizeRangeId') AND
   NOT EXISTS(SELECT * FROM information_schema.referential_constraints c
              WHERE c.constraint_name = 'FK_pStyleDevelopmentItem_SizeRange')
 ALTER TABLE pStyleDevelopmentItem 
 ADD CONSTRAINT FK_pStyleDevelopmentItem_SizeRange FOREIGN KEY (SizeRangeId) 
 REFERENCES pSizeRange (CustomId) 
GO

UPDATE sdi
SET sdi.SizeRangeId = sr.CustomId
FROM pStyleDevelopmentItem sdi
INNER JOIN pSizeRange sr ON sr.SizeRangeCode = sdi.SizeRange
WHERE sdi.SizeRangeId IS NULL;
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09977', GetUTCDate())
GO
