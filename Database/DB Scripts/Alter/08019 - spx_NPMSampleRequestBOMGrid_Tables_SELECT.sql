/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestBOMGrid_Tables_SELECT]    Script Date: 06/17/2014 13:11:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMGrid_Tables_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMGrid_Tables_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestBOMGrid_Tables_SELECT]    Script Date: 06/17/2014 13:11:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_NPMSampleRequestBOMGrid_Tables_SELECT] (  
@TradePartnerID nvarchar(50),  
@sqlSelect nvarchar (max) = NULL,  
@TeamID nvarchar (50) = NULL   
)  
AS 

 
  
CREATE TABLE #SampleRequestTrade (  
StyleID NVARCHAR(50),
SampleRequestTradeID UNIQUEIDENTIFIER ,   
StyleSet INT,
StyleTypeID INT
)  
  
  
DECLARE @SQL AS NVARCHAR(4000)   
SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID,StyleID,StyleSet, StyleTypeID  )  
SELECT distinct a.SampleRequestTradeID,a.StyleID, a.StyleSet, b.StyleType  
FROM pSampleRequestWorkflowBOM a 
INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID   
INNER JOIN pSampleRequestBOMTrade c ON a.SampleRequestTradeID = c.SampleRequestTradeID   
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON c.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID 
WHERE 1=1   
'  

IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' AND a.TradePartnerID IN (tpm.AgentID, tpm.VendorID, tpm.FactoryID) '  
IF @sqlSelect IS NOT NULL  
 SET @SQL  = @SQL  + ' AND a.SampleRequestTradeID IN (' + @sqlSelect + ') '  
IF @TeamID IS NOT NULL    
 SET @SQL  = @SQL  + ' AND StyleType IN (SELECT ProductTypeId FROM fnx_Permissions_GetIntProductTypePermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 2) 
							WHERE ( PermissionRoleId =3 OR PermissionView = 1 ) ) '
SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID,a.StyleID,a.StyleSet, b.StyleType  '  

EXEC (@SQL) 

SET @SQL  ='  
 SELECT distinct a.SampleRequestTradeID, FOO.StyleID, c.Description ,    
 CASE   
  WHEN FOO.StyleSet = 1 THEN   
   CASE WHEN c.PC1 Is Not Null THEN c.PC1 ELSE ''1st Set'' END  
  WHEN FOO.StyleSet = 2 THEN   
   CASE WHEN c.PC2 Is Not Null THEN c.PC2 ELSE ''2nd Set'' END  
  WHEN FOO.StyleSet = 3 THEN   
   CASE WHEN c.PC3 Is Not Null THEN c.PC3 ELSE ''3rd Set'' END  
  WHEN FOO.StyleSet = 4 THEN   
   CASE WHEN c.PC4 Is Not Null THEN c.PC4 ELSE ''4th Set'' END   
 END AS StyleSetName , FOO.StyleSet ,   
 ISNULL(e.ItemDim1Name,'''') AS Dim1,  
 ISNULL(f.ItemDim2Name,'''') AS Dim2,  
 ISNULL(g.ItemDim3Name,'''') AS Dim3,  
 c.StyleNo , c.DueDate as TechPack , 
 c.SizeClass , 
 a.TechPackID, 
 c.SizeRange,
 a.WorkFlowItemID,
 w.WorkFlowItemName,
 a.StyleBOMDimensionID,
 a.StyleBOMDimensionItemID, 
 b.TradePartnerName, NULL as VendorName,
 tpm.AgentID, tpm.VendorID, tpm.FactoryID, 
 tpm.AgentName as NPM_AgentName, tpm.VendorName as NPM_VendorName, tpm.FactoryName as NPM_FactoryName
 FROM pSampleRequestBOMTrade a  
 INNER JOIN #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID  
 INNER JOIN pSampleRequestShare srs ON a.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = ''' + @TradePartnerID + ''' 
 INNER JOIN uTradePartner b ON a.TradePartnerID =  b.TradePartnerID  
 INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID  
 INNER JOIN pWorkFlowItem w ON a.WorkFlowItemID = w.WorkFlowItemID
 INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON a.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
 LEFT OUTER JOIN pStyleBOMDimensionItem e ON e.ItemDim1ID=a.ItemDim1ID AND a.StyleBOMDimensionID = e.StyleBOMDimensionID 
 LEFT OUTER JOIN pStyleBOMDimensionItem f ON f.ItemDim2ID=a.ItemDim2ID AND a.StyleBOMDimensionID = f.StyleBOMDimensionID 
 LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.ItemDim3ID=a.ItemDim3ID AND a.StyleBOMDimensionID = g.StyleBOMDimensionID
'  


IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' WHERE a.TradePartnerID IN (tpm.AgentID, tpm.VendorID, tpm.FactoryID) '  
   
SET @SQL  = @SQL  +  ' ORDER BY tpm.AgentName, tpm.VendorName, tpm.FactoryName, StyleNo, FOO.StyleSet ,Dim1,Dim2,Dim3,FOO.StyleID '  
  
EXEC (@SQL)  
  
SET @SQL  = 'SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort  
  FROM pSampleRequestWorkflowBOM a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID   
  INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID  
  '  

IF @TeamID  IS  NOT NULL   
	SET @SQL = @SQL + ' INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 5, NULL) acc 
						ON acc.WorkflowID = c.SampleWorkflowGUID AND acc.ProductTypeID = b.StyleTypeID 
						WHERE acc.PermissionRoleID = 3 OR acc.PermissionView = 1'
 
SET @SQL  = @SQL  +  ' ORDER BY c.SampleWorkflowSort ;    
  
  SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.FinalDate, a.Status,   
  a.StyleSet, c.ApprovedType, t.Custom AS PartnerType, ISNULL(t.CustomKey, 1) AS PartnerOwner
  FROM pSampleRequestWorkflowBOM  a  INNER JOIN
  pSampleWorkflow w ON w.SampleWorkflowID = a.SampleWorkflowID
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet  
  INNER JOIN pSampleRequestSubmitStatus c ON  c.StatusID = a.Status 
  LEFT JOIN uTradePartnerType t ON a.SampleWorkflowPartnerTypeID = t.CustomId
  '     
  
IF @TeamID IS NOT NULL   
	SET @SQL = @SQL + ' INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(''' + CAST(@TeamID AS NVARCHAR(40)) + ''', 5, NULL) acc 
						ON acc.WorkflowID = w.SampleWorkflowGUID AND acc.ProductTypeID = b.StyleTypeID 
						WHERE acc.PermissionRoleID = 3 OR acc.PermissionView = 1'
EXEC (@SQL)  
      
DROP TABLE #SampleRequestTrade      






GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08019', GetDate())
GO