/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_BOM_WorkflowSubmit_Delete]    Script Date: 07/02/2013 15:41:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_BOM_WorkflowSubmit_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_BOM_WorkflowSubmit_Delete]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_BOM_WorkflowSubmit_Delete]    Script Date: 07/02/2013 15:41:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_BOM_WorkflowSubmit_Delete]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
@SampleRequestHeaderId uniqueidentifier,
@StyleID uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleSet int,
@Submit int,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@SampleRequestAMLHdrID uniqueidentifier)
AS 

DECLARE @vcDate as varchar ( 15 )  
DECLARE @DueDate  as datetime

IF @Submit  =  2
	SET @vcDate = '1900-' +  Cast( (@Submit - 1 ) as varchar (3) )  + '-1' 
ELSE 
	SET @vcDate = '1900-' +  Cast( (@Submit - 1 ) as varchar (3) )  + '-2' 



DECLARE @SampleRequestSubmitID uniqueidentifier
SELECT @SampleRequestSubmitID = SampleRequestSubmitID FROM  pSampleRequestSubmitBOM WITH (NOLOCK)
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)




DELETE FROM   pSampleRequestSubmitBOM WHERE  SampleRequestSubmitID = @SampleRequestSubmitID


delete from pSamplerequestAMLMeasPOM where SampleRequestAMLMeasHdrId= @SampleRequestAMLHdrID
delete from pSamplerequestAMLMeasHdr where SampleRequestAMLMeasHdrId= @SampleRequestAMLHdrID
delete from pSamplerequestAMLMeasIGC where SampleRequestAMLMeasHdrId= @SampleRequestAMLHdrID
delete FROM pSampleRequestAMLmeaslbl where SampleRequestAMLMeasHdrId= @SampleRequestAMLHdrID

select top 1  @DueDate  =a.DueDate 
from pSampleRequestSubmitBOM a WITH (NOLOCK)
where a.SampleRequestTradeID = @SampleRequestTradeID
and a.StyleID =  @StyleID
and SampleWorkflowID= @SampleWorkflowID 
order by Submit DESC


UPDATE  pSampleRequestWorkflowBOM
SET  Status = 0, EndDate = @vcDate, MUser = @ModifiedBy, MDate = @ModifiedDate ,  Submit = @Submit - 1, DueDate = @DueDate
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
       (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID)  
                      
UPDATE  pSampleRequestSubmitBOM
SET  Status = 0, EndDate = NULL, MUser = @ModifiedBy, MDate = @ModifiedDate
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
       (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = (@Submit - 1))




-- DELETE ACTIVITIES

DELETE FROM pSampleRequestBOMActivity 
WHERE SampleRequestSubmitID IN ( 
	SELECT SampleRequestSubmitID  FROM pSampleRequestSubmit WITH (NOLOCK) 
	WHERE SampleRequestTradeID = @SampleRequestTradeID
	AND StyleSet = @StyleSet AND Submit = @Submit 
	and SampleWorkflowID = @SampleWorkflowID 
)

IF @Submit > 1
BEGIN
	DELETE FROM pSampleRequestBOMActivity 
	WHERE SampleRequestSubmitID = ( 
		SELECT SampleRequestSubmitID  FROM pSampleRequestSubmit WITH (NOLOCK) 
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		AND StyleSet = @StyleSet AND Submit = @Submit - 1 
		and SampleWorkflowID = @SampleWorkflowID 
	)
	AND ActivityType= 'R'
END



GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05959', GetDate())
GO
