
IF EXISTS (select * from sysobjects where id = object_id('spx_WorkflowItem_COPY') and sysstat & 0xf = 4)
	drop procedure spx_WorkflowItem_COPY
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_COPY]
	(@WorkflowID uniqueidentifier,
	@WorkFlowItemId uniqueidentifier,
	@StyleID uniqueidentifier,
	@CopyStyleID uniqueidentifier,
	@StyleSet int,
	@CopyStyleSet int,
	@CUser nvarchar(100),
	@CDate datetime)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)
DECLARE @NewWorkFlowItemId UNIQUEIDENTIFIER
DECLARE @WorkFlowItemTypeId UNIQUEIDENTIFIER

BEGIN


	SET @NewWorkFlowItemId = NEWID()
	SELECT @WorkFlowItemTypeId = WorkFlowItemTypeId from pWorkFlowItem WHERE WorkFlowItemId = @WorkFlowItemId

	SELECT @nCount = count(*) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemTypeId = @WorkFlowItemTypeId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemTypeId = @WorkFlowItemTypeId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 2 )
	print  'vccount 1 = '  + @vcCount

	INSERT INTO pWorkFlowItem
	(WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName, StyleSet, Sort, MDate, MUser, CUser, CDate)
	SELECT @NewWorkFlowItemId, @WorkflowID, WorkflowItemTypeId, @StyleID, WorkFlowItemName, @StyleSet, @vcCount, @CDate, @CUser, CUser, CDate
	FROM pWorkFlowItem WITH (NOLOCK)
	WHERE (WorkFlowItemId = @WorkFlowItemId)

	IF @@Error <> 0 OR @@RowCount <> 1 GOTO Error

	INSERT INTO pConPageDetail
	( StyleID, WorkflowID, WorkFlowItemId, Sort, StyleSet, Detail, OrigOperationSN, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3, 
      AuxField4, AuxField5, Linked, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate)
	SELECT @StyleID, @WorkflowID, @NewWorkFlowItemId, Sort, @StyleSet, Detail, OrigOperationSN, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3, 
	AuxField4, AuxField5, Linked, Level1ID, Level2ID, Level3ID, @CUser, @CDate, @CUser, @CDate
	FROM pConPageDetail WITH (NOLOCK)
	WHERE StyleID = @CopyStyleID
	AND WorkflowItemID = @WorkflowItemID
	AND StyleSet = @CopyStyleSet

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '765', GetDate())

GO