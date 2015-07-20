/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasPage_SELECT]    Script Date: 12/14/2010 12:44:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_SampleRequest_MeasPage_SELECT]
(
@SampleRequestWorkflowID nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(5),
@StyleColorID nvarchar(50),
@WorkflowId nvarchar(50)
)
AS 

SELECT     pAMLMeasHdr.AMLMeasHdrId, pWorkFlowItem.WorkFlowItemID, pWorkFlowItem.WorkflowID, pWorkFlowItem.StyleID, pWorkFlowItem.WorkFlowItemName, 
                      pWorkFlowItem.StyleSet
FROM         pAMLMeasHdr INNER JOIN
                      pWorkFlowItem ON pAMLMeasHdr.WorkFlowItemId = pWorkFlowItem.WorkFlowItemID
                      where pWorkFlowItem.StyleID=@StyleID and pWorkFlowItem.StyleSet=@StyleSet 
                      and pWorkFlowItem.WorkflowID=@WorkflowId order by pWorkFlowItem.Sort
                      
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '874', GetDate())
GO             