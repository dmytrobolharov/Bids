/****** Object:  StoredProcedure [dbo].[spx_CkeckBOMStyleWorkflow]    Script Date: 06/25/2013 11:12:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CkeckBOMStyleWorkflow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CkeckBOMStyleWorkflow]
GO

CREATE  PROCEDURE [dbo].[spx_CkeckBOMStyleWorkflow]
(
@StyleID uniqueidentifier,
@StyleSet int,
@WorkflowID uniqueidentifier
)
AS 

DECLARE @StyleWorkflowID as uniqueidentifier  

SELECT @StyleWorkflowID = StyleWorkflowId  FROM pStyleHeader WITH (NOLOCK) where StyleID = @StyleID

-- because lots of code checks result of this procedure by equality to 1 
-- and introduction of seasonal workflows we now need to return 0 or 1, not the count
IF @StyleWorkflowID IS NOT NULL 
BEGIN 

	SELECT CASE 
			WHEN COUNT(b.Map) = 0
				THEN 0
			ELSE 1
			END
	FROM dbo.pStyleWorkflow a WITH (NOLOCK)
	INNER JOIN dbo.Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map
	INNER JOIN dbo.pWorkflowStatus c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID
	INNER JOIN dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
	INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map
	WHERE a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet
		AND e.WorkflowTemplateID = @StyleWorkflowID
		AND b.Map = @WorkflowID
	
END 
ELSE 
BEGIN 

	SELECT CASE 
		WHEN COUNT(dbo.Mapping.Map) = 0
			THEN 0
		ELSE 1
		END
	FROM dbo.pStyleWorkflow WITH (NOLOCK)
	INNER JOIN dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map
	INNER JOIN dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
	INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
	WHERE (dbo.pStyleWorkflow.StyleID = @StyleID)
		AND (dbo.pStyleWorkflow.StyleSet = @StyleSet)
		AND Mapping.Map = @WorkflowID


END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05901', GetDate())
GO
