IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sSystemPageStrings' 
                  AND COLUMN_NAME = N'FormName'
                  AND CHARACTER_MAXIMUM_LENGTH <> 400)
   BEGIN
        ALTER TABLE sSystemPageStrings ALTER COLUMN FormName NVARCHAR(400) NULL 
   END
GO

IF NOT EXISTS 
( 
    SELECT i.Name AS IndexName, c.Name AS ColumnName 
    FROM sys.indexes i 
        JOIN sys.index_columns ic 
                ON i.object_id = ic.object_id AND i.index_id = ic.index_id 
        JOIN sys.columns c 
                ON ic.object_id = c.object_id AND c.column_id = ic.column_id 
    WHERE c.Name = 'FormName' AND i.Name='sSystemPageStrings_FormName' 
) 
  BEGIN
        CREATE INDEX sSystemPageStrings_FormName ON sSystemPageStrings
        (
          FormName                     ASC
        )
  END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01827'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01827', GetDate())

END

GO 
	