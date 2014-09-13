DECLARE @GradeRuleGuidID   uniqueidentifier
DECLARE @POMCompanyId      uniqueidentifier
DECLARE @ClassRangeId      uniqueidentifier
DECLARE @POMAlternatesIdXX uniqueidentifier 
DECLARE @SizeRangeGuidId   uniqueidentifier  
DECLARE @GradeRuleId       int
DECLARE @POMGradeTypeId    int
DECLARE @SizeRangeId       int
DECLARE @Incr1             nvarchar(18),@Incr22 nvarchar(18)
DECLARE @Incr2             nvarchar(18),@Incr23 nvarchar(18)
DECLARE @Incr3             nvarchar(18),@Incr24 nvarchar(18) 
DECLARE @Incr4             nvarchar(18),@Incr25 nvarchar(18) 
DECLARE @Incr5             nvarchar(18),@Incr26 nvarchar(18) 
DECLARE @Incr6             nvarchar(18),@Incr27 nvarchar(18)
DECLARE @Incr7             nvarchar(18),@Incr28 nvarchar(18)
DECLARE @Incr8             nvarchar(18),@Incr29 nvarchar(18)
DECLARE @Incr9             nvarchar(18),@Incr30 nvarchar(18)
DECLARE @Incr10            nvarchar(18),@Incr31 nvarchar(18)
DECLARE @Incr11            nvarchar(18),@Incr32 nvarchar(18)
DECLARE @Incr12            nvarchar(18),@Incr33 nvarchar(18)
DECLARE @Incr13            nvarchar(18),@Incr34 nvarchar(18)
DECLARE @Incr14            nvarchar(18),@Incr35 nvarchar(18)
DECLARE @Incr15            nvarchar(18),@Incr36 nvarchar(18)
DECLARE @Incr16            nvarchar(18),@Incr37 nvarchar(18)
DECLARE @Incr17            nvarchar(18),@Incr38 nvarchar(18)
DECLARE @Incr18            nvarchar(18),@Incr39 nvarchar(18)
DECLARE @Incr19            nvarchar(18),@Incr40 nvarchar(18)
DECLARE @Incr20            nvarchar(18),@Incr41 nvarchar(18)
DECLARE @Incr21            nvarchar(18),@Incr42 nvarchar(18)
DECLARE @Incr43            nvarchar(18),@Incr44 nvarchar(18)
DECLARE @Incr45            nvarchar(18),@Incr46 nvarchar(18)
DECLARE @Incr47            nvarchar(18),@Incr48 nvarchar(18)
DECLARE @ColValue          nvarchar(20)
DECLARE @ColRemainder          nvarchar(20)

DECLARE @myerror int
DECLARE @counter int
DECLARE @reccounter int
DECLARE @ColName nvarchar(6)
DECLARE @SQLString nvarchar(2000)
DECLARE @ColLen    int

