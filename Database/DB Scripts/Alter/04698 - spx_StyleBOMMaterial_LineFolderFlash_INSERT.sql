/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]    Script Date: 12/28/2012 15:49:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMaterial_LineFolderFlash_INSERT]    Script Date: 12/28/2012 15:49:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
			@WorkflowItemID UNIQUEIDENTIFIER
			
	SELECT @NewStyleMaterialID = NEWID()
			
	SELECT @StyleID = dim.StyleID, @WorkflowID = wi.WorkflowID, @WorkflowItemID = wi.WorkflowItemID
	FROM pStyleBOMDimension dim INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = dim.WorkFlowItemID
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID

	EXEC spx_StyleBOMTemp_INSERT
				@MainMaterial =  0, 
				@StyleID = @StyleID, 
				@StyleMaterialID  = @NewStyleMaterialID, 
				@StyleSet = 1, 
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
VALUES ('DB_Version', '5.0.0000', '04698', GetDate())
GO
