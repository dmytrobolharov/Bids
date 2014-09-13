IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMGrid_Style_Tables_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMGrid_Style_Tables_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMGrid_Style_Tables_SELECT]  (
@DevelopmentID nvarchar(50),
@StyleID nvarchar(50),
@TradePartnerAgentID nvarchar(50),
@TradePartnerVendorID nvarchar(50),
@UserID INT 
)AS


CREATE TABLE #SampleRequestTrade (
SampleRequestTradeID UNIQUEIDENTIFIER , 
StyleSet INT
)


DECLARE @SQL AS NVARCHAR(4000) 

SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID, StyleSet  )
SELECT a.SampleRequestTradeID, a.StyleSet 
FROM pSampleRequestWorkflowBOM a '

IF @StyleID  IS  NULL 
	SET @SQL  = @SQL  + ' WHERE StyleID IN (SELECT StyleID FROM  pStyleDevelopmentItem WHERE StyleDevelopmentID  = ''' + @DevelopmentID  + ''' )  '
ELSE
	SET @SQL = @SQL  + ' WHERE StyleID = ''' +  @StyleID + ''''

IF @UserID IS NOT NULL 
	SET @SQL = @SQL  + ' AND AssignedTo  =  ' + CAST (@UserID AS NVARCHAR(50))


IF @TradePartnerAgentID IS NOT NULL 
	SET @SQL  = @SQL  + ' AND a.TradePartnerID = ''' + @TradePartnerAgentID  + ''''

IF @TradePartnerVendorID IS NOT NULL
	SET @SQL  = @SQL  + ' AND a.TradePartnerVendorID = ''' + @TradePartnerVendorID  + ''''

SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID, a.StyleSet 	'

EXEC (@SQL)


SELECT a.SampleRequestTradeID  , b.VendorName  , c.Description , 
CASE 
	WHEN FOO.StyleSet = 1 THEN 
		CASE WHEN c.PC1 Is Not Null THEN c.PC1 ELSE '1st Set' END
	WHEN FOO.StyleSet = 2 THEN 
		CASE WHEN c.PC2 Is Not Null THEN c.PC2 ELSE '2nd Set' END
	WHEN FOO.StyleSet = 3 THEN 
		CASE WHEN c.PC3 Is Not Null THEN c.PC3 ELSE '3rd Set' END
	WHEN FOO.StyleSet = 4 THEN 
		CASE WHEN c.PC4 Is Not Null THEN c.PC4 ELSE '4th Set' END 
END AS StyleSetName , FOO.StyleSet , d.TradePartnerName ,
ISNULL(Convert(VARCHAR(50),e.ItemDim1Name),'NA') AS Dim1,  
ISNULL(Convert(VARCHAR(50),f.ItemDim2Name),'NA') AS Dim2,  
ISNULL(Convert(VARCHAR(50),g.ItemDim3Name),'NA') AS Dim3,  
c.StyleNo , c.DueDate as TechPack , c.SizeClass , a.TechPackID, 
a.WorkFlowItemID, a.StyleBOMDimensionID, a.StyleBOMDimensionItemID, 
NULL as NPM_AgentName, NULL as NPM_VendorName, NULL as NPM_FactoryName
FROM pSampleRequestBOMTrade a
INNER JOIN  #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID
INNER JOIN uTradePartnerVendor b ON a.TradePartnerVendorID =  b.TradePartnerVendorID
INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID
INNER JOIN uTradePartner d ON a.TradePartnerID =  d.TradePartnerID
LEFT OUTER JOIN pStyleBOMDimensionItem e ON e.ItemDim1ID=a.ItemDim1ID
LEFT OUTER JOIN pStyleBOMDimensionItem f ON f.ItemDim2ID=a.ItemDim2ID
LEFT OUTER JOIN pStyleBOMDimensionItem g ON g.ItemDim3ID=a.ItemDim3ID
ORDER BY VendorName, StyleNo, FOO.StyleSet, Dim1, Dim2, Dim3 


IF @UserID IS NULL 
BEGIN
	SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort
	FROM pSampleRequestWorkflowBOM a
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID 
	INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID
	ORDER BY c.SampleWorkflowSort


	SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.Status, 
	a.StyleSet, c.ApprovedType
	FROM pSampleRequestWorkflowBOM a
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet
	INNER JOIN pSampleRequestSubmitStatus c ON a.Status  = c.StatusID 
END 
ELSE 
BEGIN 

	SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort
	FROM pSampleRequestWorkflowBOM a
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID 
	INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID
	WHERE a.AssignedTo  =  @UserID 
	ORDER BY c.SampleWorkflowSort

	SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.Status, 
	a.StyleSet, c.ApprovedType
	FROM pSampleRequestWorkflowBOM a 
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet
	INNER JOIN pSampleRequestSubmitStatus c ON a.Status  = c.StatusID 
	WHERE a.AssignedTo  =  @UserID 

END 


DROP TABLE #SampleRequestTrade 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05566', GetDate())
GO
