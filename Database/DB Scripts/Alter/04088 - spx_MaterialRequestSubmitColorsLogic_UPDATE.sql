

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitColorsLogic_UPDATE]    Script Date: 10/03/2012 11:43:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitColorsLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitColorsLogic_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitColorsLogic_UPDATE]    Script Date: 10/03/2012 11:43:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_MaterialRequestSubmitColorsLogic_UPDATE] (
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@ModifiedBy VARCHAR(200),
	@ModifiedDate DATETIME 
)
AS


BEGIN

	SELECT newid() AS MaterialRequestSubmitWorkflowID, pMaterialTradePartner.MaterialTradePartnerId, pMaterialTradePartnerColor.MaterialTradePartnerColorID, 
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID,  
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowID, pMaterialTradePartner.MaterialId, pMaterialTradePartnerColor.MaterialColorID, 
		  pMaterialTradePartner.TradepartnerId, pMaterialTradePartner.TradepartnerVendorId, 0 AS Status, 1 AS Submit, 
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowDays AS SubmitDays, 
			pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowRDays AS ResubmitDays, 
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowAssignedTo AS AssignedTo, GETDATE() AS StartDate, 
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowFinalDate AS DueDate, 
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowFinalDate AS FinalDate
	INTO #pMaterialRequestSubmitWorkflow
	FROM  pMaterialTradePartner INNER JOIN
	  pMaterialTradePartnerColor ON pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerID INNER JOIN
	  pMaterialRequestWorkflowTemplateItem ON 
	  pMaterialTradePartner.MaterialRequestWorkflowTempID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempID
	WHERE pMaterialTradePartnerColor.MaterialTradePartnerColorID = @MaterialTradePartnerColorId 
	AND pMaterialTradePartnerColor.MaterialTradePartnerColorID NOT IN 
	(SELECT MaterialTradePartnerColorID FROM pMaterialRequestSubmitWorkflow WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorId)
	ORDER BY pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowID

	SELECT newid() AS MaterialRequestSubmitID, MaterialRequestSubmitWorkflowID, MaterialTradePartnerId, MaterialTradePartnerColorID,  
		  [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate
	INTO #pMaterialRequestSubmit
	FROM  #pMaterialRequestSubmitWorkflow
	ORDER BY MaterialTradePartnerColorID, MaterialRequestWorkflowID

	SELECT newid() AS MaterialRequestSubmitItemID, #pMaterialRequestSubmit.MaterialRequestSubmitID, pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemID, 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom1, pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom2, 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom3, pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom4, 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom5, pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom6, 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom7, pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom8, 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom9, pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemCustom10, 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowItemSort
	INTO #pMaterialRequestSubmitItem
	FROM  pMaterialRequestWorkflowItem INNER JOIN
		  #pMaterialRequestSubmitWorkflow ON 
		  pMaterialRequestWorkflowItem.MaterialRequestWorkflowID = #pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID INNER JOIN
		  #pMaterialRequestSubmit ON 
		  #pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = #pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID

	--SELECT * FROM #pMaterialRequestSubmitWorkflow

	INSERT INTO pMaterialRequestSubmitWorkflow(MaterialRequestSubmitWorkflowID, MaterialTradePartnerId, MaterialTradePartnerColorID, 
	  MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialId, MaterialColorID, 
	  TradepartnerId, TradepartnerVendorId, [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, FinalDate,
		CDate, CUser, MDate, MUser)
	SELECT MaterialRequestSubmitWorkflowID, MaterialTradePartnerId,MaterialTradePartnerColorID, MaterialRequestWorkflowTempItemID,  
	  MaterialRequestWorkflowID, MaterialId, MaterialColorID, TradepartnerId, TradepartnerVendorId, [Status], Submit, 
	  SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, FinalDate, @ModifiedDate, @ModifiedBy, @ModifiedDate, @ModifiedBy
	FROM  #pMaterialRequestSubmitWorkflow
	ORDER BY MaterialTradePartnerColorID, MaterialRequestWorkflowID

	INSERT INTO pMaterialRequestSubmit (MaterialRequestSubmitID, MaterialRequestSubmitWorkflowID, MaterialTradePartnerId, MaterialTradePartnerColorID,  
	 [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, CDate, CUser, MDate, MUser)
	SELECT MaterialRequestSubmitID, MaterialRequestSubmitWorkflowID, MaterialTradePartnerId, MaterialTradePartnerColorID,  
	 [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, @ModifiedDate, @ModifiedBy, @ModifiedDate, @ModifiedBy
	FROM  #pMaterialRequestSubmit

	INSERT INTO pMaterialRequestSubmitItem (MaterialRequestSubmitItemID, MaterialRequestSubmitID, MaterialRequestWorkflowItemID, 
		MaterialRequestSubmitItemStatus, MaterialRequestSubmitItemCustom1, 
		MaterialRequestSubmitItemCustom2, MaterialRequestSubmitItemCustom3, MaterialRequestSubmitItemCustom4, MaterialRequestSubmitItemCustom5, 
		MaterialRequestSubmitItemCustom6, MaterialRequestSubmitItemCustom7, MaterialRequestSubmitItemCustom8, MaterialRequestSubmitItemCustom9, 
		MaterialRequestSubmitItemCustom10, MaterialRequestSubmitItemSort, CDate, CUser, MDate, MUser)
	SELECT MaterialRequestSubmitItemID, MaterialRequestSubmitID, MaterialRequestWorkflowItemID, 0 AS MaterialRequestSubmitItemStatus, 
		MaterialRequestWorkflowItemCustom1, MaterialRequestWorkflowItemCustom2, 
		MaterialRequestWorkflowItemCustom3, MaterialRequestWorkflowItemCustom4, 
		MaterialRequestWorkflowItemCustom5, MaterialRequestWorkflowItemCustom6, 
		MaterialRequestWorkflowItemCustom7, MaterialRequestWorkflowItemCustom8, 
		MaterialRequestWorkflowItemCustom9, MaterialRequestWorkflowItemCustom10, 
		MaterialRequestWorkflowItemSort, @ModifiedDate, @ModifiedBy, @ModifiedDate, @ModifiedBy
	FROM #pMaterialRequestSubmitItem

	DROP TABLE #pMaterialRequestSubmitWorkflow
	DROP TABLE #pMaterialRequestSubmit
	DROP TABLE #pMaterialRequestSubmitItem

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04088', GetDate())
GO