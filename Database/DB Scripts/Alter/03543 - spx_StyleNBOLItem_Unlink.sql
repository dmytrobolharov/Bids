IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLItem_Unlink]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLItem_Unlink]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLItem_Unlink]
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

	IF @IsLinked = 1
	BEGIN
		
		-- unlink operation
		IF (@OperationId IS NOT NULL) OR (@OperationId IS NULL AND @MacroId IS NULL)
		BEGIN
			UPDATE pStyleNBOLItems 
			SET IsLinked = -1, 
				Code = ti.Code, Name = ti.Name, MachineID = ti.MachineID, OperationTypeID = ti.OperationTypeID,
				--BaseRate = ti.BaseRate, SAM = ti.SAM,
				ImageID = ti.ImageID--, Sort = ti.Sort, Sort2 = ti.Sort2
			FROM pNBOLTemplateItem ti
			WHERE StyleNBOLItemID = @NBOLItemId AND pStyleNBOLItems.TemplateItemID = ti.TemplateItemID
		END

		-- unlink macro
		IF @MacroId IS NOT NULL 
		BEGIN
		
			DECLARE @TemplateItemID as uniqueidentifier
			SELECT @TemplateItemID = TemplateItemID FROM pStyleNBOLItems WHERE StyleNBOLItemID = @NBOLItemId
		
				UPDATE pStyleNBOLItems 
				SET IsLinked = -1, 
					Code = ti.Code, Name = ti.Name, MachineID = ti.MachineID, OperationTypeID = ti.OperationTypeID,
					--BaseRate = ti.BaseRate, SAM = ti.SAM,
					ImageID = ti.ImageID--, Sort = ti.Sort, Sort2 = ti.Sort2
				FROM pNBOLTemplateItem ti
				WHERE StyleNBOLItemID = @NBOLItemId  AND ti.TemplateItemID = @TemplateItemID


				UPDATE sbi
				SET IsLinked = -1, 
					Code = ti.Code, Name = ti.Name, MachineID = ti.MachineID, OperationTypeID = ti.OperationTypeID,
					--BaseRate = ti.BaseRate, SAM = ti.SAM,
					ImageID = ti.ImageID--, Sort = ti.Sort, Sort2 = ti.Sort2
				FROM pNBOLTemplateItem ti inner join pStyleNBOLItems sbi ON ti.TemplateItemID = sbi.TemplateItemID
				WHERE sbi.ParentID = @TemplateItemID AND StyleID = @StyleID AND StyleSet = @StyleSet AND WorkFlowItemID = @WorkflowItemID
				
		END
	
	END
	
	
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03543', GetDate())
GO