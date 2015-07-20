IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_StyleConfig_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_StyleConfig_DELETE_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_StyleConfig_DELETE_INSERT]
	@DivisionID UNIQUEIDENTIFIER
AS
BEGIN

-- delete 
    DELETE FROM pControlStyleConfig 
    WHERE DivisionID = @DivisionID AND StyleTypeID NOT IN 
    ( 
        SELECT st.StyleTypeID 
        FROM pStyleType st 
            INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID 
        WHERE dst.DivisionID = @DivisionID   
    ) 
  
  
    -- insert 
    CREATE TABLE #tmpStyleConfig  
    ( 
        Row_ID INT IDENTITY (1,1), 
        StyleTypeID INT, 
        StyleCategoryID UNIQUEIDENTIFIER 
    ) 
      
    INSERT INTO #tmpStyleConfig (StyleTypeID, StyleCategoryID) 
    SELECT st.StyleTypeID, scst.StyleCategoryId 
    FROM pStyleType st 
        INNER JOIN pStyleCategoryStyleType scst ON st.StyleTypeID = scst.StyleTypeID 
        INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID 
    WHERE dst.DivisionID = @DivisionID   
      
    DECLARE @iRow INT
    DECLARE @iCount INT
    DECLARE @StyleTypeID INT
    DECLARE @StyleCategoryID UNIQUEIDENTIFIER 
      
    SET @iRow = 1 
    SET @iCount = (SELECT COUNT(*) FROM #tmpStyleConfig) 
      
    WHILE @iRow <= @iCount 
    BEGIN
      
        SELECT @StyleTypeID = StyleTypeID, @StyleCategoryID = StyleCategoryID FROM #tmpStyleConfig WHERE Row_ID = @iRow 
          
        IF NOT EXISTS (SELECT * FROM pControlStyleConfig WHERE DivisionID = @DivisionID AND StyleTypeID = @StyleTypeID AND StyleCategoryID = @StyleCategoryID) 
        BEGIN
            INSERT INTO pControlStyleConfig (DivisionID, StyleTypeID, StyleCategoryID) 
            SELECT @DivisionID, @StyleTypeID, @StyleCategoryID 
        END
          
        SET @iRow = @iRow + 1 
      
    END
      
    DROP TABLE #tmpStyleConfig 
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08014', GetDate())
GO
