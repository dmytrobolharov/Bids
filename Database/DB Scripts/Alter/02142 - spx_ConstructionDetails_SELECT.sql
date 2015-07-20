
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ConstructionDetails_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ConstructionDetails_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ConstructionDetails_SELECT] 
(   @WorkflowItemID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS

DECLARE @WorkFlowItemTypeId UNIQUEIDENTIFIER
DECLARE @LinkDetail as int 
DECLARE @LinkUserDefined1 as int 
DECLARE @LinkUserDefined2 as int
DECLARE @LinkUserDefined3 as int 
DECLARE @LinkUserDefined4 as int 
DECLARE @LinkUserDefined5 as int

BEGIN

	SELECT @WorkFlowItemTypeId = WorkFlowItemTypeId FROM pWorkFlowItem WHERE WorkFlowItemId = @WorkFlowItemId
	SELECT @LinkDetail = LinkDetail,
			@LinkUserDefined1 = LinkUserDefined1,
			@LinkUserDefined2 = LinkUserDefined2,
			@LinkUserDefined3 = LinkUserDefined3,
			@LinkUserDefined4 = LinkUserDefined4,
			@LinkUserDefined5 = LinkUserDefined5
	FROM pConPageSettings WITH (NOLOCK) WHERE WorkFlowItemTypeId = @WorkFlowItemTypeId

	SELECT Sort,
		   Linked,
		   OrigOperationSN =
		   CASE
			   WHEN Linked = 0 THEN OrigOperationSN
			   ELSE (SELECT CT.SerialNumber
					  FROM pConstructTree CT INNER JOIN pConPageDetail CD
						ON CD.Level0ID = CT.Level0ID
					   AND CD.Level1ID = CT.Level1ID 
					   AND CD.Level2ID = CT.Level2ID 
					   AND CD.Level3ID = CT.Level3ID
					  WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						AND CD.Linked = 1)
				END,
	
		   Level0ID =
			CASE WHEN Linked = 0 THEN Level0ID
				 ELSE (SELECT CT.Level0ID
					  FROM pConstructTree CT INNER JOIN pConPageDetail CD
						ON CD.Level0ID = CT.Level0ID
					   AND CD.Level1ID = CT.Level1ID
					   AND CD.Level2ID = CT.Level2ID 
					   AND CD.Level3ID = CT.Level3ID 
					  WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						AND CD.Linked = 1)
				 END,				 
				 		
		   Level1ID =
			CASE WHEN Linked = 0 THEN Level1ID
				 ELSE (SELECT CT.Level1ID
					  FROM pConstructTree CT INNER JOIN pConPageDetail CD
						ON CD.Level0ID = CT.Level0ID
					   AND CD.Level1ID = CT.Level1ID
					   AND CD.Level2ID = CT.Level2ID 
					   AND CD.Level3ID = CT.Level3ID 
					  WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						AND CD.Linked = 1)
				 END,
		   Level2ID =
			CASE WHEN Linked = 0 THEN Level2ID
				 ELSE (SELECT CT.Level2ID
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level0ID = CT.Level0ID
					      AND CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID 
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
		   Level3ID =
			CASE WHEN Linked = 0 THEN Level3ID
				 ELSE (SELECT CT.Level3ID
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level0ID = CT.Level0ID
					      AND CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID 
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
		   Level0Desc =
			CASE WHEN Linked = 0 THEN Level0Desc
				 ELSE (SELECT CL0.Level0Desc
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level0ID = CT.Level0ID
					      AND CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID 
						INNER JOIN pConLevel0 CL0 on CL0.Level0ID = CT.Level0ID
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END, 				 
		   Level1Desc =
			CASE WHEN Linked = 0 THEN Level1Desc
				 ELSE (SELECT CL1.Level1Desc
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level0ID = CT.Level0ID
					      AND CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID 
						INNER JOIN pConLevel1 CL1 on CL1.Level1ID = CT.Level1ID
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,       
		   Level2Desc =
			CASE WHEN Linked = 0 THEN Level2Desc
				 ELSE (SELECT CL2.Level2Desc
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level0ID = CT.Level0ID
					      AND CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID
						INNER JOIN pConLevel2 CL2 on CL2.Level2ID = CT.Level2ID 
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
		   Level3Desc =
			CASE WHEN Linked = 0 THEN Level3Desc
				 ELSE (SELECT CL3.Level3Desc
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level0ID = CT.Level0ID
					      AND CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID
						INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
			 Detail =
			   CASE WHEN Linked = 0 OR @LinkDetail = 0 THEN Detail
					ELSE (SELECT CL3.Detail
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
					          AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField1 =
			   CASE WHEN Linked = 0 OR @LinkUserDefined1 = 0 THEN AuxField1
					ELSE (SELECT CL3.AuxField1
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
					          AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField2 =
			   CASE WHEN Linked = 0 OR @LinkUserDefined2 = 0 THEN AuxField2
					ELSE (SELECT CL3.AuxField2
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
					          AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField3 =
			   CASE WHEN Linked = 0 OR @LinkUserDefined3 = 0 THEN AuxField3
					ELSE (SELECT CL3.AuxField3
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
					          AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField4 =
			   CASE WHEN Linked = 0 OR @LinkUserDefined4 = 0 THEN AuxField4
					ELSE (SELECT CL3.AuxField4
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
							  AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField5 =
			   CASE WHEN Linked = 0 OR @LinkUserDefined5 = 0 THEN AuxField5
					ELSE (SELECT CL3.AuxField5
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
							  AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 ImageID   =
			   CASE WHEN Linked = 0 THEN ImageID 
					ELSE (SELECT CL3.ImageID
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level0ID = CT.Level0ID
							  AND CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 WorkFlowID,
			 StyleID,
			 ConstructionDetailID,
			 CUser,
			 CDate,
			 MUser,
			 MDate
	 FROM pConPageDetail
	WHERE     StyleID = @StyleID
	AND WorkflowItemID = @WorkflowItemID
	AND StyleSet = @StyleSet
	Order By Sort
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02142'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02142', GetDate())
	END
GO