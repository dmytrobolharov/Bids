IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_StyleWorkflowTechPackLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_StyleWorkflowTechPackLogic_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_Sample_StyleWorkflowTechPackLogic_SELECT] (   
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @StyleSourcing INT = 0
	, @StyleIDOrg UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER = NULL
)  
AS
BEGIN
	DECLARE @StyleWorkflowID UNIQUEIDENTIFIER
	SELECT @StyleWorkflowID = StyleWorkflowId
	FROM pStyleHeader
	WHERE StyleID = @StyleID

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID
	FROM pStyleSeasonYear
	WHERE StyleID = @StyleID
		AND SeasonYearID = @SeasonYearID
	  
	CREATE TABLE #Temp
	(
		Rec_Id INT IDENTITY(1, 1)
		, WorkflowID UNIQUEIDENTIFIER
		, MapDetail NVARCHAR(200)
	)

	IF @StyleID = @StyleIDOrg
		INSERT INTO #Temp (WorkflowID, MapDetail)
		VALUES ('00000000-0000-0000-0000-000000000000',  'Sample Request')
	  
	IF @StyleSourcing = 1   
		INSERT INTO #Temp (WorkflowID, MapDetail)
		VALUES ('10000000-0000-0000-0000-000000000000', 'Style Sourcing')
	  
	INSERT INTO #Temp (WorkflowID, MapDetail)
	VALUES ('10000000-0000-0000-0000-000000000001', 'Comments')
	    
	INSERT INTO #Temp (WorkflowID, MapDetail)
	VALUES ('10000000-0000-0000-0000-000000000002', 'Style Information')
	    
	IF @StyleWorkflowID IS NOT NULL   
		INSERT INTO #Temp (WorkflowID, MapDetail)
		SELECT pStyleWorkflow.WorkflowID, Mapping.MapDetail
		FROM pStyleWorkflow
			INNER JOIN Mapping ON pStyleWorkflow.WorkflowID = Mapping.Map 
			INNER JOIN pWorkflowTemplateItem ON pWorkflowTemplateItem.WorkflowID = Mapping.Map 
		WHERE pStyleWorkflow.StyleID = @StyleID
			AND pStyleWorkflow.StyleSet = @StyleSet
			AND pWorkflowTemplateItem.WorkflowTemplateID = @StyleWorkflowID
			AND (Mapping.IsSeasonal = 1 AND pStyleWorkflow.StyleSeasonYearID = @StyleSeasonYearID OR Mapping.IsSeasonal = 0)
		ORDER BY pWorkflowTemplateItem.WorkflowSort, pWorkflowTemplateItem.WorkflowID
	ELSE   
		INSERT INTO #Temp (WorkflowID, MapDetail)
		SELECT pStyleWorkflow.WorkflowID, Mapping.MapDetail
		FROM pStyleWorkflow
			INNER JOIN Mapping ON pStyleWorkflow.WorkflowID = Mapping.Map 
			INNER JOIN pWorkflowStatus ON pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID
		WHERE pStyleWorkflow.StyleID = @StyleID
			AND pStyleWorkflow.StyleSet = @StyleSet
			AND (Mapping.IsSeasonal = 1 AND pStyleWorkflow.StyleSeasonYearID = @StyleSeasonYearID OR Mapping.IsSeasonal = 0)
		ORDER BY pStyleWorkflow.WorkSort


	SELECT * FROM #Temp   
	DROP TABLE #Temp  
	  
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10425', GetUTCDate())
GO
