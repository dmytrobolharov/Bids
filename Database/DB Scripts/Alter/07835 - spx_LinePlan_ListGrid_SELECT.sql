/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/03/2014 15:09:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_ListGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_ListGrid_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/03/2014 15:09:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LinePlan_ListGrid_SELECT] (  
@TeamID UNIQUEIDENTIFIER,  
@Filter NVARCHAR(4000),  
@Sort NVARCHAR(4000)  
)  
AS   
  
  
SELECT * INTO #tmp FROM pLinePlan  
  
DECLARE @SQL NVARCHAR(4000)   
SET @SQL  = 'SELECT  * FROM  #tmp '  
  
IF LEN (@Filter)  >  0   
 SET @SQL  = @SQL   + ' WHERE ' + @Filter  
  
IF LEN (@Sort)  >  0   
 SET @SQL  = @SQL   + ' ORDER BY ' + @Sort  
  
  
EXEC ( @SQL)   
  
DROP TABLE #tmp   
  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07835', GetDate())
GO