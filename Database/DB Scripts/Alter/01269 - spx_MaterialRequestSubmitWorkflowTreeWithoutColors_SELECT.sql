IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT](
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER
)    
AS     
    
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER    
    
SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialRequestSubmitWorkflow     
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID    
    
    
SELECT d.MaterialTradePartnerColorID, d.ColorCode, e.MaterialRequestSubmitID,     
	d.ColorNo, d.ColorName, d.VendorColorCode,     
	d.VendorColorNo, d.VendorColorName, b.MaterialRequestWorkflowID,     
	b.GroupName, b.GroupID, a.Status,     
	c.Submit, c.DueDate, c.EndDate,     
	b.MaterialRequestWorkflow, c.MaterialRequestSubmitWorkflowID,     
	b.MaterialRequestWorkflowSort, d.MaterialID,     
	'../System/Icons/' + a.StatusIcon AS Icon,    
	c.MaterialTradePartnerID, b.MaterialRequestWorkflowColor, d.ColorFolderID, d.ColorPaletteID,    
	d.MaterialColorImageID, d.MaterialColorImageVersion, c.MaterialRequestSubmitAllColors    
FROM pMaterialRequestSubmitStatus a WITH(NOLOCK) 
	INNER JOIN pMaterialRequestWorkflow b WITH(NOLOCK) 
	INNER JOIN pMaterialRequestSubmitWorkflow c WITH(NOLOCK) ON  b.MaterialRequestWorkflowID = c.MaterialRequestWorkflowID 
		ON a.StatusID = c.Status 
	INNER JOIN pMaterialTradePartnerColor d WITH(NOLOCK) ON  c.MaterialTradePartnerColorID = d.MaterialTradePartnerColorID 
	INNER JOIN pMaterialRequestSubmit e WITH(NOLOCK) ON c.MaterialRequestSubmitWorkflowID = e.MaterialRequestSubmitWorkflowID    
WHERE c.MaterialTradePartnerColorID = @MaterialTradePartnerColorID 
	AND c.MaterialRequestSubmitAllColors = 1    
	AND c.Active = 1     
ORDER BY b.MaterialRequestWorkflowSort,b.MaterialRequestWorkflow    
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01269', GetDate())
GO
	