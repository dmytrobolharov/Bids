IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLItem_DELETE]
(@NBOLItemId UNIQUEIDENTIFIER)
AS

DECLARE @OperationId as uniqueidentifier
DECLARE @MacroId as uniqueidentifier
DECLARE @WorkflowID as uniqueidentifier
DECLARE @WorkflowItemID as uniqueidentifier
DECLARE @StyleID as uniqueidentifier
DECLARE @StyleSet as int
DECLARE @IsLinked as int

BEGIN

	SELECT @IsLinked = IsLinked, @StyleID = StyleID, @StyleSet = StyleSet, @WorkflowID = WorkFlowID, @WorkflowItemID = WorkFlowItemID, 
		@MacroId = MacroID, @OperationId = OperationID 
	FROM pStyleNBOLItems WHERE StyleNBOLItemID = @NBOLItemId

		
	-- operation
	IF (@OperationId IS NOT NULL) OR (@OperationId IS NULL AND @MacroId IS NULL)
	BEGIN
		DELETE FROM pStyleNBOLItems WHERE StyleNBOLItemID = @NBOLItemId
		
		DELETE FROM pStyleNBOLExceptionEntries WHERE StyleNBOLItemID = @NBOLItemId
	END

	-- macro
	IF @MacroId IS NOT NULL 
	BEGIN
	
		DECLARE @TemplateItemID as uniqueidentifier
		SELECT @TemplateItemID = TemplateItemID FROM pStyleNBOLItems WHERE StyleNBOLItemID = @NBOLItemId
	
		DELETE FROM pStyleNBOLExceptionEntries WHERE StyleNBOLItemID = @NBOLItemId
		DELETE FROM pStyleNBOLExceptionEntries WHERE StyleNBOLItemID IN
			(SELECT StyleNBOLItemID FROM pStyleNBOLItems WHERE ParentID = @TemplateItemID  AND StyleID = @StyleID AND StyleSet = @StyleSet AND WorkFlowItemID = @WorkflowItemID) 

		DELETE FROM pStyleNBOLItems WHERE StyleNBOLItemID = @NBOLItemId
		DELETE FROM pStyleNBOLItems WHERE ParentID = @TemplateItemID AND StyleID = @StyleID AND StyleSet = @StyleSet AND WorkFlowItemID = @WorkflowItemID
		
	END
	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03541', GetDate())
GO