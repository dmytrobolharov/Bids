IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitLogic_UPDATE] (
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
	@MaterialTradePartnerID UNIQUEIDENTIFIER,  
	@MaterialRequestWorkflowID VARCHAR(10),
	@MaterialSubmit VARCHAR(2)
)
AS

DECLARE @MaterialRequestSubmitID UNIQUEIDENTIFIER,
		@Submit INT,
		@Status INT,
		@AssignedTo VARCHAR(200),
		@StartDate DATETIME,
		@DueDate DATETIME,
		@EndDate DATETIME,
		@MUser NVARCHAR(200),
		@MDate DATETIME

SELECT TOP 1 
	@MaterialRequestSubmitID = pMaterialRequestSubmit.MaterialRequestSubmitID,
	@Submit = pMaterialRequestSubmit.Submit, 
	@Status = pMaterialRequestSubmit.Status, 
	@AssignedTo = pMaterialRequestSubmit.AssignedTo, 
	@StartDate = pMaterialRequestSubmit.StartDate, 
	@DueDate = pMaterialRequestSubmit.DueDate, 
	@EndDate = pMaterialRequestSubmit.EndDate,
	@MUser = pMaterialRequestSubmit.MUser,
	@MDate = pMaterialRequestSubmit.MDate 
FROM pMaterialRequestSubmitWorkflow INNER JOIN
	pMaterialRequestSubmit ON 
	pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
	AND pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
	AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
	AND pMaterialRequestSubmitWorkflow.Submit = @MaterialSubmit
ORDER BY pMaterialRequestSubmit.Submit DESC


------------ BEGIN ----------
-- Daniel Pak 10/13/2009
-- Validate if ALLCOLORS

DECLARE @MaterialRequestSubmitAllColors int
SELECT @MaterialRequestSubmitAllColors = MaterialRequestSubmitAllColors FROM pMaterialRequestSubmitWorkflow 
	WHERE MaterialTradePartnerID= @MaterialTradePartnerID 
			AND MaterialRequestWorkflowID= @MaterialRequestWorkflowID

------------ END --------------


