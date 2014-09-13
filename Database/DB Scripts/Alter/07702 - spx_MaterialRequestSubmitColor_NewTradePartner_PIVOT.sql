IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT]
GO



CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT](
@MaterialTradePartnerID uniqueidentifier
)
AS 


SELECT f.MaterialTradePartnerColorID, g.MaterialTradePartnerId, j.MaterialID, 
      i.TradePartnerID, j.MaterialNo, j.MaterialName, 
      e.ColorCode, 
      f.ColorNo, 
      e.ColorName, 
      f.VendorColorCode, f.VendorColorNo, f.VendorColorName, 
      i.TradePartnerName, c.MaterialRequestWorkflowID,
      tpm.AgentID, tpm.VendorID, tpm.FactoryID,
      tpm.AgentName, tpm.VendorName, tpm.FactoryName,
	  CAST(a.MaterialRequestSubmitWorkflowID AS nVARCHAR(40)) AS MaterialRequestSubmitWorkflowID, 
      --c.GroupName, c.GroupID,
	Case  
		WHEN f.MaterialColorImageID IS NULL  THEN 
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + '../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(f.ColorFolderID AS nVARCHAR(40)) + 
			'&CPID=' + CAST(f.ColorPaletteID AS nVARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
		 ELSE  
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + '../System/Control/ImageStream.ashx?S=16&V=' + CAST(f.MaterialColorImageVersion AS nVARCHAR(40)) + 
			'&IID=' + CAST(f.MaterialColorImageID AS nVARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
	END AS ColorUrl, ISNULL(k.MaterialSize,'*NA') AS MaterialSize, 
	ISNULL(sy.Season,'') + ' ' + ISNULL(sy.[Year],'') AS SeasonYear

INTO #tmpMaterialRequestSubmitWorkflow
FROM pMaterialRequestSubmitWorkflow a
INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID = b.MaterialTradePartnerId 
INNER JOIN pMaterialRequestWorkflow c ON c.MaterialRequestWorkflowID = a.MaterialRequestWorkflowID
INNER JOIN pMaterialColor d ON d.MaterialColorID = a.MaterialColorID
INNER JOIN pColorPalette e ON e.ColorPaletteID = d.ColorPaletteID 
INNER JOIN pMaterialTradePartnerColor f ON f.MaterialTradePartnerColorID = a.MaterialTradePartnerColorID
INNER JOIN pMaterialTradePartner g ON g.MaterialTradePartnerId =  f.MaterialTradePartnerID
INNER JOIN uTradePartner i ON i.TradepartnerId = b.TradePartnerID 
INNER JOIN pMaterial j ON j.MaterialID = a.MaterialID
LEFT OUTER JOIN pMaterialSize k ON k.MaterialSizeID = f.MaterialSizeID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = b.TradePartnerRelationshipLevelID
LEFT JOIN pSeasonYear sy ON g.SeasonYearID = sy.SeasonYearID
WHERE a.MaterialTradePartnerId = @MaterialTradePartnerId
ORDER BY i.TradePartnerName, e.ColorCode


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
VALUES ('DB_Version', '0.5.0000', '07702', GetDate())
GO
