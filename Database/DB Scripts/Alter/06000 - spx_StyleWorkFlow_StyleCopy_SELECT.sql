/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_StyleCopy_SELECT]    Script Date: 07/04/2013 14:17:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_StyleCopy_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_StyleCopy_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_StyleCopy_SELECT]    Script Date: 07/04/2013 14:17:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflow_StyleCopy_SELECT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS 

DECLARE @StyleWorkflowID AS UNIQUEIDENTIFIER,
		@StyleSeasonYearID AS UNIQUEIDENTIFIER
	
SELECT @StyleWorkflowID = StyleWorkflowId  
FROM pStyleHeader WITH (NOLOCK) 
WHERE StyleID = @StyleID

SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

CREATE TABLE #tmp(
	rowid INT IDENTITY(1,1),
	Map UNIQUEIDENTIFIER,
	MapDetail  NVARCHAR(200),
	Sort int 
)


IF @StyleWorkflowID IS NOT NULL 
BEGIN 
	
	
	SELECT b.Map, b.MapDetail
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map 
	WHERE a.StyleID = @StyleID  
		AND  a.StyleSet  =  @StyleSet 
		AND e.WorkflowTemplateID = @StyleWorkflowID
		AND b.Map NOT IN (
			 '40000000-0000-0000-0000-000000000004',
			 '40000000-0000-0000-0000-000000000044')
		AND (b.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID OR b.IsSeasonal <> 1)
	ORDER BY e.WorkflowSort,  e.WorkflowID
	
	
	
	SELECT b.Map, b.MapDetail, f.WorkFlowItemID, f.WorkFlowItemName, f.Sort, e.WorkflowID , e.WorkflowSort
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map 
		INNER JOIN pWorkFlowItem f WITH(NOLOCK)  ON f.WorkflowID = a.WorkflowID 
			AND f.StyleID = a.StyleID AND f.StyleSet = a.StyleSet
		INNER JOIN pWorkFlowItemType g	WITH(NOLOCK) ON g.WorkflowItemTypeId = f.WorkflowItemTypeId
	WHERE a.StyleID = @StyleID  
		AND  a.StyleSet  =  @StyleSet 
		AND e.WorkflowTemplateID = @StyleWorkflowID
		AND (b.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID AND f.StyleSeasonYearID = @StyleSeasonYearID OR b.IsSeasonal <> 1)
	UNION
	SELECT b.Map, b.MapDetail, f.WorkFlowItemID, f.WorkFlowItemName, f.Sort, e.WorkflowID , e.WorkflowSort
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map 
		INNER JOIN pWorkFlowItem f WITH(NOLOCK)  ON f.WorkflowID = a.WorkflowID 
		INNER JOIN pWorkFlowItemLinked d ON f.WorkFlowItemID = d.WorkFlowItemID AND d.StyleID = a.StyleID AND d.StyleSet = a.StyleSet
		INNER JOIN pWorkFlowItemType g	WITH(NOLOCK) ON g.WorkflowItemTypeId = f.WorkflowItemTypeId
	WHERE a.StyleID = @StyleID  
		AND  a.StyleSet  =  @StyleSet 
		AND e.WorkflowTemplateID = @StyleWorkflowID
		AND (b.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID AND f.StyleSeasonYearID = @StyleSeasonYearID OR b.IsSeasonal <> 1)	
	ORDER BY e.WorkflowSort,  e.WorkflowID, f.Sort
	
	
	
END 
ELSE 
BEGIN 

	SELECT b.Map, b.MapDetail
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pStyleHeader c WITH (NOLOCK) ON a.StyleID = c.StyleID
	WHERE a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet
		AND b.Map NOT IN (
			 '40000000-0000-0000-0000-000000000004',
			 '40000000-0000-0000-0000-000000000044')
		AND (b.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID OR b.IsSeasonal <> 1)
	ORDER BY a.WorkSort,  a.WorkflowID
	
	SELECT b.Map, b.MapDetail, f.WorkFlowItemID, f.WorkFlowItemName, f.Sort
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pStyleHeader c WITH (NOLOCK) ON a.StyleID = c.StyleID
		INNER JOIN pWorkFlowItem f WITH(NOLOCK)  ON f.StyleID = a.StyleID AND f.StyleSet = a.StyleSet
			AND f.WorkflowID = b.Map
		INNER JOIN	pWorkFlowItemType g	WITH(NOLOCK) ON g.WorkflowItemTypeId = f.WorkflowItemTypeId		
	WHERE a.StyleID = @StyleID
		 AND a.StyleSet = @StyleSet
		 AND (b.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID AND f.StyleSeasonYearID = @StyleSeasonYearID OR b.IsSeasonal <> 1)
	ORDER BY a.WorkSort,  a.WorkflowID, f.Sort
	

END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06000', GetDate())
GO
