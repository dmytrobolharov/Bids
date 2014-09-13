IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowCount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowCount_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowCount_SELECT](@StyleId uniqueidentifier)
AS 

;WITH srw as (
	SELECT SampleRequestWorkflowID, StyleID FROM pSampleRequestWorkflow
	UNION
	SELECT SampleRequestWorkflowID, StyleID FROM pSampleRequestWorkflowBOM
)
SELECT COUNT(*) AS SubmitCount
FROM srw WITH (NOLOCK)
WHERE (StyleID = @StyleId)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06986', GetDate())
GO
