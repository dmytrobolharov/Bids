IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMGrid_Style_Tables_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMGrid_Style_Tables_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestBOMGrid_Style_Tables_SELECT]  (
@DevelopmentID nvarchar(50),
@StyleID nvarchar(50),
@TradePartnerAgentID nvarchar(50),
@TradePartnerVendorID nvarchar(50) = NULL,
@UserID INT,
@Filter nvarchar(4000) = NULL
)AS


CREATE TABLE #SampleRequestTrade (
SampleRequestTradeID UNIQUEIDENTIFIER , 
StyleSet INT
)


DECLARE @SQL AS NVARCHAR(4000) 

SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID, StyleSet  )
SELECT a.SampleRequestTradeID, a.StyleSet 
FROM pSampleRequestWorkflowBOM a 
INNER JOIN pSampleRequestBOMTrade c ON a.SampleRequestTradeID = c.SampleRequestTradeID 
INNER JOIN pSampleRequestShare srs ON a.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = ''' + @TradePartnerAgentID + ''' 
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON c.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID '

IF @StyleID  IS  NULL 
	SET @SQL  = @SQL  + ' WHERE a.StyleID IN (SELECT StyleID FROM  pStyleDevelopmentItem WHERE StyleDevelopmentID  = ''' + @DevelopmentID  + ''' )  '
ELSE
	SET @SQL = @SQL  + ' WHERE a.StyleID = ''' +  @StyleID + ''''
	
IF @Filter IS NOT NULL
	SET @SQL = @SQL + ' AND ' + @Filter

IF @UserID IS NOT NULL 
	SET @SQL = @SQL  + ' AND a.AssignedTo  =  ' + CAST (@UserID AS NVARCHAR(50))


IF @TradePartnerAgentID IS NOT NULL 
	SET @SQL  = @SQL  + ' AND ''' + @TradePartnerAgentID  + ''' IN (tpm.AgentID, tpm.VendorID, tpm.FactoryID)'

SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID, a.StyleSet 	'

EXEC (@SQL)


SELECT a.SampleRequestTradeID  , c.Description , 
CASE 
	WHEN FOO.StyleSet = 1 THEN 
		CASE WHEN c.PC1 Is Not Null THEN c.PC1 ELSE '1st Set' END
	WHEN FOO.StyleSet = 2 THEN 
		CASE WHEN c.PC2 Is Not Null THEN c.PC2 ELSE '2nd Set' END
	WHEN FOO.StyleSet = 3 THEN 
		CASE WHEN c.PC3 Is Not Null THEN c.PC3 ELSE '3rd Set' END
	WHEN FOO.StyleSet = 4 THEN 
		CASE WHEN c.PC4 Is Not Null THEN c.PC4 ELSE '4th Set' END 
END AS StyleSetName , FOO.StyleSet , d.TradePartnerName , NULL as VendorName,
ISNULL(e.ItemDim1Name,'') AS Dim1,  
ISNULL(f.ItemDim2Name,'') AS Dim2,  
ISNULL(g.ItemDim3Name,'') AS Dim3,  
c.StyleNo , c.DueDate as TechPack , c.SizeClass , c.TechPackID, 
a.WorkFlowItemID, a.StyleBOMDimensionID, a.StyleBOMDimensionItemID, 
tpm.AgentID, tpm.VendorID, tpm.FactoryID, 
tpm.AgentName as NPM_AgentName, tpm.VendorName as NPM_VendorName, tpm.FactoryName as NPM_FactoryName
FROM pSampleRequestBOMTrade a
INNER JOIN #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID
INNER JOIN pSampleRequestShare srs ON a.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerAgentID
INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID
INNER JOIN uTradePartner d ON a.TradePartnerID =  d.TradePartnerID
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON a.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
LEFT OUTER JOIN pStyleBOMDimensionItem e ON a.ItemDim1ID=e.ItemDim1ID AND a.StyleBOMDimensionID = e.StyleBOMDimensionID
LEFT OUTER JOIN pStyleBOMDimensionItem f ON a.ItemDim2ID=f.ItemDim2ID AND a.StyleBOMDimensionID = f.StyleBOMDimensionID
LEFT OUTER JOIN pStyleBOMDimensionItem g ON a.ItemDim3ID=g.ItemDim3ID AND a.StyleBOMDimensionID = g.StyleBOMDimensionID
ORDER BY tpm.AgentName, tpm.VendorName, tpm.FactoryName, StyleNo, FOO.StyleSet, Dim1, Dim2, Dim3 


IF @UserID IS NULL 
BEGIN
	SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort
	FROM pSampleRequestWorkflowBOM a
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID 
	INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID
	ORDER BY c.SampleWorkflowSort


	SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.Status, 
	a.StyleSet, c.ApprovedType, t.Custom AS PartnerType, ISNULL(t.CustomKey, 1) AS PartnerOwner
	FROM pSampleRequestWorkflowBOM a
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet
	INNER JOIN pSampleRequestSubmitStatus c ON a.Status  = c.StatusID 
	LEFT JOIN uTradePartnerType t ON a.SampleWorkflowPartnerTypeID = t.CustomId
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
	a.StyleSet, c.ApprovedType, t.Custom AS PartnerType, ISNULL(t.CustomKey, 1) AS PartnerOwner
	FROM pSampleRequestWorkflowBOM a 
	INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet
	INNER JOIN pSampleRequestSubmitStatus c ON a.Status  = c.StatusID 
	LEFT JOIN uTradePartnerType t ON a.SampleWorkflowPartnerTypeID = t.CustomId
	WHERE a.AssignedTo  =  @UserID 

END 

DROP TABLE #SampleRequestTrade 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06240', GetDate())
GO
