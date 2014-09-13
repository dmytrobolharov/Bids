/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItemBOMList_SELECT]    Script Date: 06/21/2013 10:53:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItemBOMList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItemBOMList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItemBOMList_SELECT]    Script Date: 06/21/2013 10:53:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_WorkFlowItemBOMList_SELECT] 
(   @WorkflowId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet1 int,
	@StyleSet2 int = null,
	@StyleSet3 int = null,
	@StyleSet4 int = null,
	@SeasonYearID uniqueidentifier
)
AS
BEGIN
	DECLARE @StyleSeasonYearID uniqueidentifier
	
	SELECT @StyleSeasonYearID = styleSeasonYearID from pStyleSeasonYear where SeasonYearID= @SeasonYearID
	
	SELECT WorkFlowItemID,WorkflowItemTypeId,WorkFlowItemName
	FROM pWorkFlowItem  
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet1
	AND WorkflowId = @WorkflowId
	AND StyleSeasonYearID = @StyleSeasonYearID
	Order By Sort
	
IF(@StyleSet2 is not null )
BEGIN
	SELECT WorkFlowItemID,WorkflowItemTypeId,WorkFlowItemName
	FROM pWorkFlowItem  
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet2
	AND WorkflowId = @WorkflowId
	AND StyleSeasonYearID = @StyleSeasonYearID
	Order By Sort
END	

IF(@StyleSet3 is not null )
BEGIN
	SELECT WorkFlowItemID,WorkflowItemTypeId,WorkFlowItemName
	FROM pWorkFlowItem  
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet3
	AND WorkflowId = @WorkflowId
	AND StyleSeasonYearID = @StyleSeasonYearID
	Order By Sort
END	
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05892', GetDate())
GO