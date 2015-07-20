IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitMaterial_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitMaterial_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitMaterial_DELETE]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleSet int,
@Submit int,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@SampleRequestSubmitID UNIQUEIDENTIFIER = null,
@SampleRequestSubmitVendorID uniqueidentifier = null)
AS 

DECLARE @vcDate as varchar ( 15 )  
DECLARE @DueDate  as datetime

IF @Submit  =  2
	SET @vcDate = '1900-' +  Cast( (@Submit - 1 ) as varchar (3) )  + '-1' 
ELSE 
	SET @vcDate = '1900-' +  Cast( (@Submit - 1 ) as varchar (3) )  + '-2' 

IF (@SampleWorkflowID = '20A') --GCC
	BEGIN
		DELETE FROM   pSampleRequestSubmitVendor
		WHERE  (SampleRequestSubmitID = @SampleRequestSubmitID)
	
		DELETE FROM   pSampleRequestGCCWorkflow
		WHERE (SampleRequestSubmitID = @SampleRequestSubmitID) AND (SampleRequestSubmitVendorID = @SampleRequestSubmitVendorID) AND (Submit = @Submit)

		
	END

DELETE FROM  dbo.pSampleRequestMaterial
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
					  (StyleID = @StyleID) AND (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (Submit = @Submit)
			
DELETE FROM   dbo.pSampleRequestSubmit
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)




select top 1  @DueDate  =a.DueDate 
from pSampleRequestSubmit a WITH (NOLOCK)
where a.SampleRequestTradeID = @SampleRequestTradeID
and a.StyleID =  @StyleID
and SampleWorkflowID= @SampleWorkflowID 
order by Submit DESC


UPDATE    dbo.pSampleRequestWorkflow
SET              Status = 0, EndDate = @vcDate, MUser = @ModifiedBy, MDate = @ModifiedDate , Submit = @Submit - 1, DueDate = @DueDate
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 

                      
UPDATE    dbo.pSampleRequestSubmit
SET              Status = 0, EndDate = NULL, MUser = @ModifiedBy, MDate = @ModifiedDate
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = (@Submit - 1))


/*
IF  @DueDate is not NULL 
BEGIN 
	UPDATE pSampleRequestWorkflow
	SET DueDate = @DueDate
	WHERE StyleID = @StyleID
	and StyleSet = @StyleSet 
	and SampleRequestTradeID = @SampleRequestTradeID
END
*/


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
	WHERE SampleRequestSubmitID IN ( 
		SELECT SampleRequestSubmitID  FROM pSampleRequestSubmit WITH (NOLOCK) 
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		AND StyleSet = @StyleSet AND Submit = @Submit - 1 
		and SampleWorkflowID = @SampleWorkflowID 
	)
	AND ActivityType= 'R'
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03008'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03008', GetDate())

END

GO
