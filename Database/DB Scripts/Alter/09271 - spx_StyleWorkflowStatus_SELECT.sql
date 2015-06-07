/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_SELECT]    Script Date: 01/23/2015 09:21:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowStatus_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_SELECT]    Script Date: 01/23/2015 09:21:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleWorkflowStatus_SELECT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER = NULL
	
)
AS

SELECT WorkStatus 
FROM pStyleWorkflow
WHERE
StyleID = @StyleID AND
StyleSet = @StyleSet AND
WorkflowID = @WorkflowID AND 
(StyleSeasonYearID = @StyleSeasonYearID OR StyleSeasonYearID is NULL)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09271', GetDate())
GO