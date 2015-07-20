--
-- Start of script processing
--

DECLARE @StyleQuoteItemId  uniqueidentifier
DECLARE @StyleId           uniqueidentifier
DECLARE @StyleSeasonYearId uniqueidentifier
DECLARE @Syear             nvarchar(200)
DECLARE @Season            nvarchar(200)
DECLARE @CustomKey         nvarchar(200)
DECLARE @Custom            nvarchar(200)
DECLARE @Completed         int
DECLARE @ColorwayCount     int

DECLARE QuoItem INSENSITIVE CURSOR
            FOR SELECT StyleQuoteItemId,StyleId
                  FROM pStyleQuoteItem
                 WHERE StyleSeasonYearId is NULL
               FOR READ ONLY
                          
OPEN  QuoItem

SET NOCOUNT ON

UPDATE pStyleHeader
   SET CustomField4 = ''
 WHERE CustomField4 is NULL

UPDATE pStyleHeader
   SET CustomField2 = ''
WHERE  CustomField2 is NULL

FETCH NEXT FROM QuoItem INTO @StyleQuoteItemId,@StyleId

WHILE @@FETCH_STATUS = 0
        BEGIN -- quote item loop
        
              SET @Completed         = 0    -- initialize
              SET @ColorwayCount     = 0    -- initialize
              SET @StyleSeasonYearId = NULL -- initialize
              SET @CustomKey         = NULL -- initialize
              SET @Custom            = NULL -- initialize
               
              SELECT @Syear  = CustomField4
                    ,@Season = CustomField2
                FROM pStyleHeader
               WHERE StyleId = @StyleId

              --
              -- Case 1: Season and Year are on the pStyleHeader.... 
              --            
              IF ( LEN(@Syear) > 0 AND LEN(@Season) > 0 )      
                 BEGIN

                       -- Need to get Custom since pStyleSeason years stores off Custom not CustomKey                 
                       SELECT @Custom  = Custom FROM pSeason WHERE CustomKey = @Season

                       IF (@Custom is not null and len(@Custom) > 0)
                          BEGIN
                               SELECT @StyleSeasonYearId = @StyleSeasonYearId
                                 FROM pStyleSeasonyear
                                WHERE StyleId     = @StyleId
                                  AND StyleSeason = @Custom
                                  AND StyleYear   = @Syear

                               IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0) 
                                  BEGIN
                                       SET @Completed = 1
                                  END
                               ELSE
                                  BEGIN
                                          -- Get the seasonyear based upon just style for current season
                                          SELECT TOP 1 @StyleSeasonYearId = StyleSeasonYearId
                                            FROM pStyleSeasonyear
                                           WHERE CurrentSeason > 0
                                             AND StyleId = @StyleId
                                           ORDER BY MDate Desc

                                          IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0)
                                             BEGIN
                                                 SET @Completed = 1
                                             END
                                          ELSE
                                             BEGIN
                                                  SELECT TOP 1 @StyleSeasonYearId = StyleSeasonYearId
                                                    FROM pStyleSeasonyear
                                                   WHERE CurrentSeason > 0
                                                   ORDER BY MDate Desc
                                                   
                                                   IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0) 
                                                       BEGIN
                                                            SET @Completed = 1
                                                       END
                                             END

                                  END -- IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0)

                          END -- IF (@Custom is not null and len(@Custom) > 0)
                       ELSE
                          BEGIN
                                -- Get the seasonyear based upon just style for current season
                                          SELECT TOP 1 @StyleSeasonYearId = StyleSeasonYearId
                                            FROM pStyleSeasonyear
                                           WHERE CurrentSeason > 0
                                             AND StyleId = @StyleId
                                           ORDER BY MDate Desc


                                          IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0)
                                             BEGIN
                                                 SET @Completed = 1
                                             END
                                          ELSE
                                             BEGIN
                                                  SELECT TOP 1 @StyleSeasonYearId = StyleSeasonYearId
                                                    FROM pStyleSeasonyear
                                                   WHERE CurrentSeason > 0
                                                   ORDER BY MDate Desc
                                                   
                                                   IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0) 
                                                       BEGIN
                                                            SET @Completed = 1
                                                       END
                                             END
                          END -- IF (@Custom is null or len(@Custom) = 0)
                        

                 END -- IF ( LEN(@Syear) > 0 AND LEN(@Season) > 0 )   

              --
              -- Case 2: Season and Year are not on the pStyleHeader but there is exactly 1 in the
              --         pStyleColorwaySeasonYear table.
              -- 

               ELSE IF (SELECT COUNT(*) FROM pStyleColorwaySeasonYear WHERE StyleId = @StyleId) = 1
                    BEGIN
                         SELECT @StyleSeasonYearId = StyleSeasonYearId
                           FROM pStyleColorwaySeasonYear
                          WHERE StyleId = @StyleId  

                         IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0)
                            BEGIN
                                 SET @Completed = 1
                            END
                    END

              --
              -- Case 3: Season and Year are not on the pStyleHeader but there is more than 1 in the
              --         pStyleColorwaySeasonYear table. We use the one with the > MDate.
              -- 

               ELSE IF (SELECT COUNT(*) FROM pStyleColorwaySeasonYear WHERE StyleId = @StyleId) > 1
                    BEGIN
                         SELECT TOP 1 @StyleSeasonYearId = StyleSeasonYearId
                           FROM pStyleColorwaySeasonYear
                          WHERE StyleId = @StyleId
                          ORDER BY MDate Desc 

                         IF ((  @StyleSeasonYearId is not null) AND LEN (@StyleSeasonYearId) > 0)
                            BEGIN
                                 SET @Completed = 1
                            END
                    END                    
                 
              IF  @Completed = 1
                  BEGIN

                        -- PRINT 'Updating stylequoteid: ' + CAST(@StyleQuoteItemId  as nvarchar(40)) + ' to styleseasonyear: ' + CAST(@StyleSeasonYearId as nvarchar(40))
                        UPDATE pStyleQuoteItem
                           SET StyleSeasonYearId = @StyleSeasonYearId
                         WHERE StyleQuoteItemId  = @StyleQuoteItemId                   
                  END

              -- Now get the Next Record
                   
              FETCH NEXT FROM QuoItem INTO @StyleQuoteItemId,@StyleId     
        END
        
CLOSE      QuoItem
DEALLOCATE QuoItem
