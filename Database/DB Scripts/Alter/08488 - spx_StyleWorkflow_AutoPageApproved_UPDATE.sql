IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_AutoPageApproved_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_AutoPageApproved_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflow_AutoPageApproved_UPDATE]( 
	@AutoPageApproved NVARCHAR(50),
	@StyleID UNIQUEIDENTIFIER, 
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER, 
	@WorkflowItemID UNIQUEIDENTIFIER, 
	@StyleSeasonYearID NVARCHAR(50) = NULL,
	@WorkflowStatus NVARCHAR(50)
)
AS 

DECLARE @ItemsCount INT = 0
DECLARE @ApprovedCount INT = 0

IF @AutoPageApproved = 'ALL'
BEGIN 
	IF ISNULL(@StyleSeasonYearID, '') <> ''
	BEGIN
		IF @WorkflowStatus = '100'
		BEGIN
			SELECT @ItemsCount = COUNT(*), @ApprovedCount = SUM(CASE WorkStatus WHEN 100 THEN 1 ELSE 0 END) FROM pWorkFlowItem 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID AND WorkFlowItemID <> @WorkflowItemID 
				AND StyleSeasonYearID = @StyleSeasonYearID
				
			IF @ItemsCount = @ApprovedCount
			BEGIN
				UPDATE pStyleWorkflow SET WorkStatus = 100, ActualEnd = CAST(GETDATE() AS DATE) WHERE StyleID = @StyleID 
					AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID AND StyleSeasonYearID = @StyleSeasonYearID
			END	
		END
		ELSE IF @WorkflowStatus <> '102'
		BEGIN
			UPDATE pStyleWorkflow SET WorkStatus = 6, ActualEnd = NULL WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
				AND WorkflowID = @WorkflowID AND StyleSeasonYearID = @StyleSeasonYearID
		END
	END
	ELSE
	BEGIN
		IF @WorkflowStatus = '100'
		BEGIN
			SELECT @ItemsCount = COUNT(*), @ApprovedCount = SUM(CASE WorkStatus WHEN 100 THEN 1 ELSE 0 END) FROM pWorkFlowItem 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID AND WorkFlowItemID <> @WorkflowItemID 		
		
			IF @ItemsCount = @ApprovedCount
			BEGIN
				UPDATE pStyleWorkflow SET WorkStatus = 100, ActualEnd = CAST(GETDATE() AS DATE) WHERE StyleID = @StyleID 
					AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID
			END	
		END
		ELSE IF @WorkflowStatus <> '102'
		BEGIN
			UPDATE pStyleWorkflow SET WorkStatus = 6, ActualEnd = NULL WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
				AND WorkflowID = @WorkflowID
		END
	END
END
ELSE IF @AutoPageApproved = 'ONE'
BEGIN
	IF ISNULL(@StyleSeasonYearID, '') <> ''
	BEGIN
		IF @WorkflowStatus = '100'
		BEGIN
			UPDATE pStyleWorkflow SET WorkStatus = 100, ActualEnd = CAST(GETDATE() AS DATE) WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
				AND WorkflowID = @WorkflowID AND StyleSeasonYearID = @StyleSeasonYearID
		END
		ELSE IF @WorkflowStatus <> '102'
		BEGIN
			SELECT @ApprovedCount = SUM(CASE WorkStatus WHEN 100 THEN 1 WHEN 102 THEN 1 ELSE 0 END) FROM pWorkFlowItem 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID AND WorkFlowItemID <> @WorkflowItemID 
				AND StyleSeasonYearID = @StyleSeasonYearID
			
			IF @ApprovedCount = 0
			BEGIN
				UPDATE pStyleWorkflow SET WorkStatus = 6, ActualEnd = NULL WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
					AND WorkflowID = @WorkflowID AND StyleSeasonYearID = @StyleSeasonYearID
			END	
		END
	END
	ELSE
	BEGIN
		IF @WorkflowStatus = '100'
		BEGIN
			UPDATE pStyleWorkflow SET WorkStatus = 100, ActualEnd = CAST(GETDATE() AS DATE) WHERE StyleID = @StyleID 
				AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID
		END
		ELSE IF @WorkflowStatus <> '102'
		BEGIN
			SELECT @ApprovedCount = SUM(CASE WorkStatus WHEN 100 THEN 1 WHEN 102 THEN 1 ELSE 0 END) FROM pWorkFlowItem 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID AND WorkFlowItemID <> @WorkflowItemID 
			
			IF @ApprovedCount = 0
			BEGIN
				UPDATE pStyleWorkflow SET WorkStatus = 6, ActualEnd = NULL WHERE StyleID = @StyleID 
					AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID
			END	
		END
	END
END
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08488', GetDate())
GO