IF @Status =  1 --If Resubmit Status
	BEGIN
		--Get New MaterialRequestSubmitID
		DECLARE @NewMaterialRequestSubmitID UNIQUEIDENTIFIER,
				@NewSubmit INT

		SELECT @NewMaterialRequestSubmitID = newid(),
				@NewSubmit = @Submit + 1


		--Copy Submit values to new new resubmit
		INSERT INTO pMaterialRequestSubmitItem (
			MaterialRequestSubmitID, MaterialRequestSubmitItemStatus, MaterialRequestSubmitItemCustom1, 
			MaterialRequestSubmitItemCustom2, MaterialRequestSubmitItemCustom3, MaterialRequestSubmitItemCustom4, MaterialRequestSubmitItemCustom5, 
			MaterialRequestSubmitItemCustom6, MaterialRequestSubmitItemCustom7, MaterialRequestSubmitItemCustom8, MaterialRequestSubmitItemCustom9, 
			MaterialRequestSubmitItemCustom10, MaterialRequestSubmitItemSort, CUser, CDate, MUser, MDate
		) 
		SELECT @NewMaterialRequestSubmitID, MaterialRequestSubmitItemStatus, MaterialRequestSubmitItemCustom1, 
			MaterialRequestSubmitItemCustom2, MaterialRequestSubmitItemCustom3, MaterialRequestSubmitItemCustom4, MaterialRequestSubmitItemCustom5, 
			MaterialRequestSubmitItemCustom6, MaterialRequestSubmitItemCustom7, MaterialRequestSubmitItemCustom8, MaterialRequestSubmitItemCustom9, 
			MaterialRequestSubmitItemCustom10, MaterialRequestSubmitItemSort, CUser, CDate, MUser, MDate
		FROM pMaterialRequestSubmitItem 
		WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID

		INSERT INTO pMaterialRequestSubmit (
			MaterialRequestSubmitID, MaterialRequestSubmitWorkflowID, 
			MaterialTradePartnerColorID, MaterialTradePartnerID, 
			Submit, [Status], AssignedTo, StartDate,
			RecCarrier, RecTrackNo, RecWeight, VendorWeight, 
			VendorDate, VendorName, SubmitDays, ResubmitDays, DueDate, 
			EndDate, EndBy, 
			CUser, CDate, MUser, MDate, TUser, TDate, 
			AgentView, VendorComment, InternalComment
		)
		SELECT @NewMaterialRequestSubmitID, MaterialRequestSubmitWorkflowID, 
			MaterialTradePartnerColorID, MaterialTradePartnerID, 
			@NewSubmit AS Submit, 0 AS [Status], AssignedTo, StartDate,
			RecCarrier, RecTrackNo, RecWeight, VendorWeight, 
			VendorDate, VendorName, SubmitDays, ResubmitDays, DueDate, 
			EndDate, EndBy, 
			CUser, CDate, MUser, MDate, TUser, TDate, 
			AgentView, VendorComment, InternalComment
		FROM pMaterialRequestSubmit
		WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID AND Submit <> @NewSubmit

		IF @MaterialRequestSubmitAllColors = 1
			BEGIN
				--Update Workflow with new submit #
				UPDATE pMaterialRequestSubmitWorkflow SET 
					pMaterialRequestSubmitWorkflow.Submit = @NewSubmit, 
					pMaterialRequestSubmitWorkflow.Status = @Status, 
					pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
					pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
					pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
					pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, @EndDate, 112),
					pMaterialRequestSubmitWorkflow.MDate = @MDate,
					pMaterialRequestSubmitWorkflow.MUser = @MUser
				WHERE 
						pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
					AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
			END
		ELSE
			BEGIN
				--Update Workflow with new submit #
				UPDATE pMaterialRequestSubmitWorkflow SET 
					pMaterialRequestSubmitWorkflow.Submit = @NewSubmit, 
					pMaterialRequestSubmitWorkflow.Status = @Status, 
					pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
					pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
					pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
					pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, @EndDate, 112),
					pMaterialRequestSubmitWorkflow.MDate = @MDate,
					pMaterialRequestSubmitWorkflow.MUser = @MUser
				WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
					AND pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
					AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
					AND pMaterialRequestSubmitWorkflow.Submit = @Submit
			END



		UPDATE pMaterialRequestSubmitItem SET MaterialRequestSubmitItemStatus = 0 
		WHERE MaterialRequestSubmitID = @NewMaterialRequestSubmitID AND MaterialRequestSubmitItemStatus = 1 

	END

ELSE IF @Status = 2 OR @Status = 3 OR @Status = 4 

	BEGIN

			IF @MaterialRequestSubmitAllColors = 1
				BEGIN
					UPDATE pMaterialRequestSubmitWorkflow SET 
						--pMaterialRequestSubmitWorkflow.Submit = @Submit, 
						pMaterialRequestSubmitWorkflow.Status = @Status, 
						pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
						pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
						pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
						pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, getdate(), 112),
						pMaterialRequestSubmitWorkflow.MDate = @MDate,
						pMaterialRequestSubmitWorkflow.MUser = @MUser
					WHERE
							pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
						AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
						--AND pMaterialRequestSubmitWorkflow.Submit = @Submit

					UPDATE pMaterialRequestSubmit SET 
						EndBy = @MUser, 
						EndDate = CONVERT(DATETIME, getdate(), 112)
					WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID
				END
			ELSE
				BEGIN
					UPDATE pMaterialRequestSubmitWorkflow SET 
						--pMaterialRequestSubmitWorkflow.Submit = @Submit, 
						pMaterialRequestSubmitWorkflow.Status = @Status, 
						pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
						pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
						pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
						pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, getdate(), 112),
						pMaterialRequestSubmitWorkflow.MDate = @MDate,
						pMaterialRequestSubmitWorkflow.MUser = @MUser
					WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID 
						AND pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
						AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
						AND pMaterialRequestSubmitWorkflow.Submit = @Submit

					UPDATE pMaterialRequestSubmit SET 
						EndBy = @MUser, 
						EndDate = CONVERT(DATETIME, getdate(), 112)
					WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID
				END
	END

