/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasWorkflowSubmit_Delete]    Script Date: 12/14/2010 12:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_SampleRequest_MeasWorkflowSubmit_Delete]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
@SampleRequestHeaderId uniqueidentifier,
@StyleID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleSet int,
@Submit int,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime)
AS 

DECLARE @vcDate as varchar ( 15 )  
DECLARE @DueDate  as datetime

IF @Submit  =  2
	SET @vcDate = '1900-' +  Cast( (@Submit - 1 ) as varchar (3) )  + '-1' 
ELSE 
	SET @vcDate = '1900-' +  Cast( (@Submit - 1 ) as varchar (3) )  + '-2' 



DECLARE @SampleRequestSubmitID uniqueidentifier
SELECT @SampleRequestSubmitID = SampleRequestSubmitID FROM  pSampleRequestSubmit WITH (NOLOCK)
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)


DELETE FROM pmsevalsamplbl where SampleRequestHeaderId =@SampleRequestHeaderId and SampleIndex=@Submit
DELETE FROM pmsevalsampMeas where SampleRequestHeaderId =@SampleRequestHeaderId and SampleIndex=@Submit
update pMSEvalHeader set submit = @Submit-1 where SampleRequestHeaderId=@SampleRequestHeaderId

DELETE FROM  pSampleRequestSpecItem
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
       (StyleID = @StyleID) AND (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (Submit = @Submit)

DELETE FROM   pSampleRequestSubmit WHERE  SampleRequestSubmitID = @SampleRequestSubmitID

--DELETE FROM pSampleRequestActivity WHERE  SampleRequestSubmitID = @SampleRequestSubmitID

select top 1  @DueDate  =a.DueDate 
from pSampleRequestSubmit a WITH (NOLOCK)
where a.SampleRequestTradeID = @SampleRequestTradeID
and a.StyleID =  @StyleID
and SampleWorkflowID= @SampleWorkflowID 
order by Submit DESC


UPDATE  pSampleRequestWorkflow
SET  Status = 0, EndDate = @vcDate, MUser = @ModifiedBy, MDate = @ModifiedDate ,  Submit = @Submit - 1, DueDate = @DueDate
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
       (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID)  
                      
UPDATE  pSampleRequestSubmit
SET  Status = 0, EndDate = NULL, MUser = @ModifiedBy, MDate = @ModifiedDate
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
       (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = (@Submit - 1))




-- DELETE ACTIVITIES

DELETE FROM pSampleRequestActivity 
WHERE SampleRequestSubmitID IN ( 
	SELECT SampleRequestSubmitID  FROM pSampleRequestSubmit WITH (NOLOCK) 
	WHERE SampleRequestTradeID = @SampleRequestTradeID
	AND StyleSet = @StyleSet AND Submit = @Submit 
	and SampleWorkflowID = @SampleWorkflowID 
)

IF @Submit > 1
BEGIN
	DELETE FROM pSampleRequestActivity 
	WHERE SampleRequestSubmitID = ( 
		SELECT SampleRequestSubmitID  FROM pSampleRequestSubmit WITH (NOLOCK) 
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		AND StyleSet = @StyleSet AND Submit = @Submit - 1 
		and SampleWorkflowID = @SampleWorkflowID 
	)
	AND ActivityType= 'R'
END

Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '879', GetDate())
GO   