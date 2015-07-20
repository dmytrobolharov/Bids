/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowColor_SELECT]    Script Date: 07/02/2014 10:50:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowColor_SELECT]    Script Date: 07/02/2014 10:50:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_SELECT] (
@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
@MaterialTradePartnerID UNIQUEIDENTIFIER,  
@MaterialRequestWorkflowID nVARCHAR(10),
@MaterialSubmit nVARCHAR(2)
)
AS

------------ BEGIN ----------
-- Daniel Pak 10/13/2009
-- if request is ALL COLORS, it will create a record on pMaterialRequestSubmitGroup
-- It will group all the colors to a single request (pMaterialRequestSubmitWorkflow, pMaterialRequestSubmit)

DECLARE @MaterialRequestSubmitGroupID uniqueidentifier
DECLARE @MaterialRequestSubmitAllColors int
SELECT @MaterialRequestSubmitAllColors = MaterialRequestSubmitAllColors FROM pMaterialRequestSubmitWorkflow 
      WHERE MaterialTradePartnerID= @MaterialTradePartnerID 
                  AND MaterialRequestWorkflowID= @MaterialRequestWorkflowID

IF @MaterialRequestSubmitAllColors = 1
	BEGIN

      --SELECT TOP 1 @MaterialTradePartnerColorID = MaterialTradePartnerColorID FROM pMaterialTradePartnerColor WHERE MaterialtradePartnerID = @MaterialTradePartnerID ORDER BY CDate ASC
      SET @MaterialRequestSubmitGroupID = newid()

      IF (SELECT COUNT(*) FROM pMaterialRequestSubmitGroup 
            WHERE MaterialTradePartnerID= @MaterialTradePartnerID 
                  AND MaterialRequestWorkflowID= @MaterialRequestWorkflowID) = 0
      BEGIN
            INSERT INTO pMaterialRequestSubmitGroup(MaterialRequestSubmitGroupID, MaterialTradePartnerID, MaterialRequestWorkflowID, MaterialTradePartnerColorID)
            VALUES (@MaterialRequestSubmitGroupID, @MaterialTradePartnerID, @MaterialRequestWorkflowID, @MaterialTradePartnerColorID)         

            UPDATE pMaterialRequestSubmitWorkflow SET MaterialRequestSubmitGroupID = @MaterialRequestSubmitGroupID
            WHERE MaterialTradePartnerID= @MaterialTradePartnerID AND
            MaterialRequestWorkflowID= @MaterialRequestWorkflowID 

            UPDATE pMaterialRequestSubmit SET MaterialRequestSubmitGroupID = @MaterialRequestSubmitGroupID
            WHERE MaterialRequestSubmitWorkflowID IN (
                  SELECT MaterialRequestSubmitWorkflowID FROM pMaterialRequestSubmitWorkflow
                  WHERE MaterialTradePartnerID= @MaterialTradePartnerID AND
                  MaterialRequestWorkflowID= @MaterialRequestWorkflowID)

      END
      
      SELECT pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialRequestSubmitWorkflow.MaterialTradePartnerID, 
      pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID, pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID, 
      pMaterialRequestSubmitWorkflow.MaterialID, pMaterialRequestSubmitWorkflow.MaterialColorID, pMaterialRequestSubmitWorkflow.TradePartnerID, 
      pMaterialRequestSubmitWorkflow.TradePartnerVendorID, pMaterialRequestSubmitWorkflow.FinalDate, 
      pMaterialRequestSubmitWorkflow.Submit AS CurrentSubmit, pMaterialRequestWorkflow.MaterialRequestWorkflow, 
      pMaterialRequestSubmit.MaterialRequestSubmitID, pMaterialRequestWorkflow.MaterialRequestWorkflowID, pMaterialRequestSubmit.Status, 
      pMaterialRequestSubmit.Submit, pMaterialRequestSubmit.SubmitDays, pMaterialRequestSubmit.ResubmitDays, 
      pMaterialRequestSubmit.AssignedTo, pMaterialRequestSubmit.StartDate, pMaterialRequestSubmit.EndDate, pMaterialRequestSubmit.DueDate, 
      pMaterialRequestSubmit.CUser, pMaterialRequestSubmit.CDate, pMaterialRequestSubmit.MUser, pMaterialRequestSubmit.MDate, 
      pMaterialRequestSubmit.AgentView, pMaterialRequestSubmit.VendorComment, pMaterialRequestSubmit.InternalComment, 
      pMaterialRequestSubmit.SubmitComment, pMaterialRequestWorkflow.MaterialRequestWorkflowColor, 
      pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempID, pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowGroupID, 
      pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors, pMaterialTradePartner.SeasonYearID, pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID
		FROM  pMaterialRequestSubmitWorkflow INNER JOIN
			  pMaterialRequestWorkflow ON 
			  pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
			  pMaterialRequestSubmit ON 
			  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID INNER JOIN
			  pMaterialTradePartner ON pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId LEFT OUTER JOIN
			  pMaterialRequestWorkflowTemplateItem ON 
			  pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
			  AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
			  AND pMaterialRequestSubmit.Submit = @MaterialSubmit
      
	END

      
ELSE

	BEGIN
		SELECT pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialRequestSubmitWorkflow.MaterialTradePartnerID, 
		  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID, pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID, 
		  pMaterialRequestSubmitWorkflow.MaterialID, pMaterialRequestSubmitWorkflow.MaterialColorID, pMaterialRequestSubmitWorkflow.TradePartnerID, 
		  pMaterialRequestSubmitWorkflow.TradePartnerVendorID, pMaterialRequestSubmitWorkflow.FinalDate, 
		  pMaterialRequestSubmitWorkflow.Submit AS CurrentSubmit, pMaterialRequestWorkflow.MaterialRequestWorkflow, 
		  pMaterialRequestSubmit.MaterialRequestSubmitID, pMaterialRequestWorkflow.MaterialRequestWorkflowID, pMaterialRequestSubmit.Status, 
		  pMaterialRequestSubmit.Submit, pMaterialRequestSubmit.SubmitDays, pMaterialRequestSubmit.ResubmitDays, 
		  pMaterialRequestSubmit.AssignedTo, pMaterialRequestSubmit.StartDate, pMaterialRequestSubmit.EndDate, pMaterialRequestSubmit.DueDate, 
		  pMaterialRequestSubmit.CUser, pMaterialRequestSubmit.CDate, pMaterialRequestSubmit.MUser, pMaterialRequestSubmit.MDate, 
		  pMaterialRequestSubmit.AgentView, pMaterialRequestSubmit.VendorComment, pMaterialRequestSubmit.InternalComment, 
		  pMaterialRequestSubmit.SubmitComment, pMaterialRequestWorkflow.MaterialRequestWorkflowColor, 
		  pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempID, pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowGroupID, 
		  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors, pMaterialTradePartner.SeasonYearID, pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID
			FROM  pMaterialRequestSubmitWorkflow INNER JOIN
		  pMaterialRequestWorkflow ON 
		  pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
		  pMaterialRequestSubmit ON 
		  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID INNER JOIN
		  pMaterialTradePartner ON pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId LEFT OUTER JOIN
		  pMaterialRequestWorkflowTemplateItem ON 
		  pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID
			WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
		  AND pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
		  AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
		  AND pMaterialRequestSubmit.Submit = @MaterialSubmit
	END





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08181', GetDate())
GO
