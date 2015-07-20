IF EXISTS (select * from sysobjects where id = object_id('rpx_Style_ConstructionDetails1_SELECT') and sysstat & 0xf = 4)
    drop procedure rpx_Style_ConstructionDetails1_SELECT
GO

CREATE PROCEDURE [dbo].[rpx_Style_ConstructionDetails1_SELECT]
	@StyleID varchar(255),	 
	@WorkflowItemID varchar(255),	
	@StyleSet As int
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

	SELECT Level1Desc =
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
			   CASE WHEN Linked = 0 OR @LinkDetail = 0 THEN Detail
					ELSE (SELECT CL3.Detail
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1)
					 END,
			 FilePath   =
			   CASE WHEN Linked = 0 THEN dbo.fnx_GetStreamingCDImagePath(ImageID, '') 
					ELSE (dbo.fnx_GetStreamingCDImagePath((SELECT CL3.ImageID
							 FROM pConstructTree CT INNER JOIN pConPageDetail CD
							   ON CD.Level1ID = CT.Level1ID
							  AND CD.Level2ID = CT.Level2ID 
							  AND CD.Level3ID = CT.Level3ID
						   INNER JOIN pConLevel3 CL3 on CL3.Level3ID = CT.Level3ID  
							WHERE CD.ConstructionDetailID = pConPageDetail.ConstructionDetailID
							  AND CD.Linked = 1),''))
					 END
			
	INTO	#tblTemp
	FROM pConPageDetail
	WHERE     StyleID = @StyleID
	AND WorkflowItemID = @WorkflowItemID
	AND StyleSet = @StyleSet
	Order By Sort


SELECT 	*
FROM	#tblTemp

DROP TABLE #tblTemp	
	
	
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01061', GetDate())
GO