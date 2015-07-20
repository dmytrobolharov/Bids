/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_SpecPage_SELECT]    Script Date: 01/21/2011 10:47:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequest_SpecPage_SELECT') 
DROP PROCEDURE spx_SampleRequest_SpecPage_SELECT
GO

Create PROCEDURE [dbo].[spx_SampleRequest_SpecPage_SELECT]
(
@SampleRequestWorkflowID nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(5),
@StyleColorID nvarchar(50)

)
AS SELECT     '{00000000-0000-0000-0000-000000000000}' AS ID, '0' AS Status, '0' As Submit, 'Development Spec' AS SpecPage, '{00000000-0000-0000-0000-000000000000}' AS SampleWorkflowID
UNION
SELECT     pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.Status, pSampleRequestWorkflow.Submit, 
                      pSampleWorkflow.GroupName, pSampleRequestWorkflow.SampleWorkflowID
FROM         pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                      pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
WHERE     (pSampleWorkflow.GroupID = N'S' 
AND pSampleRequestWorkflow.SampleRequestWorkflowID <> @SampleRequestWorkflowID 
AND pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID
AND pSampleRequestWorkflow.StyleID = @StyleID
AND pSampleRequestWorkflow.StyleSet = @StyleSet
AND pSampleRequestWorkflow.StyleColorID = @StyleColorID)   
ORDER BY SampleWorkflowID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01037', GetDate())
GO