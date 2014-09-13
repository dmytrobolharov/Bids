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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMTemp_UPDATE]    Script Date: 12/18/2011 18:00:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMTemp_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTemp_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMTemp_UPDATE]    Script Date: 12/18/2011 18:00:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTemp_UPDATE]
(
@SampleRequestGroupID uniqueidentifier,
@SampleRequestWorkflowID nvarchar(50), 
@SampleWorkflowID nvarchar(10),
@StyleID nvarchar(50),
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StyleSet nvarchar(10),
@StyleSet2 nvarchar(50) = null,
@StyleSet3 nvarchar(50) = null,
@StyleSet4 nvarchar(50) = null,
@Submit int,
@AssignedTo nvarchar(50),
@SubmitDays nvarchar(50),
@ResubmitDays nvarchar(50),
@DueDate nvarchar(50),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(100) ,
@SampleWorkflowFinalDate datetime ,
@StartDate datetime
)
AS 

--IF  (  SELECT COUNT(*) FROM pSampleRequestWorkflowBOMTemp  WHERE SampleRequestWorkflowID  =  @SampleRequestWorkflowID  )  = 0 
--BEGIN
UPDATE pSampleRequestWorkflowBOMTemp
SET AssignedTo = @AssignedTo, DueDate = @DueDate, FinalDate = @DueDate, SubmitDays = @SubmitDays, ResubmitDays = @ResubmitDays , 
SampleRequestWorkflowID = @SampleRequestWorkflowID, SampleWorkflowFinalDate = @SampleWorkflowFinalDate
WHERE  SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet 
--END

--(SampleRequestWorkflowID = @SampleRequestWorkflowID) 

-- IF ( SELECT COUNT(*) FROM pSampleRequestSubmitTemp  WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID))  = 0

IF  (  SELECT COUNT(*) FROM pSampleRequestSubmitBOMTemp  WHERE SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet  )  = 0 
BEGIN
	 INSERT INTO dbo.pSampleRequestSubmitBOMTemp
	(SampleRequestWorkflowID, SampleWorkflowID, AssignedTo, DueDate, SubmitDays, ResubmitDays, ItemDim1Id,ItemDim2Id,ItemDim3Id, 
	SampleRequestGroupID, Submit, Status, StyleID, StyleSet, CUser, CDate, MUser, MDate , StartDate)
	VALUES (@SampleRequestWorkflowID, @SampleWorkflowID, @AssignedTo, @DueDate, @SubmitDays, @ResubmitDays, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, 
	@SampleRequestGroupID, 1, 1, @StyleID, @StyleSet,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate , @StartDate )
END
ELSE
BEGIN		
	UPDATE pSampleRequestSubmitBOMTemp
	SET  AssignedTo = @AssignedTo, DueDate = @DueDate, SubmitDays = @SubmitDays, ResubmitDays = @ResubmitDays   ,   
	SampleRequestWorkflowID = @SampleRequestWorkflowID , StartDate = @StartDate
	WHERE  SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet 
	
/*	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
	AND (StyleID = @StyleID) 
	AND (StyleSet = @StyleSet)
*/
	
END

--IF(@StyleSet2 is not null )
--BEGIN
--UPDATE pSampleRequestWorkflowBOMTemp
--SET AssignedTo = @AssignedTo, DueDate = @DueDate, FinalDate = @DueDate, SubmitDays = @SubmitDays, ResubmitDays = @ResubmitDays , 
--SampleRequestWorkflowID = @SampleRequestWorkflowID, SampleWorkflowFinalDate = @SampleWorkflowFinalDate
--WHERE  SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet2 

----(SampleRequestWorkflowID = @SampleRequestWorkflowID) 

---- IF ( SELECT COUNT(*) FROM pSampleRequestSubmitTemp  WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID))  = 0

--IF  (  SELECT COUNT(*) FROM pSampleRequestSubmitBOMTemp  WHERE SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet2  )  = 0 
--BEGIN
--	 INSERT INTO dbo.pSampleRequestSubmitBOMTemp
--	(SampleRequestWorkflowID, SampleWorkflowID, AssignedTo, DueDate, SubmitDays, ResubmitDays, ItemDim1Id,ItemDim2Id,ItemDim3Id, 
--	SampleRequestGroupID, Submit, Status, StyleID, StyleSet, CUser, CDate, MUser, MDate , StartDate)
--	VALUES (@SampleRequestWorkflowID, @SampleWorkflowID, @AssignedTo, @DueDate, @SubmitDays, @ResubmitDays, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, 
--	@SampleRequestGroupID, 1, 1, @StyleID, @StyleSet2,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate , @StartDate )
--END
--ELSE
--BEGIN		
--	UPDATE pSampleRequestSubmitBOMTemp
--	SET  AssignedTo = @AssignedTo, DueDate = @DueDate, SubmitDays = @SubmitDays, ResubmitDays = @ResubmitDays   ,   
--	SampleRequestWorkflowID = @SampleRequestWorkflowID , StartDate = @StartDate
--	WHERE  SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet2 
	
--/*	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
--	AND (StyleID = @StyleID) 
--	AND (StyleSet = @StyleSet)
--*/
	
--END
--END

--IF(@StyleSet2 is not null )
--BEGIN
--UPDATE pSampleRequestWorkflowBOMTemp
--SET AssignedTo = @AssignedTo, DueDate = @DueDate, FinalDate = @DueDate, SubmitDays = @SubmitDays, ResubmitDays = @ResubmitDays , 
--SampleRequestWorkflowID = @SampleRequestWorkflowID, SampleWorkflowFinalDate = @SampleWorkflowFinalDate
--WHERE  SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet3 

----(SampleRequestWorkflowID = @SampleRequestWorkflowID) 

---- IF ( SELECT COUNT(*) FROM pSampleRequestSubmitTemp  WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID))  = 0

--IF  (  SELECT COUNT(*) FROM pSampleRequestSubmitBOMTemp  WHERE SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet3  )  = 0 
--BEGIN
--	 INSERT INTO dbo.pSampleRequestSubmitBOMTemp
--	(SampleRequestWorkflowID, SampleWorkflowID, AssignedTo, DueDate, SubmitDays, ResubmitDays, ItemDim1Id,ItemDim2Id,ItemDim3Id, 
--	SampleRequestGroupID, Submit, Status, StyleID, StyleSet, CUser, CDate, MUser, MDate , StartDate)
--	VALUES (@SampleRequestWorkflowID, @SampleWorkflowID, @AssignedTo, @DueDate, @SubmitDays, @ResubmitDays, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, 
--	@SampleRequestGroupID, 1, 1, @StyleID, @StyleSet3,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate , @StartDate )
--END
--ELSE
--BEGIN		
--	UPDATE pSampleRequestSubmitBOMTemp
--	SET  AssignedTo = @AssignedTo, DueDate = @DueDate, SubmitDays = @SubmitDays, ResubmitDays = @ResubmitDays   ,   
--	SampleRequestWorkflowID = @SampleRequestWorkflowID , StartDate = @StartDate
--	WHERE  SampleRequestGroupID  =  @SampleRequestGroupID  AND SampleWorkflowID =  @SampleWorkflowID  AND StyleID = @StyleID  AND StyleSet = @StyleSet3
	
--/*	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
--	AND (StyleID = @StyleID) 
--	AND (StyleSet = @StyleSet)
--*/
	
--END
--END


/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02365'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02365', GetDate())

END

GO
