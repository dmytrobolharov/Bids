/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 01/22/2013 16:25:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 01/22/2013 16:25:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
@SupplierID UNIQUEIDENTIFIER = NULL
AS 

DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER

SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialRequestSubmitWorkflow 
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID

/** Selecting all the bubbles, for plmOn and srmOn with old partner management **/
IF @SupplierID IS NULL
BEGIN

	SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartnerColor.ColorCode, pMaterialRequestSubmit.MaterialRequestSubmitID, 
	  pMaterialTradePartnerColor.ColorNo, pMaterialTradePartnerColor.ColorName, pMaterialTradePartnerColor.VendorColorCode, 
	  pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, pMaterialRequestWorkflow.MaterialRequestWorkflowID, 
	  pMaterialRequestWorkflow.GroupName, pMaterialRequestWorkflow.GroupID, pMaterialRequestSubmitStatus.Status, 
	  pMaterialRequestSubmitWorkflow.Submit, pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate, 
	  pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, 
	  pMaterialRequestWorkflow.MaterialRequestWorkflowSort, pMaterialTradePartnerColor.MaterialID, 
	  '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon AS Icon, 
		pMaterialRequestSubmitWorkflow.MaterialTradePartnerID, pMaterialRequestWorkflow.MaterialRequestWorkflowColor, pMaterialTradePartnerColor.ColorFolderID, pMaterialTradePartnerColor.ColorPaletteID,
		pMaterialTradePartnerColor.MaterialColorImageID, pMaterialTradePartnerColor.MaterialColorImageVersion, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors,
		pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID, pt.Custom AS PartnerType, ISNULL(pt.CustomKey, '1') AS PartnerOwner
		
	FROM pMaterialRequestSubmitStatus INNER JOIN
	  pMaterialRequestWorkflow INNER JOIN
	  pMaterialRequestSubmitWorkflow ON 
	  pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON 
	  pMaterialRequestSubmitStatus.StatusID = pMaterialRequestSubmitWorkflow.Status INNER JOIN
	  pMaterialTradePartnerColor ON 
	  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID INNER JOIN
	  pMaterialRequestSubmit ON 
	  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID LEFT JOIN
	  uTradePartnerType pt ON pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID = pt.CustomId


	WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0
	AND pMaterialRequestSubmitWorkflow.Active = 1 
	ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort

END
ELSE
BEGIN
	SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartnerColor.ColorCode, pMaterialRequestSubmit.MaterialRequestSubmitID, 
	  pMaterialTradePartnerColor.ColorNo, pMaterialTradePartnerColor.ColorName, pMaterialTradePartnerColor.VendorColorCode, 
	  pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, pMaterialRequestWorkflow.MaterialRequestWorkflowID, 
	  pMaterialRequestWorkflow.GroupName, pMaterialRequestWorkflow.GroupID, pMaterialRequestSubmitStatus.Status, 
	  pMaterialRequestSubmitWorkflow.Submit, pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate, 
	  pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, 
	  pMaterialRequestWorkflow.MaterialRequestWorkflowSort, pMaterialTradePartnerColor.MaterialID, 
	  '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon AS Icon, 
		pMaterialRequestSubmitWorkflow.MaterialTradePartnerID, pMaterialRequestWorkflow.MaterialRequestWorkflowColor, pMaterialTradePartnerColor.ColorFolderID, pMaterialTradePartnerColor.ColorPaletteID,
		pMaterialTradePartnerColor.MaterialColorImageID, pMaterialTradePartnerColor.MaterialColorImageVersion, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors,
		pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID, pt.Custom AS PartnerType, ISNULL(pt.CustomKey, '1') AS PartnerOwner
		
	FROM pMaterialRequestSubmitStatus INNER JOIN
	  pMaterialRequestWorkflow INNER JOIN
	  pMaterialRequestSubmitWorkflow ON 
	  pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON 
	  pMaterialRequestSubmitStatus.StatusID = pMaterialRequestSubmitWorkflow.Status INNER JOIN
	  pMaterialTradePartnerColor ON 
	  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID INNER JOIN
	  pMaterialRequestSubmit ON 
	  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID LEFT JOIN
	  uTradePartnerType pt ON pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID = pt.CustomId INNER JOIN
	  pMaterialRequestSubmitWorkflowShare share ON share.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID


	WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0
	AND pMaterialRequestSubmitWorkflow.Active = 1 AND share.TradePartnerID = @SupplierID
	ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04837', GetDate())
GO
