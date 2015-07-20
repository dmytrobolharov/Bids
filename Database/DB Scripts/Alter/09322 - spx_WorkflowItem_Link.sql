/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Link]    Script Date: 02/04/2015 16:08:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_Link]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_Link]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_Link]    Script Date: 02/04/2015 16:08:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_Link]
	(@WorkflowID uniqueidentifier,
	@WorkFlowItemId uniqueidentifier,
	@StyleID uniqueidentifier,
	@CopyStyleID uniqueidentifier,
	@StyleSet int,
	@CopyStyleSet int,
	@CUser nvarchar(100),
	@CDate datetime,
	@SeasonYearID UNIQUEIDENTIFIER = NULL)
AS
 -- @seasonYearID parameter is not used now, but need to be
DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as nvarchar (4)
DECLARE @WorkFlowItemTypeId UNIQUEIDENTIFIER

BEGIN

	SELECT @WorkFlowItemTypeId = WorkFlowItemTypeId from pWorkFlowItem WHERE WorkFlowItemId = @WorkFlowItemId and StyleId = @CopyStyleID  AND  StyleSet = @CopyStyleSet

	SELECT @nCount = count(*) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemTypeId = @WorkFlowItemTypeId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemTypeId = @WorkFlowItemTypeId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as nvarchar (10) ) + '   nMax=' + Cast( @nMax as nvarchar (10) ) + '   nSort=' + Cast( @nSort  as nvarchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 2 )
	print  'vccount 1 = '  + @vcCount

	INSERT INTO pWorkFlowItem
	(WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName, StyleSet, Sort, MDate, MUser, CUser, CDate)
	SELECT top 1 @WorkFlowItemId, @WorkflowID, WorkflowItemTypeId, @StyleID, WorkFlowItemName, @StyleSet, @vcCount, @CDate, @CUser, CUser, CDate
	FROM pWorkFlowItem WITH (NOLOCK)
	WHERE (WorkFlowItemId = @WorkFlowItemId and StyleId = @CopyStyleID  AND  StyleSet = @CopyStyleSet)

	IF @@Error <> 0 OR @@RowCount <> 1 GOTO Error			

	RETURN
Error:
	ROLLBACK TRANSACTION
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09322', GetDate())
GO
