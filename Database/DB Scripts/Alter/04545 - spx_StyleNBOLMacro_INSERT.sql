/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLMacro_INSERT]    Script Date: 12/05/2012 13:48:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLMacro_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLMacro_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLMacro_INSERT]    Script Date: 12/05/2012 13:48:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleNBOLMacro_INSERT]
(@MacroId UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@WorkflowId UNIQUEIDENTIFIER,
@WorkflowItemId UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME,
@IsException INT )
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

BEGIN

	SELECT @nCount = count(*) FROM pStyleNBOLItems WITH (NOLOCK) WHERE (StyleID = @StyleID)  AND  (StyleSet = @StyleSet) AND (WorkFlowItemID = @WorkflowItemId) AND (ParentID IS NULL)
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleNBOLItems WITH (NOLOCK) WHERE (StyleID = @StyleID)  AND  (StyleSet = @StyleSet) AND (WorkFlowItemID = @WorkflowItemId) AND (ParentID IS NULL)
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 4 )
	print  'vccount 1 = '  + @vcCount


	-- ItemId of inserted Macro
	DECLARE @NewItemId uniqueidentifier = NEWID()

	INSERT INTO pStyleNBOLItems
		(StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID, TemplateItemID, IsLinked,
		 Sort, MacroID, ImageID, Code, Name, CUser, CDate, MUser, MDate, IsException)
	SELECT @NewItemId, @StyleID, @StyleSet, @WorkflowId, @WorkflowItemId, @NewItemId, 0,
		 @vcCount, @MacroId, ImageID, MacroCode, MacroName, @CUser, @CDate, @CUser, @CDate, @IsException
	FROM pNBOLMacro
	WHERE MacroID = @MacroId


	INSERT INTO pStyleNBOLItems
		(StyleID, StyleSet, WorkFlowID, WorkFlowItemID, TemplateItemID, ParentID, IsLinked,
		 Sort, Sort2, OperationID, ImageID, Code, Name, MachineID, OperationTypeID, BaseRate,
		 CUser, CDate, MUser, MDate, IsException)
	SELECT @StyleID, @StyleSet, @WorkflowId, @WorkflowItemId, '00000000-0000-0000-0000-000000000000', @NewItemId, 0,
		 @vcCount, otm.Sort, o.OperationID, o.ImageID, o.OperationCode, o.OperationName, o.MachineID, o.OperationTypeID, ot.DefaultPrice,
		 @CUser, @CDate, @CUser, @CDate, @IsException
	FROM pNBOLOpToMacro otm 
	INNER JOIN pNBOLOperation o	ON otm.OperationID = o.OperationID
	LEFT JOIN pNBOLOperationType ot ON o.OperationTypeID = ot.OperationTypeID
	WHERE otm.MacroID = @MacroId


	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04545', GetDate())
GO