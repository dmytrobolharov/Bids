/****** Object:  StoredProcedure [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMDimSKU_UPDATE]    Script Date: 06/27/2013 12:17:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMDimSKU_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMDimSKU_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMDimSKU_UPDATE]    Script Date: 06/27/2013 12:17:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMDimSKU_UPDATE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @WorkflowID UNIQUEIDENTIFIER
    DECLARE @WorkflowItemID UNIQUEIDENTIFIER
    
    SELECT @WorkflowID = WorkflowID, @WorkflowItemID = WorkflowItemID 
    FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
    
    EXEC spx_StyleBOMDimSKU_Update @StyleBOMDimensionID, 
									@StyleID, 
									@StyleSet, 
									@WorkflowID, 
									@WorkflowItemID, 
									NULL, 
									NULL, 
									NULL, 
									NULL, 
									NULL, 
									NULL, 
									@CUser, 
									@CDate
    
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05932', GetDate())
GO
