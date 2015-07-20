/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGridAccess_Tables_SELECT]    Script Date: 06/16/2014 18:13:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestGridAccess_Tables_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestGridAccess_Tables_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestGridAccess_Tables_SELECT]    Script Date: 06/16/2014 18:13:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE  PROCEDURE [dbo].[spx_SampleRequestGridAccess_Tables_SELECT] (  
@TradePartnerID nvarchar(50),  
@sqlSelect nvarchar(MAX) = NULL,  
@TeamID nvarchar (50) = NULL   
)  
AS  
  
  
CREATE TABLE #SampleRequestTrade (  
SampleRequestTradeID UNIQUEIDENTIFIER ,   
StyleSet INT ,
StyleTypeID INT
)  
  
  
DECLARE @SQL AS NVARCHAR(4000)   
SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID, StyleSet, StyleTypeID  )  
SELECT a.SampleRequestTradeID, a.StyleSet, b.StyleType 
FROM pSampleRequestWorkflow a INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID   
WHERE 1=1   
'  
  
  
IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' AND a.TradePartnerID = ''' + @TradePartnerID  + ''''  
IF @sqlSelect IS NOT NULL  
 SET @SQL  = @SQL  + ' AND a.SampleRequestTradeID IN (' + @sqlSelect + ') '  
IF @TeamID IS NOT NULL    
  SET @SQL  = @SQL  + ' AND StyleType IN (SELECT ProductTypeId FROM fnx_Permissions_GetIntProductTypePermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 2) 
							WHERE ( PermissionRoleId =3 OR PermissionView = 1 ) ) 
        AND a.SampleWorkflowID  IN ( SELECT DISTINCT SampleWorkflowId   from pSampleWorkflowViewSubmit WHERE TeamId = ''' + CAST(@TeamID AS NVARCHAR(40)) + '''  )  
'   
  
SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID, a.StyleSet, b.StyleType  '  
  
--print (@SQL)  
EXEC (@SQL)  
  
  
SET @SQL  ='  
 SELECT a.SampleRequestTradeID  , b.VendorName  , c.Description ,    
 CASE   
  WHEN FOO.StyleSet = 1 THEN   
   CASE WHEN c.PC1 Is Not Null THEN c.PC1 ELSE ''1st Set'' END  
  WHEN FOO.StyleSet = 2 THEN   
   CASE WHEN c.PC2 Is Not Null THEN c.PC2 ELSE ''2nd Set'' END  
  WHEN FOO.StyleSet = 3 THEN   
   CASE WHEN c.PC3 Is Not Null THEN c.PC3 ELSE ''3rd Set'' END  
  WHEN FOO.StyleSet = 4 THEN   
   CASE WHEN c.PC4 Is Not Null THEN c.PC4 ELSE ''4th Set'' END   
 END AS StyleSetName , FOO.StyleSet , d.TradePartnerName ,  
 ISNULL(e.MainColor,''NA'') AS Color ,  c.StyleNo , c.DueDate as TechPack , c.SizeClass , a.TechPackID, c.SizeRange  
 FROM pSampleRequestTrade a  
 INNER JOIN  #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID  
 INNER JOIN uTradePartnerVendor b ON a.TradePartnerVendorID =  b.TradePartnerVendorID  
 INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID  
 INNER JOIN uTradePartner d ON a.TradePartnerID =  d.TradePartnerID  
 LEFT OUTER JOIN pStyleColorway e ON a.StyleColorID  = e.StyleColorID   
'  
IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' WHERE a.TradePartnerID = ''' + @TradePartnerID + '''  '  
   
SET @SQL  = @SQL  +  ' ORDER BY VendorName, StyleNo, FOO.StyleSet , Color  '  
  
EXEC (@SQL)  
  
SET @SQL  = 'SELECT DISTINCT c.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort  
  FROM pSampleWorkflow c   
  '  
IF @TeamID  IS  NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE c.SampleWorkflowGUID IN  (   
   SELECT WorkflowID FROM fnx_Permissions_GetIntProductType_WorkflowPermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 5, NULL) WHERE PermissionRoleID = 3 OR PermissionView = 1
  )  
  AND c.SampleWorkflowID  IN ( SELECT DISTINCT SampleWorkflowId   from pSampleWorkflowViewSubmit WHERE TeamId = ''' + @TeamID + '''  )  
  '   
SET @SQL  = @SQL  +  ' ORDER BY c.SampleWorkflowSort ;   '  
  
--print (@SQL)  
  
  
SET @SQL  = @SQL  +  ' SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.Status,   
  a.StyleSet, c.ApprovedType, c.Status as StatusName  
  FROM pSampleRequestWorkflow a  INNER JOIN
  pSampleWorkflow w ON w.SampleWorkflowID = a.SampleWorkflowID
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet  
  INNER JOIN pSampleRequestSubmitStatus c ON  c.StatusID = a.Status  
  '   
  
IF @TeamID IS NOT NULL   
 SET @SQL  = @SQL  + ' WHERE w.SampleWorkflowGUID IN  (   
   SELECT WorkflowID FROM fnx_Permissions_GetIntProductType_WorkflowPermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 5, b.StyleTypeID) WHERE PermissionRoleID = 3 OR PermissionView = 1 
  ) 
       AND a.SampleWorkflowID  IN ( SELECT DISTINCT SampleWorkflowId     
        from pSampleWorkflowViewSubmit WHERE TeamId = ''' + @TeamID + '''  )  
  '  
  
  
EXEC (@SQL)  
   
DROP TABLE #SampleRequestTrade   
  
  
  
  
  
  
set ANSI_NULLS ON  
set QUOTED_IDENTIFIER ON  



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08028', GetDate())
GO
