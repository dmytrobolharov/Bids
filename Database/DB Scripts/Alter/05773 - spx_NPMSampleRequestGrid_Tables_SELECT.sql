/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestGrid_Tables_SELECT]    Script Date: 05/27/2013 15:24:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestGrid_Tables_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestGrid_Tables_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_NPMSampleRequestGrid_Tables_SELECT] (  
@TradePartnerID nvarchar(50),  
@sqlSelect varchar(8000) = NULL,  
@TeamID varchar (50) = NULL   
)  
AS  

  
CREATE TABLE #SampleRequestTrade (  
SampleRequestTradeID UNIQUEIDENTIFIER ,   
StyleSet INT  
)  
  
  
DECLARE @SQL AS NVARCHAR(4000)   
SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID, StyleSet  )  
SELECT a.SampleRequestTradeID, a.StyleSet   
FROM pSampleRequestWorkflow a 
INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID   
INNER JOIN pSampleRequestTrade c ON a.SampleRequestTradeID = c.SampleRequestTradeID   
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON c.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID 
WHERE 1=1   
'  
  
  
IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' AND a.TradePartnerID IN (tpm.AgentID, tpm.VendorID, tpm.FactoryID) '
IF @sqlSelect IS NOT NULL  
 SET @SQL  = @SQL  + ' AND a.SampleRequestTradeID IN (' + @sqlSelect + ') '  
IF @TeamID IS NOT NULL    
 SET @SQL  = @SQL  + ' AND b.StyleType IN  (  SELECT StyleTypeID FROM sAccessStyleFolder WHERE TeamId = ''' +  CAST (@TeamID AS NVARCHAR(50))  + ''' AND (AccessRoleId = 3 OR AccessView = 1) ) '   
SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID, a.StyleSet  '  
EXEC (@SQL)  

  
SET @SQL  ='  
 SELECT a.SampleRequestTradeID  , b.TradePartnerName as VendorName  , c.Description ,   
 CASE   
  WHEN FOO.StyleSet = 1 THEN   
   CASE WHEN c.PC1 Is Not Null THEN c.PC1 ELSE ''1st Set'' END  
  WHEN FOO.StyleSet = 2 THEN   
   CASE WHEN c.PC2 Is Not Null THEN c.PC2 ELSE ''2nd Set'' END  
  WHEN FOO.StyleSet = 3 THEN   
   CASE WHEN c.PC3 Is Not Null THEN c.PC3 ELSE ''3rd Set'' END  
  WHEN FOO.StyleSet = 4 THEN   
   CASE WHEN c.PC4 Is Not Null THEN c.PC4 ELSE ''4th Set'' END   
 END AS StyleSetName , FOO.StyleSet , b.TradePartnerName ,  
 ISNULL(e.MainColor,''NA'') AS Color ,  c.StyleNo , c.DueDate as TechPack , c.SizeClass , a.TechPackID, c.SizeRange,  
 tpm.AgentID, tpm.VendorID, tpm.FactoryID, tpm.AgentName as NPM_AgentName, tpm.VendorName as NPM_VendorName, tpm.FactoryName as NPM_FactoryName 
 FROM pSampleRequestTrade a  
 INNER JOIN  #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID  
 INNER JOIN pSampleRequestShare srs ON a.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = ''' + @TradePartnerID + ''' 
 INNER JOIN uTradePartner b ON a.TradePartnerID =  b.TradePartnerID  
 INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID   
 INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON a.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID 
 LEFT OUTER JOIN pStyleColorway e ON a.StyleColorID  = e.StyleColorID  
'  
IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' WHERE a.TradePartnerID IN (tpm.AgentID, tpm.VendorID, tpm.FactoryID) '  
   
SET @SQL  = @SQL  +  ' ORDER BY TradePartnerName, StyleNo, FOO.StyleSet , Color  '  
  
EXEC (@SQL)  
  
  
  
SET @SQL  = 'SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort  
  FROM pSampleRequestWorkflow a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID   
  INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID  
  '  
IF @TeamID  IS  NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE a.SampleWorkflowID IN  (   
   SELECT SampleTypeId from sAccessSampleFolder WHERE TeamId = ''' + @TeamID  + ''' AND (AccessRoleId=3 OR AccessView=1 )   
  )  
  '   
SET @SQL  = @SQL  +  ' ORDER BY c.SampleWorkflowSort ;    
  
  SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.FinalDate, a.DueDate, a.Status,   
  a.StyleSet, c.ApprovedType, t.Custom AS PartnerType, ISNULL(t.CustomKey, 1) AS PartnerOwner 
  FROM pSampleRequestWorkflow a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet  
  INNER JOIN pSampleRequestSubmitStatus c ON  c.StatusID = a.Status 
  LEFT JOIN uTradePartnerType t ON a.SampleWorkflowPartnerTypeID = t.CustomId 
  '   
  
IF @TeamID IS NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE a.SampleWorkflowID IN  (   
   SELECT SampleTypeId from sAccessSampleFolder WHERE TeamId = ''' + @TeamID  + '''  AND (AccessRoleId=3 OR AccessView=1 )   
  ) '  
EXEC (@SQL)  
   
DROP TABLE #SampleRequestTrade   


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05773', GetDate())
GO
