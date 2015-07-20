/****** Object:  StoredProcedure [dbo].[spx_Style_FromSilhouette_CREATE]    Script Date: 10/02/2013 14:10:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_FromSilhouette_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_FromSilhouette_CREATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Style_FromSilhouette_CREATE]    Script Date: 10/02/2013 14:10:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_Style_FromSilhouette_CREATE]
	@StyleFromID UNIQUEIDENTIFIER
	, @StyleToID UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO pWorkFlowItemLinked (WorkFlowItemID, StyleID, StyleSet)
	SELECT StyleWorkflowID AS WorkFlowItemID, @StyleToID AS StyleID, StyleSet FROM pStyleWorkflow
	WHERE (WorkflowID = '40000000-0000-0000-0000-000000000023' OR WorkflowID = '40000000-0000-0000-0000-000000000037') AND StyleID = @StyleFromID 
	UNION
	SELECT WorkFlowItemID, @StyleToID AS StyleID, StyleSet FROM pWorkFlowItem WHERE WorkflowID = '40000000-0000-0000-0000-000000000050'	AND StyleID = @StyleFromID 	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06396', GetDate())
GO