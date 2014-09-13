IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItem_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_WorkFlowItem_INSERT]
	(@WorkFlowItemId uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemTypeId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@WorkFlowItemName nvarchar(100),
	@CreatedBy nvarchar(100),
	@CreatedDate datetime)
AS 

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

BEGIN
	SELECT @nCount = count(*) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  WorkflowItemTypeId = @WorkflowItemTypeId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  WorkflowItemTypeId = @WorkflowItemTypeId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 2 )
	print  'vccount 1 = '  + @vcCount

	INSERT INTO pWorkFlowItem
	(WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, StyleSet, WorkFlowItemName, Sort, CUser, CDate, MUser, MDate)
	VALUES (@WorkFlowItemId, @WorkflowID, @WorkflowItemTypeId, @StyleID, @StyleSet, @WorkFlowItemName, @vcCount, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	
	if @WorkflowID = "40000000-0000-0000-0000-000000000080"
		begin
			exec spx_StyleBOM_INSERT @StyleID, @Styleset, @WorkFlowID, @WorkFlowItemID, "00000000-0000-0000-0000-000000000000", "<not used>", "00000000-0000-0000-0000-000000000000", "<not used>", "00000000-0000-0000-0000-000000000000", "<not used>", @CreatedBy, @CreatedDate
		end
	
END

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03505', GetDate())



GO
