
/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_DELETE]    Script Date: 02/08/2011 12:35:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_WorkflowItem_DELETE') 
DROP PROCEDURE spx_WorkflowItem_DELETE
GO
create PROCEDURE [dbo].[spx_WorkflowItem_DELETE]
(
@WorkFlowId uniqueidentifier,
@WorkFlowItemId uniqueidentifier,
@StyleId uniqueidentifier,
@StyleSet int
)
AS

Declare @MeashdrId UNIQUEIDENTIFIER
Declare @Meascnt int
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
VALUES     ('DB_Version', '4.0.0000', '01121', GetDate())