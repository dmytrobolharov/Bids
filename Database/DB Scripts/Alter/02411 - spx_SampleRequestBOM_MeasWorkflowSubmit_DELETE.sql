-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOM_MeasWorkflowSubmit_Delete]    Script Date: 12/18/2011 18:38:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOM_MeasWorkflowSubmit_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOM_MeasWorkflowSubmit_Delete]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOM_MeasWorkflowSubmit_Delete]    Script Date: 12/18/2011 18:38:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOM_MeasWorkflowSubmit_Delete]
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
@ModifiedDate datetime)
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


DELETE FROM pmsevalsamplbl where SampleRequestHeaderId =@SampleRequestHeaderId and SampleIndex=@Submit
DELETE FROM pmsevalsampMeas where SampleRequestHeaderId =@SampleRequestHeaderId and SampleIndex=@Submit
update pMSEvalHeader set submit = @Submit-1 where SampleRequestHeaderId=@SampleRequestHeaderId

DELETE FROM  pSampleRequestSpecItem
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
       (StyleID = @StyleID)  AND (StyleSet = @StyleSet) AND (Submit = @Submit)

DELETE FROM   pSampleRequestSubmitBOM WHERE  SampleRequestSubmitID = @SampleRequestSubmitID

--DELETE FROM pSampleRequestActivity WHERE  SampleRequestSubmitID = @SampleRequestSubmitID

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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02411'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02411', GetDate())

END

GO
