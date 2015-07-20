IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLItem_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLItem_UPDATE]
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

		
	-- update Sort for suboperation
	IF @MacroId IS NOT NULL
	BEGIN
		UPDATE t2 SET Sort = t1.Sort
		FROM pStyleNBOLItems t1
		INNER JOIN pStyleNBOLItems t2 ON t2.ParentID = t1.TemplateItemID
		WHERE t1.Sort <> t2.Sort
			AND t2.StyleID = @StyleID AND t2.StyleSet = @StyleSet AND t2.WorkFlowItemID = @WorkflowItemID
	END
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03542', GetDate())
GO