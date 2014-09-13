IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMGroupMaterial_LineFolderFlash_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMGroupMaterial_LineFolderFlash_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMGroupMaterial_LineFolderFlash_INSERT]
	@MaterialCoreItemID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleID UNIQUEIDENTIFIER,
			@NewStyleMaterialID UNIQUEIDENTIFIER,
			@WorkflowID UNIQUEIDENTIFIER,
			@WorkflowItemID UNIQUEIDENTIFIER,
			@MaterialID UNIQUEIDENTIFIER
			
	SELECT @MaterialID = MaterialID FROM pMaterialCoreItem WHERE MaterialCoreItemID = @MaterialCoreItemID
	SELECT @NewStyleMaterialID = NEWID()
			
	SELECT @StyleID = dim.StyleID, @WorkflowID = wi.WorkflowID, @WorkflowItemID = wi.WorkflowItemID
	FROM pStyleBOMDimension dim INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = dim.WorkFlowItemID
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID

		-- insert material from material group to pStyleBOMTemp
		EXEC spx_BOMMaterialCoreToStyleMaterialTempLogic_INSERT
				@MainMaterial = 0,
				@StyleID = @StyleID,
				@StyleMaterialID = @NewStyleMaterialID,
				@StyleSet = 1,
				@MaterialCoreItemID = @MaterialCoreItemID,
				@WorkflowItemID = @WorkflowItemID,
				@WorkflowID = @WorkflowID,
				@StyleBOMDimensionId = @StyleBOMDimensionID,
				@CreatedBy = @CUser,
				@CreatedDate = @CDate,
				@TradePartnerVendorID = NULL,
				@FilterUpdate = NULL

	
			-- Place for updating material attributes, if we'll have to.

			EXECUTE spx_StyleBOMPending_INSERT
				@StyleMaterialID = @NewStyleMaterialID,    
				@StyleID = @StyleID, 
				@StyleSet = 1, 
				@CreatedDate = @CDate, 
				@CreatedBy = @CUser,
				@WorkflowItemID = @WorkflowItemID,
				@WorkflowID = @WorkflowID,
				@StyleBOMDimensionID = @StyleBOMDimensionID,
				@NewStyleMaterialID = @NewStyleMaterialID OUTPUT
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06378', GetDate())
GO
