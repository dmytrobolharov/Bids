DECLARE @ConstraintName NVARCHAR(200)

SELECT @ConstraintName = c.constraint_name
FROM information_schema.table_constraints c
WHERE c.table_name = 'pSizeRange' AND c.constraint_type = 'PRIMARY KEY'

IF @ConstraintName IS NOT NULL AND 
  (@ConstraintName != 'PK_pSizeRange' OR 
   EXISTS(SELECT * FROM information_schema.constraint_column_usage
          WHERE table_name = 'pSizeRange' AND 
		        constraint_name = @ConstraintName AND 
				column_name != 'CustomId'))
BEGIN
  EXEC('ALTER TABLE pSizeRange DROP CONSTRAINT ' + @ConstraintName)
  SET @ConstraintName = NULL
END

IF @ConstraintName IS NULL OR @ConstraintName != 'PK_pSizeRange'
  ALTER TABLE pSizeRange 
  ADD CONSTRAINT PK_pSizeRange PRIMARY KEY NONCLUSTERED (CustomId)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09930', GetDate())
GO
