IF OBJECT_ID(N'[dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]
	@MaterialID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleID UNIQUEIDENTIFIER,
			@NewStyleMaterialID UNIQUEIDENTIFIER,
			@WorkflowID UNIQUEIDENTIFIER,
			@WorkflowItemID UNIQUEIDENTIFIER,
			@StyleSet INTEGER
			
	SELECT @NewStyleMaterialID = NEWID()
			
	SELECT @StyleID = dim.StyleID, 
		   @StyleSet = wi.StyleSet,
		   @WorkflowID = wi.WorkflowID, 
		   @WorkflowItemID = wi.WorkflowItemID
	FROM pStyleBOMDimension dim 
	INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = dim.WorkFlowItemID
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID

	EXEC spx_StyleBOMTemp_INSERT
				@MainMaterial =  0, 
				@StyleID = @StyleID, 
				@StyleMaterialID  = @NewStyleMaterialID, 
				@StyleSet = @StyleSet, 
				@MaterialID = @MaterialID, 
				@CreatedBy = @CUser, 
				@CreatedDate = @CDate,
				@TradePartnerVendorID = NULL,
				@StyleBOMDimensionID = @StyleBOMDimensionID,
				@WorkflowID = @WorkflowID,
				@WorkflowItemID = @WorkflowItemID
			
			-- Place for updating material attributes, if we'll have to.

			EXECUTE spx_StyleBOMPending_INSERT
				@StyleMaterialID = @NewStyleMaterialID,    
				@StyleID = @StyleID, 
				@StyleSet = @StyleSet, 
				@CreatedDate = @CDate, 
				@CreatedBy = @CUser,
				@WorkflowItemID = @WorkflowItemID,
				@WorkflowID = @WorkflowID,
				@StyleBOMDimensionID = @StyleBOMDimensionID,
				@NewStyleMaterialID = @NewStyleMaterialID OUTPUT
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09302', GetDate())
GO

