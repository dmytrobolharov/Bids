DECLARE @ConstraintName NVARCHAR(200)

SELECT @ConstraintName = c.constraint_name
FROM information_schema.table_constraints c
WHERE c.table_name = 'pSizeClass' AND c.constraint_type = 'PRIMARY KEY'

IF @ConstraintName IS NOT NULL AND 
   (@ConstraintName != 'PK_pSizeClass' OR
    EXISTS(SELECT * FROM information_schema.constraint_column_usage
          WHERE table_name = 'pSizeClass' AND 
		        constraint_name = @ConstraintName AND 
				column_name != 'CustomId'))
BEGIN
  EXEC('ALTER TABLE pSizeClass DROP CONSTRAINT ' + @ConstraintName)
  SET @ConstraintName = NULL
END

IF @ConstraintName IS NULL OR @ConstraintName != 'PK_pSizeClass'
  ALTER TABLE pSizeClass 
  ADD CONSTRAINT PK_pSizeClass PRIMARY KEY NONCLUSTERED (CustomId)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09929', GetDate())
GO
