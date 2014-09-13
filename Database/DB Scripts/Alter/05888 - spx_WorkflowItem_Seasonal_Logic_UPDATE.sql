/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_Logic_UPDATE]    Script Date: 06/20/2013 13:47:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_Seasonal_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Seasonal_Logic_UPDATE]    Script Date: 06/20/2013 13:47:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_WorkflowItem_Seasonal_Logic_UPDATE]
	@WorkflowItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE @WorkflowItemMasterID UNIQUEIDENTIFIER
    
    SELECT @WorkflowItemMasterID = WorkflowItemMasterID FROM pWorkflowItem
    WHERE WorkFlowItemID = @WorkflowItemID
    -- If current workflow item belongs to seasonal workflow
    IF @WorkflowItemMasterID IS NOT NULL
    BEGIN
		UPDATE pWorkflowItem
		SET WorkFlowItemName = updated.WorkFlowItemName,
			WorkflowItemTypeId = updated.WorkflowItemTypeID,
			MDate = updated.MDate,
			MUser = updated.MUser
		FROM
		(
			SELECT WorkflowItemName, WorkflowItemTypeId, MDate, MUser 
			FROM pWorkflowItem WHERE WorkFlowItemID = @WorkflowItemID
		) updated
		WHERE WorkflowItemMasterID = @WorkflowItemMasterID
    END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05888', GetDate())
GO
