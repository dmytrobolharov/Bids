IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestTempWorkflow_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestTempWorkflow_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestTempWorkflow_UPDATE]
	@MaterialRequestGroupID UNIQUEIDENTIFIER,
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER,
	@MaterialID  UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME 
AS
BEGIN

DECLARE @StartDate datetime
DECLARE @DueDate datetime

SELECT  @StartDate = MaterialRequestWorkflowStartDate, @DueDate = MaterialRequestWorkflowDueDate
FROM  pMaterialRequestTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID
	
	IF (SELECT COUNT(*) FROM pMaterialRequestTempWorkflow WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID) >  0 	
		BEGIN
			IF @DueDate IS NOT NULL
			BEGIN
				UPDATE pMaterialRequestTempWorkflow SET 
					DueDate = @DueDate
				WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
				AND DueDate IS NULL
			END
			IF @DueDate IS NULL AND @StartDate IS NOT NULL
			BEGIN
				UPDATE pMaterialRequestTempWorkflow SET 
					DueDate = DATEADD(DAY,[Days],@StartDate)
				WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
				AND DueDate IS NULL
			END
		END 
	ELSE
		BEGIN
			DELETE FROM pMaterialRequestTempWorkflow
			WHERE MaterialRequestGroupID = @MaterialRequestGroupID 
			AND MaterialRequestWorkflowTempID <> @MaterialRequestWorkflowTempID
			
			IF @StartDate IS NOT NULL
			BEGIN
				INSERT INTO  pMaterialRequestTempWorkflow  (MaterialRequestTempWorkflowID, MaterialRequestGroupID, 
					MaterialRequestWorkflowTempID, MaterialRequestWorkflowTemplateItemID, MaterialRequestWorkflowID, AssignedTo, 
					Days, RDays, DueDate, Alerts, Status, PartnerTypeID) 
				SELECT NEWID(), @MaterialRequestGroupID, MaterialRequestWorkflowTempID, 
					MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialRequestWorkflowAssignedTo,
					MaterialRequestWorkflowDays, MaterialRequestWorkflowRDays, DATEADD(DAY,MaterialRequestWorkflowDays,@StartDate), MaterialRequestWorkflowAlerts, 0, NULL
				FROM pMaterialRequestWorkflowTemplateItem WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
			END
			ELSE
			BEGIN
				INSERT INTO  pMaterialRequestTempWorkflow  (MaterialRequestTempWorkflowID, MaterialRequestGroupID, 
					MaterialRequestWorkflowTempID, MaterialRequestWorkflowTemplateItemID, MaterialRequestWorkflowID, AssignedTo, 
					Days, RDays, DueDate, Alerts, Status, PartnerTypeID) 
				SELECT NEWID(), @MaterialRequestGroupID, MaterialRequestWorkflowTempID, 
					MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialRequestWorkflowAssignedTo,
					MaterialRequestWorkflowDays, MaterialRequestWorkflowRDays, NULL, MaterialRequestWorkflowAlerts, 0, NULL
				FROM pMaterialRequestWorkflowTemplateItem WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
			END
		END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05627', GetDate())
GO
