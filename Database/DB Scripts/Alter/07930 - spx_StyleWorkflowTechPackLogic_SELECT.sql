/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]    Script Date: 06/05/2014 13:51:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowTechPackLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]    Script Date: 06/05/2014 13:51:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflowTechPackLogic_SELECT]
(
	@StyleID uniqueidentifier,
	@StyleSet int ,
	@StyleSourcing int = 0,
	@TeamID uniqueidentifier, 
	@SeasonYearID uniqueidentifier = NULL
)
AS 
BEGIN

	DECLARE @StyleWorkflowID as uniqueidentifier  
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID
	
	DECLARE @StyleSeasonYearID uniqueidentifier = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID)

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

	DECLARE @StyleTypeID INT
	SELECT @StyleTypeID = StyleType FROM pStyleHeader WHERE StyleID = @StyleID
	
	IF @StyleWorkflowID IS NOT NULL 
	BEGIN 

		INSERT INTO #Temp ( WorkflowID, MapDetail )
		SELECT a.WorkflowID, b.MapDetail
		FROM pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map 
			INNER JOIN Mapping c WITH (NOLOCK) ON a.WorkflowID = c.Map 
			INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 2, @StyleTypeID) access ON access.WorkflowId = e.WorkflowID
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
			AND e.WorkflowTemplateID = @StyleWorkflowID
			AND (access.PermissionPrint = 1 OR access.PermissionRoleId = 3)
			AND (c.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID OR c.IsSeasonal = 0)
		ORDER BY e.WorkflowSort, e.WorkflowID

	END 
	ELSE 
	BEGIN 

		INSERT INTO #Temp ( WorkflowID, MapDetail )
		SELECT a.WorkflowID, c.MapDetail
		FROM pStyleWorkflow a WITH (NOLOCK)
		CROSS JOIN pWorkflowStatus b WITH (NOLOCK)
		CROSS JOIN Mapping c WITH (NOLOCK)
		INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 2, @StyleTypeID) access ON access.WorkflowId = a.WorkflowID
		WHERE a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet
		AND b.WorkflowStatusID = a.WorkStatus
		AND a.WorkflowID = c.Map
		AND (access.PermissionPrint = 1 OR access.PermissionRoleId = 3)
		AND (c.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID OR c.IsSeasonal = 0)
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

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07930', GetDate())
GO