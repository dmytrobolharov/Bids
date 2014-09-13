  
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 9 June 2011                                                                                */
-- * WorkItem#2850                                                                                          */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_ListGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_ListGrid_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE spx_LinePlan_ListGrid_SELECT (  
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
  
 GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01668', GetDate())

GO 
  
  
  
  
  