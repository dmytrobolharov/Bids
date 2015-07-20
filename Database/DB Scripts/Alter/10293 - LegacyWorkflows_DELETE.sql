BEGIN TRY
	BEGIN TRAN

	DECLARE @WorkflowsToDelete TABLE(WorkflowID UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
	INSERT INTO @WorkflowsToDelete(WorkflowID)
	SELECT WorkflowID 
	FROM pWorkflow
	WHERE WorkflowID IN (
		  '40000000-0000-0000-0000-000000000010'	--	Artwork
		, '40000000-0000-0000-0000-000000000777'	--	Back
		, '11111111-0000-0000-0000-000000000003'	--	Body - Pattern Sheet
		, '11111111-0000-0000-0000-000000000002'	--	Body/Development Spec
		, '11111111-0000-0000-0000-000000000004'	--	Body-Marker
		, '40000000-0000-0000-0000-000000000077'	--	BOL
		, '50000000-0000-0000-0000-000000000057'	--	Collection Group
		, '40000000-0000-0000-0000-000000000004'	--	Colorway
		, '40000000-0000-0000-0000-000000000005'	--	Development Spec
		, '40000000-0000-0000-0000-000000000014'	--	Dimension
		, '40000000-0000-0000-0000-000000000012'	--	Dimension (Wash)
		, '40000000-0000-0000-0000-000000000008'	--	Graded Spec
		, '30000000-0000-0000-0000-000000000003'	--	Material
		, '50000000-0000-0000-0000-000000000056'	--	Packaging
		, '40000000-0000-0000-0000-000000000015'	--	Size Construction
		, '40000000-0000-0000-0000-000000000007'	--	Temp Graded Spec
	)

	-- remove workflows from all styles
	DELETE pStyleWorkflow
	WHERE WorkflowID IN (SELECT WorkflowID FROM @WorkflowsToDelete)

	-- delete workflows from templates
	DELETE pWorkflowTemplateItem
	WHERE WorkflowID IN (SELECT WorkflowID FROM @WorkflowsToDelete)

	-- delete workflow themselves
	DELETE pWorkflow
	WHERE WorkflowID IN (SELECT WorkflowID FROM @WorkflowsToDelete)

	DELETE Mapping
	WHERE Map IN (SELECT WorkflowID FROM @WorkflowsToDelete)

	COMMIT
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0 ROLLBACK
END CATCH
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10293', GetUTCDate())
GO
