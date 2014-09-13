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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSpecSizeBOMTemp_UPDATE]    Script Date: 12/18/2011 18:28:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSpecSizeBOMTemp_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSpecSizeBOMTemp_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSpecSizeBOMTemp_UPDATE]    Script Date: 12/18/2011 18:28:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestSpecSizeBOMTemp_UPDATE]
(
@SampleRequestGroupID nvarchar(50),
@SampleWorkflowID nvarchar(50),
@ItemDim1Id  nvarchar(50) = null,
@ItemDim2Id  nvarchar(50) = null,
@ItemDim3Id  nvarchar(50) = null,
@StyleID nvarchar(50),
@Sample nvarchar(50),
@UserName nvarchar(50),
@UserDate nvarchar(50)
)

AS

DECLARE @I as int,
 @SampleRequestWorkflowID nvarchar(50),
 @WorkflowID nvarchar(50),
 @StyleSet nvarchar(50),
 @Row_Count int	
 
SET @I = 1

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

BEGIN
--DROP TABLE #TempSampleRequestSpecSize

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '#TempSampleRequestSpecSize') DROP TABLE #TempSampleRequestSpecSize

SELECT IDENTITY(int, 1,1) AS ID_Num, pSampleRequestSetBOMItemTemp.StyleRequestWorkflowSetItemID, pSampleRequestWorkflowTemp.SampleRequestWorkflowID, 
	pSampleRequestWorkflowTemp.SampleRequestGroupID, pSampleRequestWorkflowTemp.SampleWorkflowTempItemID, 
	pSampleRequestWorkflowTemp.SampleWorkflowID, pSampleRequestWorkflowTemp.StyleID, pSampleRequestWorkflowTemp.ItemDim1Id, pSampleRequestWorkflowTemp.ItemDim2Id,pSampleRequestWorkflowTemp.ItemDim3Id,
	pSampleRequestWorkflowTemp.StyleSet, pSampleWorkflow.SampleWorkflow, pSampleWorkflow.GroupID, pSampleWorkflow.GroupName, dbo.pSampleWorkflow.WorkflowID
INTO #TempSampleRequestSpecSize FROM pSampleRequestSetBOMItemTemp WITH (NOLOCK) INNER JOIN
	pSampleRequestWorkflowBOMTemp pSampleRequestWorkflowTemp WITH (NOLOCK) ON 
	pSampleRequestSetBOMItemTemp.StyleRequestWorkflowSetItemID = pSampleRequestWorkflowTemp.StyleRequestWorkflowSetItemID INNER JOIN
	pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflowTemp.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
WHERE pSampleWorkflow.GroupID = N'S' AND pSampleRequestSetBOMItemTemp.SampleRequestGroupID = @SampleRequestGroupID AND pSampleRequestSetBOMItemTemp.StyleID = @StyleID 
AND pSampleRequestSetBOMItemTemp.ItemDim1Id = @ItemDim1Id AND 
 pSampleRequestSetBOMItemTemp.ItemDim2Id = @ItemDim2Id AND 
 pSampleRequestSetBOMItemTemp.ItemDim3Id = @ItemDim3Id AND 
 pSampleRequestWorkflowTemp.SampleWorkflowID = @SampleWorkflowID 


SET @Row_Count = (SELECT COUNT(*) FROM #TempSampleRequestSpecSize)

WHILE @I <= @Row_Count 
	BEGIN

		SELECT @SampleRequestWorkflowID = SampleRequestWorkflowID,
		@WorkflowID = WorkflowID, @StyleSet = StyleSet
		FROM #TempSampleRequestSpecSize WHERE ID_Num = @I
		
		BEGIN

			DELETE FROM pSampleRequestSpecSizeBOMTemp
			WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
			AND SampleWorkflowID = @SampleWorkflowID 
			AND WorkflowID = @WorkflowID 
			AND ItemDim1Id = @ItemDim1Id  
			AND ItemDim2Id = @ItemDim2Id  
			AND ItemDim3Id = @ItemDim3Id  
			AND StyleID = @StyleID 
			AND StyleSet = @StyleSet

			INSERT INTO pSampleRequestSpecSizeBOMTemp (SampleRequestGroupID, StyleID, SizeRange, 
				Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19,
				Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, Sel19, 
				Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10, Col11, Col12, Col13, Col14, Col15, Col16, Col17, Col18, Col19,
				MUser, MDate, SampleRequestWorkflowID, SampleWorkflowID, WorkflowID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet)
			SELECT @SampleRequestGroupID, StyleID, SizeRange, 
				Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, Size17, Size18, Size19, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				@UserName, @UserDate, @SampleRequestWorkflowID, @SampleWorkflowID, @WorkflowID,  @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @StyleSet
			FROM dbo.pStyleSpecSize WITH (NOLOCK)
			WHERE (StyleID = @StyleID)

			IF @Sample = 0
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel0 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id  
				AND StyleID = @StyleID 
			ELSE IF @Sample = 1
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel1 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 2
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel2 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 3
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel3 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 4
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel4 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 5
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel5 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 6
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel6 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 7
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel7 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 8
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel8 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 9
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel9 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 10
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel10 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 11
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel11 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 12
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel12 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 13
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel13 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 14
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel14 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 15
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel15 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 16
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel16 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 17
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel17 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 18
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel18 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 

			ELSE IF @Sample = 19
				UPDATE pSampleRequestSpecSizeBOMTemp SET Sel19 = 1 WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID 
				AND SampleWorkflowID = @SampleWorkflowID 
				AND WorkflowID = @WorkflowID 
				AND ItemDim1Id = @ItemDim1Id  
				AND ItemDim2Id = @ItemDim2Id  
				AND ItemDim3Id = @ItemDim3Id
				AND StyleID = @StyleID 
	
		END		


		SET @I = @I + 1
		
	END
DROP TABLE #TempSampleRequestSpecSize

SET NOCOUNT OFF
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02394'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02394', GetDate())

END

GO
