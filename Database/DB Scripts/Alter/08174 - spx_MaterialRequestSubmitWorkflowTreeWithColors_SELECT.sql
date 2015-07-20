/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 07/01/2014 17:57:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 07/01/2014 17:57:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
@TeamID UNIQUEIDENTIFIER = NULL,
@SupplierID UNIQUEIDENTIFIER = NULL
AS 

DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER

SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialRequestSubmitWorkflow 
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID

/** Selecting all the bubbles, for plmOn and srmOn with old partner management **/
IF @SupplierID IS NULL
BEGIN

	IF @TeamID IS NULL -- For srmOn
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
		  uTradePartnerType pt ON pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID = pt.CustomId LEFT JOIN 
		  pMaterialRequestWorkflowTemplateItem ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID

		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0
		AND pMaterialRequestSubmitWorkflow.Active = 1 
		ORDER BY pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort
	END
	ELSE
	BEGIN -- for PlmOn -- filtered by permissions
		
		DECLARE @MaterialTypeID INT
		SELECT @MaterialTypeID = pMaterial.MaterialType FROM pMaterialTradePartnerColor 
		INNER JOIN pMaterial ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID
		WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID
	
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
		  uTradePartnerType pt ON pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID = pt.CustomId LEFT JOIN 
		  pMaterialRequestWorkflowTemplateItem ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID INNER JOIN
		  fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 24, @MaterialTypeID) access ON access.WorkflowId = pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID 
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0
		AND pMaterialRequestSubmitWorkflow.Active = 1 AND access.PermissionRoleId > 0
		ORDER BY pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort
	END

END
ELSE
BEGIN -- for srmOn
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
	  pMaterialRequestSubmitWorkflowShare share ON share.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID LEFT JOIN 
	  pMaterialRequestWorkflowTemplateItem ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID

	WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0
	AND pMaterialRequestSubmitWorkflow.Active = 1 AND share.TradePartnerID = @SupplierID
	ORDER BY pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08174', GetDate())
GO
