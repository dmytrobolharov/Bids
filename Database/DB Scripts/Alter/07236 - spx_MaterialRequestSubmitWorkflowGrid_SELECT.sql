IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGrid_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGrid_SELECT](@MaterialId uniqueidentifier)
AS 

SELECT uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName, ISNULL(pColorPalette.ColorName, pMaterialTradePartnerColor.ColorName) AS ColorName, 
	pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartner.MaterialTradePartnerId, pMaterial.MaterialID, 
	uTradePartner.TradePartnerID, uTradePartnerVendor.TradePartnerVendorID, pMaterial.MaterialNo, pMaterial.MaterialName, 
	pColorPalette.ColorCode, pMaterialTradePartnerColor.ColorNo, 
	pMaterialTradePartnerColor.VendorColorCode, pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, 
	pMaterialRequestWorkflow.MaterialRequestWorkflowID, 
	CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS NVARCHAR(40)) AS MaterialRequestSubmitWorkflowID, 
	vwx_MaterialSize_SEL.MaterialSize
INTO #tmpMaterialRequestSubmitWorkflow
FROM vwx_MaterialSize_SEL 
INNER JOIN  pMaterialTradePartnerColor 
INNER JOIN  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId 
INNER JOIN  uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID 
INNER JOIN  uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID 
INNER JOIN  pMaterial ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID ON   vwx_MaterialSize_SEL.MaterialSizeID = pMaterialTradePartnerColor.MaterialSizeID 
LEFT OUTER JOIN pMaterialColor ON pMaterialColor.MaterialColorID = pMaterialTradePartnerColor.MaterialColorID 
LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pMaterialColor.ColorPaletteID 
LEFT OUTER JOIN  pMaterialRequestWorkflow 
INNER JOIN pMaterialRequestSubmitWorkflow ON   pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON   pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
WHERE pMaterialTradePartner.MaterialId = @MaterialId
ORDER BY uTradePartnerVendor.VendorName, pColorPalette.ColorCode

-- changes to make grid sortable by workflow due date
-- for this we need to add duedate column for each workflow	
DECLARE @WorkflowColumns NVARCHAR(MAX),
		@DueDateColumns NVARCHAR(MAX)

SELECT @WorkflowColumns = QUOTENAME(MaterialRequestWorkflowID) + ISNULL(', ' + @WorkflowColumns, ''),
	@DueDateColumns = QUOTENAME(MaterialRequestWorkflowID + '_DueDate') + ISNULL(', ' + @DueDateColumns, '')
FROM (
	SELECT DISTINCT MaterialRequestWorkflowID
	FROM #tmpMaterialRequestSubmitWorkflow
	) t
ORDER BY MaterialRequestWorkflowID DESC

-- replace spx_Crosstab with double pivoting to get workflows and their due dates as columns
-- if there is no data - make pivoting on Dummy columns so the caller get at least empty table, otherwise it will return no datasource at all
declare @query as nvarchar(max) = '
SELECT * FROM (
	SELECT piv.*, mrsw.DueDate, MaterialRequestWorkflowID + ''_DueDate'' as Date
	FROM #tmpMaterialRequestSubmitWorkflow
	PIVOT(MAX(MaterialRequestSubmitWorkflowID) FOR MaterialRequestWorkflowID IN (' + ISNULL(@WorkflowColumns, 'DummyWorkflowColumn') + ')) piv
	INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON piv.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
) piv
PIVOT(MAX(DueDate) FOR Date IN (' + ISNULL(@DueDateColumns, 'DummyDueDateColumn') + ')) piv'

exec(@query)


--EXECUTE spx_Crosstab 
--'SELECT * FROM #tmpMaterialRequestSubmitWorkflow',
--NULL,
--NULL,
--'MaterialRequestWorkflowID',
--'MaterialRequestSubmitWorkflowID',
--'MAX'


DROP TABLE #tmpMaterialRequestSubmitWorkflow





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07236', GetDate())
GO
