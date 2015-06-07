IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_ConstructionDetails_1x3_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_ConstructionDetails_1x3_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[rpx_Style_ConstructionDetails_1x3_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @WorkflowItemID UNIQUEIDENTIFIER
	, @StyleSet INT
	)
AS
BEGIN
	SELECT
		(ROW_NUMBER() OVER (ORDER BY cd.Sort) - 1) % 3 AS Col
		, (ROW_NUMBER() OVER (ORDER BY cd.Sort) - 1) / 3 AS Row
		, CASE WHEN cd.Linked = 0 THEN cd.Level1Desc ELSE CL1.Level1Desc END AS Level1Desc
		, CASE WHEN cd.Linked = 0 THEN cd.Level2Desc ELSE CL2.Level2Desc END AS Level2Desc
		, CASE WHEN cd.Linked = 0 THEN cd.Level3Desc ELSE CL3.Level3Desc END AS Level3Desc
		, CASE WHEN cd.Linked = 0 OR cps.LinkDetail = 0 THEN cd.Detail ELSE CL3.Detail END AS Detail
		, CASE WHEN cd.Linked = 0 THEN cd.AuxField1 ELSE CL3.AuxField1 END AS AuxField1
		, CASE WHEN cd.Linked = 0 THEN cd.AuxField2 ELSE CL3.AuxField2 END AS AuxField2
		, CASE WHEN cd.Linked = 0 THEN cd.AuxField3 ELSE CL3.AuxField3 END AS AuxField3
		, CASE WHEN cd.Linked = 0 THEN cd.AuxField4 ELSE CL3.AuxField4 END AS AuxField4
		, CASE WHEN cd.Linked = 0 THEN cd.AuxField5 ELSE CL3.AuxField5 END AS AuxField5
		, dbo.fnx_GetStreamingCDImagePath(CASE WHEN cd.Linked = 0 THEN cd.ImageID ELSE CL3.ImageID END, '', '500') AS FilePath
	FROM pConPageDetail CD
		LEFT JOIN pConstructTree CT ON
			CD.Level1ID = CT.Level1ID
			AND CD.Level2ID = CT.Level2ID
			AND CD.Level3ID = CT.Level3ID
		LEFT JOIN pConLevel1 CL1 ON CL1.Level1ID = CT.Level1ID
		LEFT JOIN pConLevel2 CL2 ON CL2.Level2ID = CT.Level2ID
		LEFT JOIN pConLevel3 CL3 ON CL3.Level3ID = CT.Level3ID
		INNER JOIN pWorkFlowItem wfi ON cd.WorkFlowItemId = wfi.WorkFlowItemID
		LEFT JOIN pConPageSettings cps ON wfi.WorkflowItemTypeId = cps.WorkflowItemTypeID
	WHERE cd.StyleID = @StyleID
		AND cd.WorkFlowItemId = @WorkflowItemID
		AND cd.StyleSet = @StyleSet

END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10145', GetUTCDate())
GO