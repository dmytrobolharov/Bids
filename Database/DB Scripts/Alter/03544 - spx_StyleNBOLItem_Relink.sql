IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLItem_Relink]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLItem_Relink]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleNBOLItem_Relink]
(@NBOLItemId UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME )
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

	IF @IsLinked = -1
	BEGIN
		
		-- relink operation
		IF (@OperationId IS NOT NULL) OR (@OperationId IS NULL AND @MacroId IS NULL)
		BEGIN
			UPDATE pStyleNBOLItems 
			SET IsLinked = 1, 
				Code = NULL, Name = NULL, MachineID = NULL, OperationTypeID = NULL,
				BaseRate = ti.BaseRate, SAM = ti.SAM, Coef = NULL, Adj = NULL,
				ImageID = NULL, MUser = @MUser, MDate = @MDate --, Sort = ti.Sort, Sort2 = ti.Sort2
			FROM pNBOLTemplateItem ti
			WHERE StyleNBOLItemID = @NBOLItemId
				AND pStyleNBOLItems.TemplateItemID = ti.TemplateItemID
		END

		-- relink macro
		IF @MacroId IS NOT NULL 
		BEGIN
		
			DECLARE @TemplateItemID as uniqueidentifier
			DECLARE @Sort as nvarchar(5)
			DECLARE @CUser as nvarchar(200)
			DECLARE @CDate as datetime
			
			SELECT @TemplateItemID = TemplateItemID, @Sort = Sort, @CUser = CUser, @CDate = CDate 
			FROM pStyleNBOLItems WHERE StyleNBOLItemID = @NBOLItemId
		
			--relink macro item
			UPDATE pStyleNBOLItems 
			SET IsLinked = 1, 
				Code = NULL, Name = NULL, MachineID = NULL, OperationTypeID = NULL,
				BaseRate = ti.BaseRate, SAM = ti.SAM, Coef = NULL, Adj = NULL,
				ImageID = NULL, MUser = @MUser, MDate = @MDate --, Sort = ti.Sort, Sort2 = ti.Sort2
			FROM pNBOLTemplateItem ti
			WHERE StyleNBOLItemID = @NBOLItemId
				AND pStyleNBOLItems.TemplateItemID = ti.TemplateItemID


			-- delete unlinked suboperations of macro
			DELETE FROM pStyleNBOLItems
			WHERE ParentID = @TemplateItemID AND StyleID = @StyleID AND StyleSet = @StyleSet AND WorkFlowItemID = @WorkflowItemID
			
			-- insert linked suboperations of macro
			INSERT INTO pStyleNBOLItems (
					StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID,
					Sort, Sort2, IsLinked, TemplateItemID, OperationID, MacroID, ParentID,
					BaseRate, SAM, CUser, CDate, MUser, MDate, IsException
					)
			SELECT NEWID(), @StyleID, @StyleSet, @WorkflowID, @WorkflowItemID,
					RIGHT (@Sort, 4), Sort2, 1, TemplateItemID, OperationID, MacroID, ParentID,
					BaseRate, SAM, @CUser, @CDate, @MUser, @MDate, 0
			FROM pNBOLTemplateItem
			WHERE ParentID = @TemplateItemID
			
			
		END
	
	END
	
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03544', GetDate())
GO