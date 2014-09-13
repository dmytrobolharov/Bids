/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowTemp_SELECT]    Script Date: 06/22/2012 13:11:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowTemp_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowTemp_SELECT]    Script Date: 06/22/2012 13:11:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowTemp_SELECT](@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@StyleColorID uniqueidentifier,
@SampleRequestGroupID uniqueidentifier)
AS 

SELECT     a.SampleRequestWorkflowID, a.SampleWorkflowID, a.SampleRequestGroupID, a.StyleID, 
           a.StyleColorID, a.StyleSet, a.Status, a.Submit, a.TechPackID, a.StartDate, 
           a.DueDate, a.EndDate, 
		   b.SampleWorkflow, b.SampleWorkflowSort, b.GroupName, 
		   a.AssignedTo,  a.SubmitDays, a.ResubmitDays , a.SampleWorkflowFinalDate
FROM         dbo.pSampleRequestWorkflowTemp a WITH (NOLOCK) INNER JOIN
                      dbo.pSampleWorkflow b WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE   a.StyleID = @StyleID  
AND a.StyleSet = @StyleSet
-- AND a.StyleColorID = @StyleColorID
AND a.SampleRequestGroupID = @SampleRequestGroupID
ORDER BY b.SampleWorkflowSort




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03668', GetDate())
GO