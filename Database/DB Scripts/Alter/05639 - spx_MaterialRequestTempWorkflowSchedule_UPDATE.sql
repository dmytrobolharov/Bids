IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestTempWorkflowSchedule_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestTempWorkflowSchedule_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestTempWorkflowSchedule_UPDATE]
	@MaterialRequestGroupID UNIQUEIDENTIFIER,
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER,
	@MaterialID  UNIQUEIDENTIFIER,
	@ScheduleBy nvarchar(1),
	@CUser NVARCHAR(200),
	@CDate DATETIME 
AS

begin

DECLARE @StartDate datetime
DECLARE @DueDate datetime

SELECT  @StartDate = MaterialRequestWorkflowStartDate, @DueDate = MaterialRequestWorkflowDueDate
FROM  pMaterialRequestTemp WHERE MaterialRequestGroupID = @MaterialRequestGroupID

if @StartDate is null 
	begin
		set @StartDate=GETDATE()
	end
	
if @DueDate is null 
	begin
		set @DueDate=GETDATE()
	end
	
if (SELECT COUNT(*) FROM pMaterialRequestTempWorkflow WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID) >  0 	
	begin
		if @ScheduleBy='S'
			begin
				UPDATE pMaterialRequestTempWorkflow SET 
					DueDate = DATEADD(DAY,[Days],@StartDate)
				WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
			end
		else
			if @ScheduleBy='E'
				begin
					UPDATE pMaterialRequestTempWorkflow SET 
						DueDate = DATEADD(DAY,-[Days],@DueDate)
					WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
				end
	end
else
	begin
		DELETE FROM pMaterialRequestTempWorkflow WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND MaterialRequestWorkflowTempID <> @MaterialRequestWorkflowTempID
		if @ScheduleBy='S'
			begin 
				INSERT INTO  pMaterialRequestTempWorkflow  (MaterialRequestTempWorkflowID, MaterialRequestGroupID, 
					MaterialRequestWorkflowTempID, MaterialRequestWorkflowTemplateItemID, MaterialRequestWorkflowID, AssignedTo, 
					Days, RDays, DueDate, Alerts, Status, PartnerTypeID) 
				SELECT NEWID(), @MaterialRequestGroupID, MaterialRequestWorkflowTempID, 
					MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialRequestWorkflowAssignedTo,
					MaterialRequestWorkflowDays, MaterialRequestWorkflowRDays, DATEADD(DAY,MaterialRequestWorkflowDays,@StartDate), MaterialRequestWorkflowAlerts, 0, MaterialRequestPartnerTypeID
				FROM pMaterialRequestWorkflowTemplateItem WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
			end
		else
			if @ScheduleBy='E'
				begin
					INSERT INTO  pMaterialRequestTempWorkflow  (MaterialRequestTempWorkflowID, MaterialRequestGroupID, 
						MaterialRequestWorkflowTempID, MaterialRequestWorkflowTemplateItemID, MaterialRequestWorkflowID, AssignedTo, 
						Days, RDays, DueDate, Alerts, Status, PartnerTypeID) 
					SELECT NEWID(), @MaterialRequestGroupID, MaterialRequestWorkflowTempID, 
						MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialRequestWorkflowAssignedTo,
						MaterialRequestWorkflowDays, MaterialRequestWorkflowRDays, DATEADD(DAY,-[MaterialRequestWorkflowDays],@DueDate), MaterialRequestWorkflowAlerts, 0, MaterialRequestPartnerTypeID
					FROM pMaterialRequestWorkflowTemplateItem WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
				end
			
	end
	
	
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05639', GetDate())
GO
