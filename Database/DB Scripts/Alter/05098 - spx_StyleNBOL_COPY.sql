/****** Object:  StoredProcedure [dbo].[spx_StyleNBOL_Copy]    Script Date: 02/21/2013 16:52:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOL_Copy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOL_Copy]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNBOL_Copy]    Script Date: 02/21/2013 16:52:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOL_Copy]
 (@WorkflowID uniqueidentifier,  
 @NewWorkFlowItemId uniqueidentifier,  
 @OldWorkFlowItemId uniqueidentifier,  
 @NewStyleID uniqueidentifier,  
 @OldStyleID uniqueidentifier,  
 @NewStyleSet int,  
 @OldStyleSet int,  
 @CUser nvarchar(100),  
 @CDate datetime)  
AS
BEGIN

	-- copy header record
	INSERT INTO pStyleNBOLHeader
	(StyleNBOLHeaderID, StyleNBOLHeaderCopyMasterID, WorkflowID, WorkFlowItemID, StyleID, StyleSet, TemplateID, TemplateName, ImageID, 
	CUser, CDate, MUser, MDate, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5)
	SELECT NEWID(), @OldStyleID, WorkflowID, @NewWorkFlowItemId, @NewStyleID, @NewStyleSet, TemplateID, TemplateName, ImageID,
	@CUser, @CDate, @CUser, @CDate, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5
	FROM pStyleNBOLHeader WITH (NOLOCK)  
    WHERE StyleID = @OldStyleID  
    AND WorkflowItemID = @OldWorkflowItemID  
    AND StyleSet = @OldStyleSet  

	-- table to associate New and Old "StyleNBOLItemID" IDs (it is needed for copying of exceptions data)
	CREATE TABLE #NewToOld_Item (
		StyleNBOLItemID uniqueidentifier, 
		NewStyleNBOLItemID uniqueidentifier
	)
	
	INSERT INTO #NewToOld_Item (StyleNBOLItemID, NewStyleNBOLItemID)
	SELECT StyleNBOLItemID, NEWID()
	FROM pStyleNBOLItems  WITH (NOLOCK)  
    WHERE StyleID = @OldStyleID  
    AND WorkflowItemID = @OldWorkflowItemID  
    AND StyleSet = @OldStyleSet
    AND ((IsLinked <> 0) OR (IsLinked = 0 AND OperationID IS NOT NULL AND ParentID IS NULL) OR (OperationID IS NULL AND MacroID IS NULL))

	-- table to associate New and Old "Exception" IDs (it is needed for copying of exceptions data)
	CREATE TABLE #NewToOld_Except (
		ROW int identity, 
		ExceptionID uniqueidentifier, 
		NewExceptionID uniqueidentifier
	)
	
	INSERT INTO #NewToOld_Except (ExceptionID, NewExceptionID)
	VALUES ('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
	
	INSERT INTO #NewToOld_Except (ExceptionID, NewExceptionID)
	SELECT ExceptionID, NEWID()
	FROM pStyleNBOLException WITH (NOLOCK)  
    WHERE StyleID = @OldStyleID AND StyleSet = @OldStyleSet AND WorkflowItemID = @OldWorkflowItemID
    ORDER BY Sort
    
	-- copying linked and unlinked to template operations and macro-operations (Linked = 1 or -1)
	-- and added by user operations (Linked = 0)
	INSERT INTO pStyleNBOLItems
	(StyleNBOLItemID, StyleNBOLItemCopyMasterID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID, Sort, Sort2, IsLinked, TemplateItemID, 
	OperationID, MacroID, ParentID, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate, SAM, Coef, 
	Adj, Comments, CUser, CDate, MUser, MDate, IsException)
	SELECT #NewToOld_Item.NewStyleNBOLItemID, pStyleNBOLItems.StyleNBOLItemID, @NewStyleID, @NewStyleSet, WorkFlowID, @NewWorkFlowItemId, Sort, Sort2, IsLinked, TemplateItemID, 
	OperationID, MacroID, ParentID, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate, SAM, Coef, 
	Adj, Comments, CUser, CDate, MUser, MDate, IsException
	FROM pStyleNBOLItems  WITH (NOLOCK) INNER JOIN #NewToOld_Item ON pStyleNBOLItems.StyleNBOLItemID = #NewToOld_Item.StyleNBOLItemID
    WHERE StyleID = @OldStyleID  
    AND WorkflowItemID = @OldWorkflowItemID  
    AND StyleSet = @OldStyleSet
    AND ((IsLinked <> 0) OR (IsLinked = 0 AND OperationID IS NOT NULL AND ParentID IS NULL) OR (OperationID IS NULL AND MacroID IS NULL))
	

	DECLARE @iROW int = 1
	DECLARE @iCountExceptions int = (SELECT COUNT(*) FROM #NewToOld_Except)
	DECLARE @ExceptionId uniqueidentifier
	DECLARE @NewExceptionId uniqueidentifier

	-- copying exceptions data
	WHILE @iROW <= @iCountExceptions
	BEGIN
		SELECT @ExceptionId = ExceptionID FROM #NewToOld_Except WHERE ROW = @iROW
		SELECT @NewExceptionId = NewExceptionID FROM #NewToOld_Except WHERE ROW = @iROW
		
		print @iROW
		
		INSERT INTO pStyleNBOLExceptionEntries (ExceptionID, StyleNBOLItemID)
		SELECT @NewExceptionId, #NewToOld_Item.NewStyleNBOLItemID
		FROM pStyleNBOLExceptionEntries INNER JOIN #NewToOld_Item 
			ON pStyleNBOLExceptionEntries.StyleNBOLItemID = #NewToOld_Item.StyleNBOLItemID
		WHERE pStyleNBOLExceptionEntries.ExceptionID = @ExceptionId
		
		IF @iROW > 1
		BEGIN
			INSERT INTO pStyleNBOLException (ExceptionID, StyleID, StyleSet, 
				WorkflowID, WorkflowItemID, ExceptionName, CUser, CDate, MUser, MDate, Active, Sort)
			SELECT @NewExceptionId, @NewStyleID, @NewStyleSet,
				@WorkflowID, @NewWorkFlowItemId, ExceptionName, @CUser, @CDate, @CUser, @CDate, Active, Sort
			FROM pStyleNBOLException WHERE ExceptionID = @ExceptionId
		END
		
		SET @iROW = @iROW + 1
    END
	
    DECLARE @MacroId uniqueidentifier
    DECLARE @OldStyleNBOLItemId uniqueidentifier
    DECLARE @NewStyleNBOLItemId uniqueidentifier
    
    -- cursor for macro with Linked=0 (not added from template)
    -- in order to maintain their suboperations (set them "ParentID" of macro)
    DECLARE cursor_macrooperations CURSOR FOR 
	SELECT MacroID, StyleNBOLItemID FROM pStyleNBOLItems WITH (NOLOCK) WHERE StyleID = @OldStyleID AND StyleSet = @OldStyleSet 
		AND WorkflowItemID = @OldWorkflowItemID AND IsLinked = 0 AND MacroID IS NOT NULL
	OPEN cursor_macrooperations
	FETCH NEXT FROM cursor_macrooperations INTO @MacroId, @OldStyleNBOLItemId  
	  
	WHILE @@FETCH_STATUS = 0   
	BEGIN
	
	 -- new id of macro
	 SET @NewStyleNBOLItemId = NEWID()
	
	 -- insert macro
	 INSERT INTO pStyleNBOLItems
	 (StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID, Sort, Sort2, IsLinked, TemplateItemID, 
	 OperationID, MacroID, ParentID, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate, SAM, Coef, 
	 Adj, Comments, CUser, CDate, MUser, MDate, IsException)
	 SELECT @NewStyleNBOLItemId, @NewStyleID, @NewStyleSet, WorkFlowID, @NewWorkFlowItemId, Sort, Sort2, IsLinked, @NewStyleNBOLItemId, 
	 OperationID, MacroID, ParentID, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate, SAM, Coef, 
	 Adj, Comments, CUser, CDate, MUser, MDate, IsException
	 FROM pStyleNBOLItems  WITH (NOLOCK)  
     WHERE StyleID = @OldStyleID  
     AND WorkflowItemID = @OldWorkflowItemID  
     AND StyleSet = @OldStyleSet
     AND StyleNBOLItemID = @OldStyleNBOLItemId

     DELETE FROM #NewToOld_Item

     INSERT INTO #NewToOld_Item
     SELECT StyleNBOLItemID, NEWID()
     FROM pStyleNBOLItems  WITH (NOLOCK)  
     WHERE StyleID = @OldStyleID  
     AND WorkflowItemID = @OldWorkflowItemID  
     AND StyleSet = @OldStyleSet
     AND (IsLinked = 0 AND OperationID IS NOT NULL AND ParentID = @OldStyleNBOLItemId)
	 
	 -- insert operation of macro (with ParentID)
	 INSERT INTO pStyleNBOLItems
	 (StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID, Sort, Sort2, IsLinked, TemplateItemID, 
	 OperationID, MacroID, ParentID, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate, SAM, Coef, 
	 Adj, Comments, CUser, CDate, MUser, MDate, IsException)
	 SELECT #NewToOld_Item.NewStyleNBOLItemID, @NewStyleID, @NewStyleSet, WorkFlowID, @NewWorkFlowItemId, Sort, Sort2, IsLinked, TemplateItemID, 
	 OperationID, MacroID, @NewStyleNBOLItemId, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate, SAM, Coef, 
	 Adj, Comments, CUser, CDate, MUser, MDate, IsException
	 FROM pStyleNBOLItems  WITH (NOLOCK) INNER JOIN #NewToOld_Item ON pStyleNBOLItems.StyleNBOLItemID = #NewToOld_Item.StyleNBOLItemID
     WHERE StyleID = @OldStyleID  
     AND WorkflowItemID = @OldWorkflowItemID  
     AND StyleSet = @OldStyleSet
     AND (IsLinked = 0 AND OperationID IS NOT NULL AND ParentID = @OldStyleNBOLItemId)
     
	 -- copying exceptions data     
     SET @iROW = 1
     WHILE @iROW <= @iCountExceptions
	 BEGIN
		SELECT @ExceptionId = ExceptionID FROM #NewToOld_Except WHERE ROW = @iROW
		SELECT @NewExceptionId = NewExceptionID FROM #NewToOld_Except WHERE ROW = @iROW
		
		INSERT INTO pStyleNBOLExceptionEntries (ExceptionID, StyleNBOLItemID)
		SELECT @NewExceptionId, #NewToOld_Item.NewStyleNBOLItemID
		FROM pStyleNBOLExceptionEntries INNER JOIN #NewToOld_Item 
			ON pStyleNBOLExceptionEntries.StyleNBOLItemID = #NewToOld_Item.StyleNBOLItemID
		WHERE pStyleNBOLExceptionEntries.ExceptionID = @ExceptionId
		
		SET @iROW = @iROW + 1
     END


	 FETCH NEXT FROM cursor_macrooperations INTO @MacroId, @OldStyleNBOLItemId 
	END   
	  
	CLOSE cursor_macrooperations  
	DEALLOCATE cursor_macrooperations  	

	DROP TABLE #NewToOld_Item
    DROP TABLE #NewToOld_Except


END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05098', GetDate())
GO
