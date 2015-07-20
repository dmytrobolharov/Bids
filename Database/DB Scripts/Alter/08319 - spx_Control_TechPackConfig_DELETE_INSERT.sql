IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_TechPackConfig_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_TechPackConfig_DELETE_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_TechPackConfig_DELETE_INSERT]
(@DivisionID UNIQUEIDENTIFIER)
AS
BEGIN

	-- delete 
    DELETE FROM pControlPredefinedTechPackConfig 
    WHERE DivisionID = @DivisionID AND StyleTypeID NOT IN 
    ( 
        SELECT st.StyleTypeID 
        FROM pStyleType st 
            INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID 
        WHERE dst.DivisionID = @DivisionID   
    ) 
  
  
    -- insert 
    CREATE TABLE #tmpTechPackConfig  
    ( 
        Row_ID INT IDENTITY (1,1), 
        StyleTypeID INT, 
        ReportTechPackFolderID UNIQUEIDENTIFIER 
    ) 
      
    INSERT INTO #tmpTechPackConfig (StyleTypeID, ReportTechPackFolderID) 
    SELECT st.StyleTypeID, rtpf.ReportTechPackFolderID 
    FROM pStyleType st 
        INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
        CROSS JOIN rReportTechPackFolder rtpf
    WHERE dst.DivisionID = @DivisionID   
      
    DECLARE @iRow INT
    DECLARE @iCount INT
    DECLARE @StyleTypeID INT
    DECLARE @ReportTechPackFolderID UNIQUEIDENTIFIER 
      
    SET @iRow = 1 
    SET @iCount = (SELECT COUNT(*) FROM #tmpTechPackConfig) 
      
    WHILE @iRow <= @iCount 
    BEGIN
      
        SELECT @StyleTypeID = StyleTypeID, @ReportTechPackFolderID = ReportTechPackFolderID FROM #tmpTechPackConfig WHERE Row_ID = @iRow 
          
        IF NOT EXISTS (SELECT * FROM pControlPredefinedTechPackConfig WHERE DivisionID = @DivisionID AND StyleTypeID = @StyleTypeID AND ReportTechPackFolderID = @ReportTechPackFolderID) 
        BEGIN
            INSERT INTO pControlPredefinedTechPackConfig (DivisionID, StyleTypeID, ReportTechPackFolderID) 
            SELECT @DivisionID, @StyleTypeID, @ReportTechPackFolderID 
        END
          
        SET @iRow = @iRow + 1 
      
    END
      
    DROP TABLE #tmpTechPackConfig 

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08319', GetDate())
GO
