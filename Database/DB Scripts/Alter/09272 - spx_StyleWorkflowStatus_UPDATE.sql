/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_UPDATE]    Script Date: 01/23/2015 09:21:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowStatus_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowStatus_UPDATE]    Script Date: 01/23/2015 09:21:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflowStatus_UPDATE] 
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER = NULL,
	@WorkStatus INT
AS

UPDATE dbo.pStyleWorkflow SET WorkStatus = @WorkStatus 
WHERE
StyleID = @StyleID AND
StyleSet = @StyleSet AND
WorkflowID = @WorkflowID AND 
(StyleSeasonYearID = @StyleSeasonYearID OR StyleSeasonYearID is NULL)
 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09272', GetDate())
GO