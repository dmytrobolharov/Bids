IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_WorkFlowItem_INSERT]
	(@WorkFlowItemId uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemTypeId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@WorkFlowItemName nvarchar(100),
	@CreatedBy nvarchar(100),
	@CreatedDate datetime,
	@StyleSeasonYearID uniqueidentifier = NULL)
AS 

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as nvarchar (4)

DECLARE @WorkStart as datetime 
DECLARE @WorkDue as datetime 
DECLARE @WorkAssignedTo as int 
DECLARE @WorkStatus as int 
DECLARE @WorkEscalateTo as int 
DECLARE @IsSeasonal as int

BEGIN
	SELECT @IsSeasonal = IsSeasonal FROM Mapping WHERE Map = @WorkflowID	

	if @IsSeasonal = 1 AND @StyleSeasonYearID IS NOT NULL
		SELECT @nCount = count(*) 
		FROM pWorkFlowItem WITH (NOLOCK) 
		WHERE StyleId = @StyleID  AND  WorkflowItemTypeId = @WorkflowItemTypeId AND StyleSeasonYearID = @StyleSeasonYearID
	else	
		SELECT @nCount = count(*) 
		FROM pWorkFlowItem WITH (NOLOCK) 
		WHERE StyleId = @StyleID  AND  WorkflowItemTypeId = @WorkflowItemTypeId
	
	SELECT @nMax = cast (   MAX (Sort)  as int ) 
	FROM pWorkFlowItem WITH (NOLOCK) 
	WHERE StyleId = @StyleID  AND  WorkflowItemTypeId = @WorkflowItemTypeId
	
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0
	
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	--print  'nCount=' + Cast(@nCount  as nvarchar (10) ) + '   nMax=' + Cast( @nMax as nvarchar (10) ) + '   nSort=' + Cast( @nSort  as nvarchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 2 )
	--print  'vccount 1 = '  + @vcCount

	SELECT @WorkStart=WorkStart, @WorkDue=WorkDue, @WorkAssignedTo=WorkAssignedTo, @WorkStatus=WorkStatus, @WorkEscalateTo=WorkEscalateTo
	FROM pStyleWorkflow 
	WHERE StyleID=@StyleID and WorkflowID=@WorkflowID and StyleSet=@StyleSet

	INSERT INTO pWorkFlowItem
	(WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, StyleSet, WorkFlowItemName, Sort, CUser, CDate, MUser, MDate,WorkStart, WorkDue,WorkAssignedTo,WorkStatus,WorkEscalateTo, StyleSeasonYearID)
	VALUES (@WorkFlowItemId, @WorkflowID, @WorkflowItemTypeId, @StyleID, @StyleSet, @WorkFlowItemName, @vcCount, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate,@WorkStart, @WorkDue,@WorkAssignedTo,@WorkStatus,@WorkEscalateTo, @StyleSeasonYearID)
	
	SELECT @@ROWCOUNT --Returns No. of Records INSERTED
	
	IF @WorkflowID = '40000000-0000-0000-0000-000000000080'
	BEGIN
		DECLARE @ColorDimID UNIQUEIDENTIFIER = (SELECT DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Color'),
				@SizeDimID UNIQUEIDENTIFIER = (SELECT DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Size')
				
		EXEC spx_StyleBOM_INSERT @StyleID, @Styleset, @WorkFlowID, @WorkFlowItemID, @ColorDimID, 'Color', @SizeDimID, 'Size', '00000000-0000-0000-0000-000000000000', '<not used>', @CreatedBy, @CreatedDate
	END
	ELSE IF @WorkflowID = '40000000-0000-0000-0000-000000000090'
	BEGIN
		INSERT INTO pStyleSKUItem(WorkflowItemID, ItemDim1TypeID, ItemDim2TypeID, ItemDim3TypeID)
		VALUES (@WorkflowItemID, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
	END
END





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07006', GetDate())
GO
