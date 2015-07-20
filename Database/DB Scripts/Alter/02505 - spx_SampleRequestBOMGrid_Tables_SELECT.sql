
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMGrid_Tables_SELECT]    Script Date: 12/23/2011 00:07:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMGrid_Tables_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMGrid_Tables_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMGrid_Tables_SELECT]    Script Date: 12/23/2011 00:07:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMGrid_Tables_SELECT]    Script Date: 12/22/2011 19:35:13 ******/

CREATE  PROCEDURE [dbo].[spx_SampleRequestBOMGrid_Tables_SELECT] (  
@TradePartnerID nvarchar(50),  
@sqlSelect varchar(8000) = NULL,  
@TeamID varchar (50) = NULL   
)  
AS  
  
  
CREATE TABLE #SampleRequestTrade (  
StyleID NVARCHAR(50),
SampleRequestTradeID UNIQUEIDENTIFIER ,   
StyleSet INT  
)  
  
  
DECLARE @SQL AS NVARCHAR(4000)   
SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID,StyleID,StyleSet  )  
SELECT a.SampleRequestTradeID,a.StyleID, a.StyleSet   
FROM pSampleRequestWorkflowBOM a INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID   
WHERE 1=1   
'  

IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' AND a.TradePartnerID = ''' + @TradePartnerID  + ''''  
IF @sqlSelect IS NOT NULL  
 SET @SQL  = @SQL  + ' AND a.SampleRequestTradeID IN (' + @sqlSelect + ') '  
IF @TeamID IS NOT NULL    
 SET @SQL  = @SQL  + ' AND b.StyleType IN  (  SELECT StyleTypeID FROM sAccessStyleFolder WHERE TeamId = ''' +  CAST (@TeamID AS NVARCHAR(50))  + ''' AND (AccessRoleId = 3 OR AccessView = 1) ) '   
SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID,a.StyleID,a.StyleSet  '  

EXEC (@SQL)   

SET @SQL  ='  
 SELECT a.SampleRequestTradeID,FOO.StyleID,b.VendorName  , c.Description ,    
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
 ISNULL(Convert(VARCHAR(50),e.ItemDim1Name),''NA'') AS Dim1,  
 ISNULL(Convert(VARCHAR(50),f.ItemDim2Name),''NA'') AS Dim2,  
 ISNULL(Convert(VARCHAR(50),g.ItemDim3Name),''NA'') AS Dim3,  
 c.StyleNo , c.DueDate as TechPack , 
 c.SizeClass , 
 a.TechPackID, 
 c.SizeRange  
 FROM pSampleRequestBOMTrade a  
 INNER JOIN  #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID  
 INNER JOIN uTradePartnerVendor b ON a.TradePartnerVendorID =  b.TradePartnerVendorID  
 INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID  
 INNER JOIN uTradePartner d ON a.TradePartnerID =  d.TradePartnerID 
 LEFT OUTER JOIN pStyleBOMDimensionItem e ON e.StyleBOMDimensionItemID=a.ItemDim1ID
 LEFT OUTER JOIN pStyleBOMDimensionItem f ON f.StyleBOMDimensionItemID=a.ItemDim2ID
 LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.StyleBOMDimensionItemID=a.ItemDim3ID
'  


IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' WHERE a.TradePartnerID = ''' + @TradePartnerID + '''  '  
   
SET @SQL  = @SQL  +  ' ORDER BY VendorName, StyleNo, FOO.StyleSet ,Dim1,Dim2,Dim3,FOO.StyleID '  
  
EXEC (@SQL)  
  
  
SET @SQL  = 'SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort  
  FROM pSampleRequestWorkflowBOM a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID   
  INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID  
  '  

IF @TeamID  IS  NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE a.SampleWorkflowID IN  (   
   SELECT SampleTypeId from sAccessSampleFolder WHERE TeamId = ''' + @TeamID  + ''' AND (AccessRoleId=3 OR AccessView=1 )   
  )  
  '   
  
SET @SQL  = @SQL  +  ' ORDER BY c.SampleWorkflowSort ;    
  
  SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.Status,   
  a.StyleSet, c.ApprovedType  
  FROM pSampleRequestSubmitBOM a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet  
  INNER JOIN pSampleRequestSubmitStatus c ON  c.StatusID = a.Status
  '     
  
IF @TeamID IS NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE a.SampleWorkflowID IN  (   
   SELECT SampleTypeId from sAccessSampleFolder WHERE TeamId = ''' + @TeamID  + '''  AND (AccessRoleId=3 OR AccessView=1 )   
  ) '  
EXEC (@SQL)  
   
DROP TABLE #SampleRequestTrade      




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02505'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02505', GetDate())
END

GO

