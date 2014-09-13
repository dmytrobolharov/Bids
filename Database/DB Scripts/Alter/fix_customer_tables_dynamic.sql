BEGIN
        DECLARE @vTableName        varchar(100),
                @vConstraintName   varchar(100),
                @vSQL              varchar(2000),
                @Type5     int
 
         DECLARE Table2Process INSENSITIVE CURSOR
                 FOR select Name
                      from sysobjects
                     where xtype = 'U'
                       and name like '%Custom%'
                        or Name like 'pStitchType'
                      order by 1
              FOR READ ONLY

           OPEN Table2Process 

           FETCH NEXT FROM Table2Process INTO @vTableName

           WHILE @@FETCH_STATUS = 0
            BEGIN
                IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
                           WHERE TABLE_NAME = @vTableName AND COLUMN_NAME = 'CustomId' )
                     BEGIN
                          SET @vSQL = null
                          SET @vSQL = 'ALTER TABLE ' + @vTableName + ' ADD CustomID uniqueidentifier NULL'
                          EXEC (@vSQL)

                          IF @@error <> 0
                             BEGIN
                                   SELECT @vSQL
                                   goto error
                             END


                          SET @vSQL = null
                          SET @vSQL = 'ALTER TABLE ' + @vTableName + ' ADD CONSTRAINT ' + 'DF_' + @vTableName 
                          SET @vSQL = @vSQL + '_CustomID DEFAULT newid() FOR CustomId'
                          EXEC (@vSQL)

                          IF @@error <> 0
                             BEGIN
                                   SELECT @vSQL
                                   goto error
                             END

                          SET @vSQL = null
                          SET @vSQL = 'UPDATE ' + @vTableName + ' SET CustomID = newid()'
                          EXEC (@vSQL)

                          IF @@error <> 0
                             BEGIN
                                   SELECT @vSQL
                                   goto error
                             END

                          SET @vSQL = null
                          SET @vSQL = 'ALTER TABLE ' + @vTableName + ' ALTER COLUMN CustomID uniqueidentifier NOT NULL'
                          EXEC (@vSQL)

                          IF @@error <> 0
                             BEGIN
                                   SELECT @vSQL
                                   goto error
                             END

                          SET @vConstraintName = null
                          SET @vSQL = null
                          SELECT @vConstraintName = Constraint_Name 
                           FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = @vTableName

                          IF @vConstraintName is not NULL
                             BEGIN
                                  SET @vSQL = null
                                  SET @vSQL = 'ALTER TABLE ' + @vTableName + ' DROP CONSTRAINT ' + @vConstraintName
                                  EXEC (@vSQL)
                                  IF @@error <> 0
                                    BEGIN
                                         SELECT @vSQL
                                         goto error
                                    END
                             END 

                          SET @vSQL = null
                          SET @vSQL = 'ALTER TABLE ' + @vTableName + ' ADD CONSTRAINT PK_' + @vTableName + ' PRIMARY KEY CLUSTERED (CustomID)'
                          EXEC (@vSQL) 
                          IF @@error <> 0
                             BEGIN
                                   SELECT @vSQL
                                   goto error
                             END

                     END

                IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_NAME = @vTableName AND COLUMN_NAME = 'CustomSort' )
                     BEGIN
                          SET @vSQL = null
                          SET @vSQL = 'ALTER TABLE ' + @vTableName + ' ADD CustomSort NVARCHAR(5) NULL'
                          EXEC (@vSQL)

                          IF @@error <> 0
                             BEGIN
                                   SELECT @vSQL
                                   goto error
                             END

                     END

                 FETCH NEXT FROM Table2Process INTO @vTableName
            END

error:
    CLOSE Table2Process
	DEALLOCATE Table2Process
END