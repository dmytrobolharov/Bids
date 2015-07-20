IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLTemplate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLTemplate_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLTemplate_INSERT]
(
	@BOLTemplateId uniqueidentifier,
	@StyleID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleSet int,
	@ChangeTemp nvarchar(2),
	@NBOLHeaderID uniqueidentifier,		
	@CDate datetime,
	@CUser nvarchar(200) 
)
AS

BEGIN


IF @ChangeTemp <> '1' -- INSERT New Template
	BEGIN 
	
		INSERT INTO pStyleNBOLHeader (StyleNBOLHeaderID, WorkflowID, WorkFlowItemID, StyleID, StyleSet,
				TemplateID, TemplateName, ImageID, CUser, CDate, MUser, MDate)
		SELECT @NBOLHeaderID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
				@BOLTemplateId, TemplateName, ImageID, @CUser, @CDate, @CUser, @CDate
		FROM pNBOLTemplate 
		WHERE TemplateID = @BOLTemplateId
	
		INSERT INTO pStyleNBOLItems (
				StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID,
				Sort, Sort2, IsLinked, TemplateItemID, OperationID, MacroID, ParentID,
				BaseRate, SAM, CUser, CDate, MUser, MDate, IsException, 
				CurrencyType
				)
		SELECT NEWID(), @StyleID, @StyleSet, @WorkflowID, @WorkflowItemID,
				RIGHT (Sort, 4), Sort2, 1, TemplateItemID, OperationID, MacroID, ParentID,
				BaseRate, SAM,  @CUser, @CDate, @CUser, @CDate, 0, 
				CurrencyType
		FROM pNBOLTemplateItem
		WHERE TemplateID = @BOLTemplateId
		
	END
ELSE -- REPLACE Template
	BEGIN
		
		UPDATE pStyleNBOLHeader 
		SET TemplateID = @BOLTemplateId, 
			TemplateName = t.TemplateName,
			ImageID = t.ImageID,
			MUser = @CUser,
			MDate = @CDate
		FROM pNBOLTemplate t
		WHERE t.TemplateID = @BOLTemplateId AND pStyleNBOLHeader.WorkFlowItemID = @WorkflowItemID

		DELETE FROM pStyleNBOLItems WHERE WorkFlowItemID = @WorkflowItemID
		
		INSERT INTO pStyleNBOLItems (
				StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID,
				Sort, Sort2, IsLinked, TemplateItemID, OperationID, MacroID, ParentID,
				BaseRate, SAM, CUser, CDate, MUser, MDate, IsException, 
				CurrencyType
				)
		SELECT NEWID(), @StyleID, @StyleSet, @WorkflowID, @WorkflowItemID,
				RIGHT (Sort, 4), Sort2, 1, TemplateItemID, OperationID, MacroID, ParentID,
				BaseRate, SAM, @CUser, @CDate, @CUser, @CDate, 0, 
				CurrencyType
		FROM pNBOLTemplateItem
		WHERE TemplateID = @BOLTemplateId
		
				
	END


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06995', GetDate())
GO
