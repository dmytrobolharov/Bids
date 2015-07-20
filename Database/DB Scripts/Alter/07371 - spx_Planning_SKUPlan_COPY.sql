IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_COPY]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_COPY]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER,
	@PlanningSKUHeaderName NVARCHAR(200),
	@NewPlanningSKUHeaderID UNIQUEIDENTIFIER = NULL OUT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN

	SET @NewPlanningSKUHeaderID = NEWID()
	DECLARE @Sort NVARCHAR(4),
			@PlanningID UNIQUEIDENTIFIER,
			@SeasonYearID UNIQUEIDENTIFIER
			
	SELECT @PlanningID = PlanningID, @SeasonYearID = SeasonYearID 
	FROM pPlanningSKUHeader WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
			
	SELECT @Sort = MAX(CAST(psh.Sort AS INT)) + 1 FROM pPlanningSKUHeader psh	
	WHERE psh.PlanningID = @PlanningID AND psh.SeasonYearID = @SeasonYearID AND ISNUMERIC(psh.Sort) = 1
	
	-- make a copy of planning sku header
	INSERT INTO pPlanningSKUHeader(PlanningSKUHeaderID, PlanningID, SeasonYearID, StyleSKUTemplateID, WorkStatus, PlanningSKUHeaderName,
		Sort, CUser, CDate, MUser, MDate)
	SELECT @NewPlanningSKUHeaderID, PlanningID, SeasonYearID, StyleSKUTemplateID, WorkStatus, @PlanningSKUHeaderName,
		RIGHT('0000' + CAST(@Sort AS NVARCHAR(4)), 3), @CUser, CDate, @CUser, @CDate
	FROM pPlanningSKUHeader WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
	
	INSERT INTO pPlanningSKUHeaderDimType(PlanningSKUHeaderID, DimTypeID, Position)
	SELECT @NewPlanningSKUHeaderID, DimTypeID, Position 
	FROM pPlanningSKUHeaderDimType WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
	
	-- generate sku plans for styles in planning
	EXEC spx_Planning_SKUPlan_New_Logic_UPDATE 
		@PlanningSKUHeaderID = @NewPlanningSKUHeaderID,
		@CUser = @CUser,
		@CDate = @CDate
		
	DECLARE @WorkflowItems TABLE(ROWID INT IDENTITY(1, 1), WorkflowItemID UNIQUEIDENTIFIER)
	INSERT INTO @WorkflowItems(WorkflowItemID)
	SELECT WorkflowItemID FROM pStyleSKUItem WHERE PlanningSKUHeaderID = @NewPlanningSKUHeaderID
	
	-- generate sku items for newly created sku plans
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @WorkflowItems)
	
	WHILE @ROW <= @TOTAL
	BEGIN		
		DECLARE @WorkflowItemID UNIQUEIDENTIFIER = (SELECT WorkflowItemID FROM @WorkflowItems WHERE ROWID = @ROW)
	
		EXEC spx_StyleSKUItems_Logic_UPDATE @WorkflowItemID = @WorkflowItemID
		
		SET @ROW = @ROW + 1
	END
	
	-- copy data from style sku plans	
	UPDATE ssi SET
		ssi.Delivery1StatusID = ssi2.Delivery1StatusID,
		ssi.Delivery1WSUnits = ssi2.Delivery1WSUnits,
		ssi.Delivery1RUnits = ssi2.Delivery1RUnits,
		ssi.Delivery1EUnits = ssi2.Delivery1EUnits,
		ssi.Delivery2StatusID = ssi2.Delivery2StatusID,
		ssi.Delivery2WSUnits = ssi2.Delivery2WSUnits,
		ssi.Delivery2RUnits = ssi2.Delivery2RUnits,
		ssi.Delivery2EUnits = ssi2.Delivery2EUnits,
		ssi.Delivery3StatusID = ssi2.Delivery3StatusID,
		ssi.Delivery3WSUnits = ssi2.Delivery3WSUnits,
		ssi.Delivery3RUnits = ssi2.Delivery3RUnits,
		ssi.Delivery3EUnits = ssi2.Delivery3EUnits,
		ssi.TotalWSUnits = ssi2.TotalWSUnits,
		ssi.TotalRUnits = ssi2.TotalRUnits,
		ssi.TotalEUnits = ssi2.TotalEUnits,
		ssi.TotalUnits = ssi2.TotalUnits
	FROM pStyleSKUItems ssi
	INNER JOIN pStyleSKUItem ssh ON ssi.StyleSKUItemID = ssh.StyleSKUItemID
	INNER JOIN pWorkFlowItem wfi ON ssh.WorkflowItemID = wfi.WorkFlowItemID
	INNER JOIN pStyleSKUItems ssi2 
		INNER JOIN pStyleSKUItem ssh2 ON ssi2.StyleSKUItemID = ssh2.StyleSKUItemID
		INNER JOIN pWorkFlowItem wfi2 ON ssh2.WorkflowItemID = wfi2.WorkFlowItemID ON
		ISNULL(ssi.ItemDim1ID, '00000000-0000-0000-0000-000000000000') = ISNULL(ssi2.ItemDim1ID, '00000000-0000-0000-0000-000000000000')
		AND ISNULL(ssi.ItemDim2ID, '00000000-0000-0000-0000-000000000000') = ISNULL(ssi2.ItemDim2ID, '00000000-0000-0000-0000-000000000000')
		AND ISNULL(ssi.ItemDim3ID, '00000000-0000-0000-0000-000000000000') = ISNULL(ssi2.ItemDim3ID, '00000000-0000-0000-0000-000000000000')
		AND ssh2.PlanningSKUHeaderID = @PlanningSKUHeaderID
		AND wfi.StyleSeasonYearID = wfi2.StyleSeasonYearID
	WHERE ssh.PlanningSKUHeaderID = @NewPlanningSKUHeaderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07371', GetDate())
GO