DECLARE Curse1 INSENSITIVE CURSOR
           FOR SELECT GradeRuleGuidID,POMCompanyId,ClassRangeId,POMAlternatesIdXX
                      ,SizeRangeGuidId,GradeRuleId,POMGradeTypeId,SizeRangeId,Incr1
                      ,Incr2,Incr3,Incr4,Incr5,Incr6,Incr7,Incr8,Incr9,Incr10,Incr11
                      ,Incr12,Incr13,Incr14,Incr15,Incr16,Incr17,Incr18,Incr19,Incr20
                      ,Incr21,Incr22,Incr23,Incr24,Incr25,Incr26,Incr27,Incr28,Incr29
                      ,Incr30,Incr31,Incr32,Incr33,Incr34,Incr35,Incr36,Incr37,Incr38
                      ,Incr39,Incr40,Incr41,Incr42,Incr43,Incr44,Incr45,Incr46
                      ,Incr47,Incr48
                  FROM pGRGradeRule
            FOR READ ONLY
            
 SET NOCOUNT ON
 SET @counter = 1
 WHILE @counter <= 48
	   BEGIN
	   
	         IF @counter <= 9
	            BEGIN
	                 SET @ColName = 'Incr' + Cast(@counter as NVARCHAR(1))
	            END
	          ELSE
	            BEGIN
	                 SET @ColName = 'Incr' + Cast(@counter as NVARCHAR(2))
	            END
	        
	         SET @SQLString = 'UPDATE pGRGradeRule SET '
	                 SET @SQLString = @SQLString +  @ColName + ' = '
	                 SET @SQLString = @SQLString +  ' REPLACE ( ' + @ColName  + ','
	                 SET @SQLString = @SQLString +  CHAR(39) + ',' + CHAR(39) + ','
	                 SET @SQLString = @SQLString +  CHAR(39) + '.' + CHAR(39) + ' )'
	                 SET @SQLString = @SQLString +  ' WHERE ' 
	                 SET @SQLString = @SQLString +   @ColName + ' LIKE ' + char(39) + '%,%' + char(39)

	          -- print 'counter is: ' + cast(@counter as varchar(12)) + ' ' + @SQLString
	          EXECUTE sp_executesql @SQLString
	          SET @counter = @counter + 1
	   END	
 
 
 
 OPEN  Curse1

 FETCH NEXT FROM Curse1 INTO @GradeRuleGuidID,@POMCompanyId,@ClassRangeId,@POMAlternatesIdXX
                      ,@SizeRangeGuidId,@GradeRuleId,@POMGradeTypeId,@SizeRangeId,@Incr1
                      ,@Incr2,@Incr3,@Incr4,@Incr5,@Incr6,@Incr7,@Incr8,@Incr9,@Incr10,@Incr11
                      ,@Incr12,@Incr13,@Incr14,@Incr15,@Incr16,@Incr17,@Incr18,@Incr19,@Incr20
                      ,@Incr21,@Incr22,@Incr23,@Incr24,@Incr25,@Incr26,@Incr27,@Incr28,@Incr29
                      ,@Incr30,@Incr31,@Incr32,@Incr33,@Incr34,@Incr35,@Incr36,@Incr37,@Incr38
                      ,@Incr39,@Incr40,@Incr41,@Incr42,@Incr43,@Incr44,@Incr45,@Incr46
                      ,@Incr47,@Incr48
  SET @ColName = Null
  SET @reccounter = 1
  SET @counter = 1    -- init loop to 0
  SET @SQLString = Null
  WHILE @@FETCH_STATUS = 0
      BEGIN 
            WHILE @counter <= 48
	         BEGIN	
	              SET @ColLen = 0  -- Set column length to 0              
	              IF @counter <= 9
	                 BEGIN
	                      SET @ColName = 'Incr' + Cast(@counter as NVARCHAR(1))
	                 END
	              ELSE
	                 BEGIN
	                      SET @ColName = 'Incr' + Cast(@counter as NVARCHAR(2))
	                 END
	              
                      SET @ColValue = Null   	                 
	              SET @ColValue = 
                        CASE @ColName
                          WHEN 'Incr1' THEN @Incr1
                          WHEN 'Incr2' THEN @Incr2
                          WHEN 'Incr3' THEN @Incr3
                          WHEN 'Incr4' THEN @Incr4
                          WHEN 'Incr5' THEN @Incr5
                          WHEN 'Incr6' THEN @Incr6
                          WHEN 'Incr7' THEN @Incr7
                          WHEN 'Incr8' THEN @Incr8
                          WHEN 'Incr9' THEN @Incr9
                          WHEN 'Incr10' THEN @Incr10
                          WHEN 'Incr11' THEN @Incr11
                          WHEN 'Incr12' THEN @Incr12
                          WHEN 'Incr13' THEN @Incr13
                          WHEN 'Incr14' THEN @Incr14
                          WHEN 'Incr15' THEN @Incr15
                          WHEN 'Incr16' THEN @Incr16
                          WHEN 'Incr17' THEN @Incr17
                          WHEN 'Incr18' THEN @Incr18
                          WHEN 'Incr19' THEN @Incr19
                          WHEN 'Incr20' THEN @Incr20
                          WHEN 'Incr21' THEN @Incr21
                          WHEN 'Incr22' THEN @Incr22
                          WHEN 'Incr23' THEN @Incr23
                          WHEN 'Incr24' THEN @Incr24
                          WHEN 'Incr25' THEN @Incr25
                          WHEN 'Incr26' THEN @Incr26
                          WHEN 'Incr27' THEN @Incr27
                          WHEN 'Incr28' THEN @Incr28
                          WHEN 'Incr29' THEN @Incr29
                          WHEN 'Incr30' THEN @Incr30
                          WHEN 'Incr31' THEN @Incr31
                          WHEN 'Incr32' THEN @Incr32
                          WHEN 'Incr33' THEN @Incr33
                          WHEN 'Incr34' THEN @Incr34
                          WHEN 'Incr35' THEN @Incr35
                          WHEN 'Incr36' THEN @Incr36
                          WHEN 'Incr37' THEN @Incr37
                          WHEN 'Incr38' THEN @Incr38
                          WHEN 'Incr39' THEN @Incr39
                          WHEN 'Incr40' THEN @Incr40
                          WHEN 'Incr41' THEN @Incr41
                          WHEN 'Incr42' THEN @Incr42
                          WHEN 'Incr43' THEN @Incr43
                          WHEN 'Incr44' THEN @Incr44
                          WHEN 'Incr45' THEN @Incr45
                          WHEN 'Incr46' THEN @Incr46
                          WHEN 'Incr47' THEN @Incr47
                          ELSE  @Incr48   
                         END
                       SET  @ColValue = ISNULL ( ltrim(rtrim(@ColValue)) , '0' )
                  --
	              -- Do the normal case first not sample column
	              -- 	              
	              -- IF @ColName = 'Incr1'
	                -- PRINT 'Column: ' + @ColName + ' is: ' + @ColValue


	              
	              IF @ColValue LIKE '[0-9]%' 
	              BEGIN
	                 -- PRINT @ColName + ' is: ' + @ColValue
	                              
	                 SET @SQLString = 'UPDATE pGRGradeRule SET '
	                 SET @SQLString = @SQLString +  @ColName + ' = '
	                 SET @SQLString = @SQLString +  'dbo.fnx_Frac2Num (' + CHAR(39) +  @ColValue + CHAR(39)  + ')'
	                 SET @SQLString = @SQLString +  ' WHERE ' 
	                 SET @SQLString = @SQLString +  ' GradeRuleGuidID = '
	                 SET @SQLString = @SQLString +  char(39) + CAST(@GradeRuleGuidID as NVARCHAR(50)) + char(39)

	                 -- PRINT 'normal data: ' + @SQLString
	                -- PRINT ' '
	              END
	              
	              ELSE IF @ColValue = 'B' 
	                  BEGIN
	                       SET @ColValue = '0'
	                       SET @SQLString = 'UPDATE pGRGradeRule SET '
	                       SET @SQLString = @SQLString +  @ColName + ' = '
	                       SET @SQLString = @SQLString +  'dbo.fnx_Frac2Num (' + CHAR(39) +  @ColValue + CHAR(39)  + ')'
	                       SET @SQLString = @SQLString +  ' WHERE ' 
	                       SET @SQLString = @SQLString +  ' GradeRuleGuidID = '
	                       SET @SQLString = @SQLString +  char(39) + CAST(@GradeRuleGuidID as NVARCHAR(50)) + char(39)

                           -- PRINT 'was b: ' + @SQLString
	                       -- PRINT ' '
	                  END
	                  
	               	  ELSE IF @ColValue LIKE 'B%' and LEN(@ColValue)> 1 
	                  BEGIN
	                  
	                       -- PRINT 'Column: ' + @ColName + ' is: ' + @ColValue
	                       SET @ColRemainder = SUBSTRING(@ColValue,2,LEN(@ColValue)-1)
	                       
	                       IF @ColRemainder NOT LIKE '[0-9]%'
	                          BEGIN
	                               SET @ColRemainder = '0'
	                          END 
	                          	                       
	                       SET @ColValue = @ColRemainder
	                       SET @SQLString = 'UPDATE pGRGradeRule SET '
	                       SET @SQLString = @SQLString +  @ColName + ' = '
	                       SET @SQLString = @SQLString +  'dbo.fnx_Frac2Num (' + CHAR(39) +  @ColValue + CHAR(39)  + ')'
	                       SET @SQLString = @SQLString +  ' WHERE ' 
	                       SET @SQLString = @SQLString +  ' GradeRuleGuidID = '
	                       SET @SQLString = @SQLString +  char(39) + CAST(@GradeRuleGuidID as NVARCHAR(50)) + char(39)

                           -- PRINT 'B+ data: ' + @SQLString
	                       -- PRINT ' '
	                  END
	                  	                  
	                  ELSE --IF @ColName = 'Incr1'
	                  BEGIN
	                       -- PRINT 'Column: ' + @ColName + ' is: ' + @ColValue
	                       SET @ColValue = '0'
	                       SET @SQLString = 'UPDATE pGRGradeRule SET '
	                       SET @SQLString = @SQLString +  @ColName + ' = '
	                       SET @SQLString = @SQLString +  'dbo.fnx_Frac2Num (' + CHAR(39) +  @ColValue + CHAR(39)  + ')'
	                       SET @SQLString = @SQLString +  ' WHERE ' 
	                       SET @SQLString = @SQLString +  ' GradeRuleGuidID = '
	                       SET @SQLString = @SQLString +  char(39) + CAST(@GradeRuleGuidID as NVARCHAR(50)) + char(39)

                          --  PRINT 'not normal: ' + @SQLString
	                      --  PRINT ' '
	                  END 
	                  
	                  -- print @SQLString
	                  
	                  EXECUTE sp_executesql @SQLString
	                  
	                  SET @myerror = @@ERROR
	                  IF @@ERROR <> 0
	                     BEGIN
	                          Print 'Error Code: ' + CAST(@myerror as nvarchar(6)) + 'Issuing: ' + @SQLString
	                     END
	                    	                      
	              SET @counter = @counter + 1
               END -- End of column processing loop

          FETCH NEXT FROM Curse1 INTO @GradeRuleGuidID,@POMCompanyId,@ClassRangeId
                      ,@POMAlternatesIdXX
                      ,@SizeRangeGuidId,@GradeRuleId,@POMGradeTypeId,@SizeRangeId,@Incr1
                      ,@Incr2,@Incr3,@Incr4,@Incr5,@Incr6,@Incr7,@Incr8,@Incr9,@Incr10,@Incr11
                      ,@Incr12,@Incr13,@Incr14,@Incr15,@Incr16,@Incr17,@Incr18,@Incr19,@Incr20
                      ,@Incr21,@Incr22,@Incr23,@Incr24,@Incr25,@Incr26,@Incr27,@Incr28,@Incr29
                      ,@Incr30,@Incr31,@Incr32,@Incr33,@Incr34,@Incr35,@Incr36,@Incr37,@Incr38
                      ,@Incr39,@Incr40,@Incr41,@Incr42,@Incr43,@Incr44,@Incr45,@Incr46
                      ,@Incr47,@Incr48
          
           SET @reccounter = @reccounter + 1
           SET @counter = 1 -- reset it back to 1
      
      END -- END of While Loop
        
      CLOSE Curse1
      DEALLOCATE Curse1
GO


ALTER TABLE pGRGradeRule ALTER Column Incr1 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr2 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr3 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr4 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr5 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr6 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr7 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr8 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr9 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr10 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr11 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr12 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr13 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr14 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr15 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr16 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr17 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr18 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr19 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr20 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr21 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr22 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr23 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr24 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr25 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr26 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr27 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr28 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr29 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr30 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr31 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr32 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr33 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr34 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr35 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr36 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr37 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr38 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr39 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr40 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr41 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr42 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr43 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr44 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr45 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr46 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr47 DECIMAL(18,4)
GO

ALTER TABLE pGRGradeRule ALTER Column Incr48 DECIMAL(18,4)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01408', GetDate())
GO