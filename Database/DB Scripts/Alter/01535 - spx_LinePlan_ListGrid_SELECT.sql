IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_LinePlan_ListGrid_SELECT') 
	DROP PROCEDURE spx_LinePlan_ListGrid_SELECT
GO


CREATE PROCEDURE [dbo].[spx_LinePlan_ListGrid_SELECT] (  
@TeamID UNIQUEIDENTIFIER,  
@Filter NVARCHAR(4000),  
@Sort NVARCHAR(4000)  
)  
AS   
  
  
SELECT * INTO #tmp FROM  pLinePlan  
WHERE LinePlanTemplateID  in (   
 SELECT DISTINCT LinePlanTemplateID  FROM  dbo.sAccessGroupLinePlanFolder  
 WHERE (AccessRoleID = 3 OR AccessPlanView = 1 OR AccessHierView = 1  )  
 AND GroupID IN (  
  SELECT GroupID FROM dbo.uUserGroup WHERE TeamID = @TeamID  
 ) --and Active = 1 
)  
  
  
DECLARE @SQL NVARCHAR(4000)   
SET @SQL  = 'SELECT  * FROM  #tmp '  
  
IF LEN (@Filter)  >  0   
 SET @SQL  = @SQL   + ' WHERE ' + @Filter  
  
IF LEN (@Sort)  >  0   
 SET @SQL  = @SQL   + ' ORDER BY ' + @Sort  
  
  
EXEC ( @SQL)   
  
DROP TABLE #tmp   

Go
  
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01535', GetDate())
GO
  
  
  
  
  