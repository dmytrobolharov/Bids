-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 May 2012                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]    Script Date: 05/14/2012 14:35:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowTechPackLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]    Script Date: 05/14/2012 14:35:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]
(
	@StyleID uniqueidentifier,
	@StyleSet int ,
	@StyleSourcing int = 0 
)
AS 
BEGIN

	DECLARE @StyleWorkflowID as uniqueidentifier  
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID

	CREATE TABLE #Temp 
	( 
		Rec_Id int identity(1,1), 
		WorkflowID uniqueidentifier, 
		MapDetail nvarchar(200) 
	)

	IF @StyleSourcing = 1 
	BEGIN
		INSERT  INTO #Temp ( WorkflowID,  MapDetail )
		SELECT '10000000-0000-0000-0000-000000000000' AS WorkflowId, 'Style Sourcing' AS MapDetail 
	END

	INSERT  INTO #Temp ( WorkflowID,  MapDetail )
	SELECT '10000000-0000-0000-0000-000000000001' AS WorkflowId, 'Comments' AS MapDetail 

	INSERT  INTO #Temp ( WorkflowID,  MapDetail )
	SELECT '10000000-0000-0000-0000-000000000002' AS WorkflowId, 'Style Information' AS MapDetail 


	IF @StyleWorkflowID IS NOT NULL 
	BEGIN 

		--INSERT INTO #Temp ( WorkflowID, MapDetail )
		--SELECT a.WorkflowId, b.MapDetail
		--FROM pWorkflowTemplateItem a WITH (NOLOCK), Mapping b WITH (NOLOCK) 
		--WHERE a.WorkflowTemplateID = @StyleWorkflowID
		--AND a.WorkflowID = b.Map
		--ORDER BY a.WorkflowSort

		INSERT INTO #Temp ( WorkflowID, MapDetail )
		SELECT a.WorkflowID, b.MapDetail
		FROM pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map 
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
			AND e.WorkflowTemplateID = @StyleWorkflowID
		ORDER BY e.WorkflowSort, e.WorkflowID

	END 
	ELSE 
	BEGIN 

		INSERT INTO #Temp ( WorkflowID, MapDetail )
		SELECT a.WorkflowID, c.MapDetail
		FROM pStyleWorkflow a WITH (NOLOCK), pWorkflowStatus b WITH (NOLOCK), Mapping c WITH (NOLOCK)
		WHERE a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet
		AND b.WorkflowStatusID = a.WorkStatus
		AND a.WorkflowID = c.Map
		ORDER BY a.WorkSort

	END


	--SELECT * FROM #Temp 
	
	CREATE TABLE #TempFinal 
	( 
		Rec_Id int identity(1,1), 
		WorkflowID uniqueidentifier, 
		MapDetail nvarchar(200) 
	)
	
	DECLARE @Row_Count AS INT
	DECLARE @I AS INT
	DECLARE @ResultCount AS INT
	DECLARE @WorkFlowID AS NVARCHAR(100)
	DECLARE @MapDetails AS NVARCHAR(100)
	
		
	SET @Row_Count = (SELECT COUNT(*) FROM #Temp)
	
	SET @I = 1
	
	
	WHILE @I <= @Row_Count 
	BEGIN
		SELECT @WorkFlowID=WorkFlowID,@MapDetails=MapDetail FROM #Temp WHERE Rec_Id=@I
		SELECT @ResultCount = COUNT(*) FROM rReportStylePageItem  WHERE ReportMapID = @WorkFlowID AND ReportPageActive = 1
		
		IF(@ResultCount>0)
		BEGIN
			INSERT INTO #TempFinal(WorkFlowID,MapDetail)VALUES(@WorkFlowID,@MapDetails)
		END		
			
		SET @I=@I+1
	END	
	
	SELECT * FROM #TempFinal
	DROP TABLE #Temp
	DROP TABLE #TempFinal

END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03441'))
BEGIN

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03441', GetDate())
	
END
