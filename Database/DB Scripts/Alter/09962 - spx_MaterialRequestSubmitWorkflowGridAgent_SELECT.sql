IF OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT](
@TradePartnerID uniqueidentifier,
@FilterExp nvarchar(800),
@PageNo INT = NULL,
@PageSize INT = NULL,
@SortOrder NVARCHAR(MAX) = NULL
)
AS 

SELECT
	pMaterialTradePartnerColor.MaterialTradePartnerColorID
	, pMaterialTradePartner.MaterialTradePartnerId
	, pMaterial.MaterialID
	, uTradePartner.TradePartnerID
	, uTradePartnerVendor.TradePartnerVendorID
	, pMaterial.MaterialNo, pMaterial.MaterialName
	, pMaterialTradePartnerColor.ColorCode
	, pMaterialTradePartnerColor.ColorNo
	, pMaterialTradePartnerColor.ColorName
	, pMaterialTradePartnerColor.VendorColorCode
	, pMaterialTradePartnerColor.VendorColorNo
	, pMaterialTradePartnerColor.VendorColorName
	, uTradePartner.TradePartnerName
	, uTradePartnerVendor.VendorName
	, pMaterialRequestWorkflow.MaterialRequestWorkflowID
	, CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS NVARCHAR(40)) AS MaterialRequestSubmitWorkflowID
	, pMaterialRequestSubmitWorkflow.Status as SubmitStatus
	, pMaterialRequestWorkflow.GroupName
	, pMaterialRequestWorkflow.GroupID
	, vwx_MaterialSize_SEL.MaterialSize
INTO
	#tmpMaterialRequestSubmitWorkflow
FROM
	vwx_MaterialSize_SEL
	INNER JOIN pMaterialTradePartnerColor
		INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId
		INNER JOIN uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID
		INNER JOIN uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID
		INNER JOIN pMaterial ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID
	ON vwx_MaterialSize_SEL.MaterialSizeID = pMaterialTradePartnerColor.MaterialSizeID
	INNER JOIN pMaterialRequestWorkflow
		INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
	ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
WHERE
	pMaterialTradePartner.TradepartnerId = @TradePartnerID 
	AND uTradePartnerVendor.Active=1
	AND pMaterialTradePartnerColor.MaterialRequestShare=1
ORDER BY
	uTradePartnerVendor.VendorName
	, pMaterialTradePartnerColor.ColorCode
	
	
-- replace spx_Crosstab with PIVOT to support search by nvarchar fields
-- changes to make grid sortable by workflow due date
-- for this we need to add duedate column for each workflow	
DECLARE @WorkflowColumns NVARCHAR(MAX),
		@DueDateColumns NVARCHAR(MAX)
		
SELECT 
	@WorkflowColumns = QUOTENAME(MaterialRequestWorkflowID) + ISNULL(', ' + @WorkflowColumns, ''),
	@DueDateColumns = QUOTENAME(MaterialRequestWorkflowID + '_DueDate') + ISNULL(', ' + @DueDateColumns, '')
FROM pMaterialRequestWorkflow

-- replace spx_Crosstab with double pivoting to get workflows and their due dates as columns
DECLARE @selStr NVARCHAR(MAX)
SET @selStr = '
SELECT * INTO #tmp0 FROM (SELECT pvt.*, mrsw.DueDate, MaterialRequestWorkflowID + ''_DueDate'' as Date FROM
	(SELECT MaterialTradePartnerColorID, MaterialTradePartnerId, MaterialID, TradePartnerID, 
	TradePartnerVendorID, MaterialNo, MaterialName, ColorCode, ColorNo, ColorName, 
	VendorColorCode, VendorColorNo, VendorColorName, TradePartnerName, VendorName, 
	MaterialRequestWorkflowID, MaterialRequestSubmitWorkflowID, GroupName, GroupID, MaterialSize 
	FROM #tmpMaterialRequestSubmitWorkflow ' + @FilterExp + ') tbl
	PIVOT (MAX(MaterialRequestSubmitWorkflowID) FOR MaterialRequestWorkflowID IN (' + @WorkflowColumns + ')) pvt
	INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON pvt.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
) piv
PIVOT(MAX(DueDate) FOR Date IN (' + @DueDateColumns + ')) piv;'


DECLARE @sqlString  NVARCHAR(MAX) = @selStr + dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, NULL)
exec sp_executesql @sqlString


DROP TABLE #tmpMaterialRequestSubmitWorkflow
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09962', GetUTCDate())
GO

