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

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitMaterial_DELETE]    Script Date: 12/18/2011 18:33:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMSubmitMaterial_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitMaterial_DELETE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMSubmitMaterial_DELETE]    Script Date: 12/18/2011 18:33:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowBOMSubmitMaterial_DELETE]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
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


DELETE FROM   dbo.pSampleRequestMaterialBOM
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
                      (StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (Submit = @Submit)


DELETE FROM   dbo.pSampleRequestMaterialBOM
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit)




select top 1  @DueDate  =a.DueDate 
from pSampleRequestSubmitBOM a WITH (NOLOCK)
where a.SampleRequestTradeID = @SampleRequestTradeID
and a.StyleID =  @StyleID
and SampleWorkflowID= @SampleWorkflowID 
order by Submit DESC


UPDATE    dbo.pSampleRequestMaterialBOM
SET              Status = 0, EndDate = @vcDate, MUser = @ModifiedBy, MDate = @ModifiedDate , Submit = @Submit - 1, DueDate = @DueDate
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) 

                      
UPDATE    dbo.pSampleRequestMaterialBOM
SET              Status = 0, EndDate = NULL, MUser = @ModifiedBy, MDate = @ModifiedDate
WHERE  (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
                      (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = (@Submit - 1))


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
	WHERE SampleRequestSubmitID IN ( 
		SELECT SampleRequestSubmitID  FROM pSampleRequestSubmit WITH (NOLOCK) 
		WHERE SampleRequestTradeID = @SampleRequestTradeID
		AND StyleSet = @StyleSet AND Submit = @Submit - 1 
		and SampleWorkflowID = @SampleWorkflowID 
	)
	AND ActivityType= 'R'
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02404'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02404', GetDate())

END

GO
