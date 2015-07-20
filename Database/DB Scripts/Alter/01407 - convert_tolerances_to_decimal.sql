DECLARE @ToleranceGuidId      uniqueidentifier
DECLARE @ProductClassImageId  uniqueidentifier
DECLARE @POMAlternatesIdXXX   uniqueidentifier
DECLARE @POMCompanyId         uniqueidentifier
DECLARE @ToleranceId          int
DECLARE @Garment_Cls_ImgId    int
DECLARE @POMGradeTypeId       int
DECLARE @TolPlus              nvarchar(18)
DECLARE @TolMinus             nvarchar(18)
DECLARE @IsOnQA               int
DECLARE @IsPrimaryKeyMeas     int

DECLARE @ColValue              nvarchar(20)
DECLARE @ColRemainder          nvarchar(20)

DECLARE @myerror int
DECLARE @counter int
DECLARE @reccounter int
DECLARE @ColName nvarchar(18)
DECLARE @SQLString nvarchar(2000)
DECLARE @ColLen    int

DECLARE Curse1 INSENSITIVE CURSOR
           FOR SELECT ToleranceGuidId
                     ,ProductClassImageId
                     ,POMAlternatesIdXXX
                     ,POMCompanyId
                     ,ToleranceId
                     ,Garment_Cls_ImgId
                     ,POMGradeTypeId
                     ,TolPlus
                     ,TolMinus
                     ,IsOnQA
                     ,IsPrimaryKeyMeas
                FROM pGRTolerance
            FOR READ ONLY
            
 SET NOCOUNT ON
 
 UPDATE pGRTolerance
    SET Tolplus = REPLACE (TolPlus, ',' , '.')
 WHERE TolPlus like '%,%'

 UPDATE pGRTolerance
    SET TolMinus = REPLACE (TolMinus, ',' , '.')
 WHERE TolMinus like '%,%'
 
 OPEN  Curse1

 FETCH NEXT FROM Curse1 INTO @ToleranceGuidId,@ProductClassImageId,
                             @POMAlternatesIdXXX,
                             @POMCompanyId,@ToleranceId,
                             @Garment_Cls_ImgId,
                             @POMGradeTypeId,
                             @TolPlus,
                             @TolMinus,
                             @IsOnQA,
                             @IsPrimaryKeyMeas
  SET @reccounter = 1
  SET @counter = 1    -- init loop
  WHILE @@FETCH_STATUS = 0
      BEGIN 
            WHILE @counter <= 2
	         BEGIN	
	              SET @ColLen = 0  -- Set column length to 0              
	              IF  @counter = 1
	                 BEGIN
	                      SET @ColName = 'TolPlus'
	                 END
	              ELSE
	                 BEGIN
	                      SET @ColName = 'TolMinus'
	                 END
	              
                      SET @ColValue = Null   	                 
	              SET @ColValue = 
                        CASE @ColName
                          WHEN 'TolPlus' THEN @TolPlus
                          ELSE  @TolMinus   
                        END

                       SET  @ColValue = ISNULL ( ltrim(rtrim(@ColValue)) , '0' )
                      
                      --
	              -- Do the normal case first 
	              -- 	              

	               -- PRINT 'Column: ' + @ColName + ' is: ' + @ColValue
	              
	              IF @ColValue LIKE '[0-9]%' 
	              BEGIN
	                    -- PRINT @ColName + ' is: ' + @ColValue
	                              
	                    SET @SQLString = 'UPDATE pGRTolerance SET '
	                    SET @SQLString = @SQLString +  @ColName + ' = '
	                    SET @SQLString = @SQLString +  'dbo.fnx_Frac2Num (' + CHAR(39) +  @ColValue + CHAR(39)  + ')'
	                    SET @SQLString = @SQLString +  ' WHERE ' 
	                    SET @SQLString = @SQLString +  ' ToleranceGuidId = '
	                    SET @SQLString = @SQLString +  char(39) + CAST(@ToleranceGuidId as NVARCHAR(50)) + char(39)

	                    -- PRINT 'normal data: ' + @SQLString
	                    -- PRINT ' '
	              END
	              
	                  	                  
	              ELSE 
	              BEGIN
	                    -- PRINT 'Column: ' + @ColName + ' is: ' + @ColValue
	                    SET @ColValue = '0'
	                    SET @SQLString = 'UPDATE pGRTolerance SET '
	                    SET @SQLString = @SQLString +  @ColName + ' = '
	                    SET @SQLString = @SQLString +  'dbo.fnx_Frac2Num (' + CHAR(39) +  @ColValue + CHAR(39)  + ')'
	                    SET @SQLString = @SQLString +  ' WHERE ' 
	                    SET @SQLString = @SQLString +  ' ToleranceGuidId = '
	                    SET @SQLString = @SQLString +  char(39) + CAST(@ToleranceGuidId as NVARCHAR(50)) + char(39)

                         -- PRINT 'not normal: ' + @SQLString
	                     -- PRINT ' '
	               END 
	                  
	               --  print @SQLString
	                  
	                   EXECUTE sp_executesql @SQLString
	                  
	                  SET @myerror = @@ERROR
	                  IF @@ERROR <> 0
	                     BEGIN
	                          Print 'Error Code: ' + CAST(@myerror as nvarchar(6)) + 'Issuing: ' + @SQLString
	                     END
	                    	                      
	              SET @counter = @counter + 1
               END -- End of column processing loop

          FETCH NEXT FROM Curse1 INTO @ToleranceGuidId,@ProductClassImageId,
                             @POMAlternatesIdXXX,
                             @POMCompanyId,@ToleranceId,
                             @Garment_Cls_ImgId,
                             @POMGradeTypeId,
                             @TolPlus,
                             @TolMinus,
                             @IsOnQA,
                             @IsPrimaryKeyMeas
          
           SET @reccounter = @reccounter + 1
           SET @counter = 1 -- reset it back to 1
      
      END -- END of While Loop
        
      CLOSE Curse1
      DEALLOCATE Curse1
GO





ALTER TABLE pGRTolerance ALTER Column TolPlus DECIMAL(18,4)
GO

ALTER TABLE pGRTolerance ALTER Column TolMinus DECIMAL(18,4)
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01407', GetDate())
GO