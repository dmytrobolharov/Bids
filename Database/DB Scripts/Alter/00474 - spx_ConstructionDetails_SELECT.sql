SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spx_ConstructionDetails_SELECT 
(   @WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS
BEGIN
	SELECT Sort,
		   Linked,
		   OrigOperationSN =
		   CASE
			   WHEN Linked = 0 THEN OrigOperationSN
			   ELSE (SELECT CT.SerialNumber
					  FROM pConstructTree CT INNER JOIN pConPageDetail CD
						ON CD.Level1ID = CT.Level1ID 
					   AND CD.Level2ID = CT.Level2ID 
					   AND CD.Level3ID = CT.Level3ID
					  WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						AND CD.Linked = 1)
				END,
		   Level1ID =
			CASE WHEN Linked = 0 THEN Level1ID
				 ELSE (SELECT CT.Level1ID
					  FROM pConstructTree CT INNER JOIN pConPageDetail CD
						ON CD.Level1ID = CT.Level1ID
					   AND CD.Level2ID = CT.Level2ID 
					   AND CD.Level3ID = CT.Level3ID 
					  WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						AND CD.Linked = 1)
				 END,
		   Level2ID =
			CASE WHEN Linked = 0 THEN Level2ID
				 ELSE (SELECT CT.Level2ID
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID 
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
		   Level3ID =
			CASE WHEN Linked = 0 THEN Level3ID
				 ELSE (SELECT CT.Level3ID
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID 
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
		   Level1Desc =
			CASE WHEN Linked = 0 THEN Level1Desc
				 ELSE (SELECT CL1.Level1Desc
						 FROM pConstructTree CT INNER JOIN pConPageDetail CD
						   ON CD.Level1ID = CT.Level1ID
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
						   ON CD.Level1ID = CT.Level1ID
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
						   ON CD.Level1ID = CT.Level1ID
						  AND CD.Level2ID = CT.Level2ID 
						  AND CD.Level3ID = CT.Level3ID
						INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
						WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
						  AND CD.Linked = 1)
				 END,
			 Detail =
			   CASE WHEN Linked = 0 THEN Detail
					ELSE (SELECT CL3.Detail
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField1 =
			   CASE WHEN Linked = 0 THEN AuxField1
					ELSE (SELECT CL3.AuxField1
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField2 =
			   CASE WHEN Linked = 0 THEN AuxField2
					ELSE (SELECT CL3.AuxField2
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField3 =
			   CASE WHEN Linked = 0 THEN AuxField3
					ELSE (SELECT CL3.AuxField3
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField4 =
			   CASE WHEN Linked = 0 THEN AuxField4
					ELSE (SELECT CL3.AuxField4
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 AuxField5 =
			   CASE WHEN Linked = 0 THEN AuxField5
					ELSE (SELECT CL3.AuxField5
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
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
							   ON CD.Level1ID = CT.Level1ID
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
	AND WorkflowID = @WorkflowID
	AND StyleSet = @StyleSet
	Order By Sort
END
GO
