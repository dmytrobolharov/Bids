IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_WorkflowItem_DELETE]
(
@WorkFlowId uniqueidentifier,
@WorkFlowItemId uniqueidentifier,
@StyleId uniqueidentifier,
@StyleSet int
)
AS

Declare @MeashdrId UNIQUEIDENTIFIER
Declare @bomId UNIQUEIDENTIFIER
Declare @Meascnt int
Declare @bomcnt int
BEGIN
	DELETE FROM pStyleComment WHERE WorkFlowItemId = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet

	DELETE FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
	
	IF @@Error <> 0 OR @@RowCount <> 1 GOTO Error
	If @WorkFlowId = '80000000-0000-0000-0000-000000000008' 
		BEGIN
			DELETE FROM pConPageDetail WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
		END
	Else If @WorkFlowId = '40000000-0000-0000-0000-000000000050' 
		BEGIN	
			select @Meascnt = COUNT(AMLMeasHdrId) from pamlmeashdr WHERE WorkFlowID = @WorkFlowId and 
			WorkFlowItemID = @WorkFlowItemId
			if @Meascnt<=1 
				begin
					select @MeashdrId = AMLMeasHdrId FROM pamlmeashdr WHERE WorkFlowID = @WorkFlowId and 
					WorkFlowItemID = @WorkFlowItemId 					
					DELETE FROM pAMLMeasHdr WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pAMLMeaslbl WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pAMLMeaspom WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pAMLMeasigc WHERE AMLMeasHdrId = @MeashdrId
				end
		
		END
	Else If @WorkFlowId = '40000000-0000-0000-0000-000000000080' 
		BEGIN	
			select @bomcnt = COUNT(StyleBOMDimensionId) from pStyleBOMDimension WHERE WorkFlowID = @WorkFlowId and 
			WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
			if @bomcnt<=1 
				begin
					select @bomId = StyleBOMDimensionId from pStyleBOMDimension WHERE WorkFlowID = @WorkFlowId and 
					WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
					DELETE FROM pStyleBOMDimension WHERE StyleBOMDimensionId = @bomId
					DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionId = @bomId					
					DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionId = @bomId
					DELETE FROM pStyleBOM WHERE StyleBOMDimensionId=@bomId and 
					WorkFlowID = @WorkFlowId and WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
					DELETE FROM pStyleBOMTemp WHERE StyleBOMDimensionId = @bomId
					DELETE FROM pStyleBOMItem WHERE StyleBOMDimensionId = @bomId
				end
		
		END
	Else If @WorkFlowId = '40000000-0000-0000-0000-000000000018' 
		BEGIN		
			DELETE FROM pStyleComment WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
			DELETE FROM pStyleDetailForm WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
		END
	Else If @WorkFlowId = '40000000-0000-0000-0000-000000000078'  -- BOL v.2
		BEGIN
			DELETE FROM pStyleNBOLExceptionEntries WHERE StyleNBOLItemID IN (SELECT StyleNBOLItemID FROM pStyleNBOLItems WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet)
			DELETE FROM pStyleNBOLException WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
			DELETE FROM pStyleNBOLHeader WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
			DELETE FROM pStyleNBOLItems WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
		END
		
	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03562', GetDate())

GO 