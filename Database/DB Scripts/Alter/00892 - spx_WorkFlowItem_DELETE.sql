IF EXISTS (select * from sysobjects where id = object_id('spx_WorkflowItem_DELETE') and sysstat & 0xf = 4)
	drop procedure spx_WorkflowItem_DELETE
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
			select @MeashdrId = AMLMeasHdrId FROM pamlmeashdr WHERE WorkFlowID = @WorkFlowId and 
			WorkFlowItemID = @WorkFlowItemId AND StyleId= @StyleId AND StyleSet = @StyleSet
			
			DELETE FROM pAMLMeasHdr WHERE AMLMeasHdrId = @MeashdrId
			DELETE FROM pAMLMeaslbl WHERE AMLMeasHdrId = @MeashdrId
			DELETE FROM pAMLMeaspom WHERE AMLMeasHdrId = @MeashdrId
			DELETE FROM pAMLMeasigc WHERE AMLMeasHdrId = @MeashdrId
		
		END
	Else If @WorkFlowId = '40000000-0000-0000-0000-000000000018' 
		BEGIN		
			DELETE FROM pStyleComment WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
			DELETE FROM pStyleDetailForm WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
		END
		
	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '892', GetDate())
GO 