ELSE IF @Status = 99
	BEGIN
		--DROP ALL COLOR
		UPDATE pMaterialRequestSubmitWorkflow SET 
			--pMaterialRequestSubmitWorkflow.Submit = @Submit, 
			pMaterialRequestSubmitWorkflow.Status = @Status, 
			pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
			pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
			pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
			pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, getdate(), 112),
			pMaterialRequestSubmitWorkflow.MDate = @MDate,
			pMaterialRequestSubmitWorkflow.MUser = @MUser
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
			AND (pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID) 
			AND (pMaterialRequestSubmitWorkflow.Status = 0 OR pMaterialRequestSubmitWorkflow.Status = 99)	

		UPDATE pMaterialRequestSubmit SET pMaterialRequestSubmit.Status = pMaterialRequestSubmitWorkflow.Status
		FROM  pMaterialRequestSubmitWorkflow INNER JOIN
		  pMaterialRequestSubmit ON 
		  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
			AND (pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID) 
			AND (pMaterialRequestSubmitWorkflow.Status = 0 OR pMaterialRequestSubmitWorkflow.Status = 100)	

	END

ELSE IF @Status = 100
	BEGIN
		--DROP ALL WORKFLOW 
		UPDATE pMaterialRequestSubmitWorkflow SET 
			--pMaterialRequestSubmitWorkflow.Submit = @Submit, 
			pMaterialRequestSubmitWorkflow.Status = @Status, 
			pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
			pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
			pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
			pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, getdate(), 112),
			pMaterialRequestSubmitWorkflow.MDate = @MDate,
			pMaterialRequestSubmitWorkflow.MUser = @MUser
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
			AND (pMaterialRequestSubmitWorkflow.Status = 0 OR pMaterialRequestSubmitWorkflow.Status = 100)	

		UPDATE pMaterialRequestSubmit SET pMaterialRequestSubmit.Status = pMaterialRequestSubmitWorkflow.Status
		FROM  pMaterialRequestSubmitWorkflow INNER JOIN
		  pMaterialRequestSubmit ON 
		  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
			AND (pMaterialRequestSubmitWorkflow.Status = 0 OR pMaterialRequestSubmitWorkflow.Status = 100)	

	END

ELSE

	IF @MaterialRequestSubmitAllColors = 1
		BEGIN
			UPDATE pMaterialRequestSubmitWorkflow SET 
				--pMaterialRequestSubmitWorkflow.Submit = @Submit, 
				pMaterialRequestSubmitWorkflow.Status = @Status, 
				pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
				pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
				pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
				pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, @EndDate, 112),
				pMaterialRequestSubmitWorkflow.MDate = @MDate,
				pMaterialRequestSubmitWorkflow.MUser = @MUser
			WHERE 
					pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
				AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
				--AND pMaterialRequestSubmitWorkflow.Submit = @Submit
		END
	ELSE		
		BEGIN
			UPDATE pMaterialRequestSubmitWorkflow SET 
				--pMaterialRequestSubmitWorkflow.Submit = @Submit, 
				pMaterialRequestSubmitWorkflow.Status = @Status, 
				pMaterialRequestSubmitWorkflow.AssignedTo = @AssignedTo, 
				pMaterialRequestSubmitWorkflow.StartDate = CONVERT(DATETIME, @StartDate, 112), 
				pMaterialRequestSubmitWorkflow.DueDate = CONVERT(DATETIME, @DueDate, 112), 
				pMaterialRequestSubmitWorkflow.EndDate = CONVERT(DATETIME, @EndDate, 112),
				pMaterialRequestSubmitWorkflow.MDate = @MDate,
				pMaterialRequestSubmitWorkflow.MUser = @MUser
			WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
				AND pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = @MaterialTradePartnerID
				AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
				AND pMaterialRequestSubmitWorkflow.Submit = @Submit
		END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04203', GetDate())
GO
