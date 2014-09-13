IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_New_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_New_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_New_Logic_UPDATE]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	UPDATE pPlanningSKUHeader SET WorkStatus = 6 WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
	
	DECLARE @Styles TABLE(
		ROW INT IDENTITY(1, 1), 
		StyleID UNIQUEIDENTIFIER,
		StyleBOMDimensionID UNIQUEIDENTIFIER,
		SeasonYearID UNIQUEIDENTIFIER,
		PlanningItemID UNIQUEIDENTIFIER)
	
	-- select style
	INSERT INTO @Styles(StyleID, StyleBOMDimensionID, SeasonYearID, PlanningItemID)
	SELECT pi.StyleID, pi.StyleBOMDimensionID, psh.SeasonYearID, pi.PlanningItemID 
	FROM pPlanningSKUHeader psh
	INNER JOIN pPlanningItem pi ON psh.PlanningID = pi.PlanningID
	INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
	WHERE psh.PlanningSKUHeaderID = @PlanningSKUHeaderID 
		AND psh.SeasonYearID = ssy.SeasonYearID 
		AND pi.StyleBOMDimensionID IS NOT NULL
		
	DECLARE @Row INT = 1,
			@Total INT = (SELECT COUNT(*) FROM @Styles),
			@WorkflowItemTypeId UNIQUEIDENTIFIER = (SELECT TOP 1 WorkflowItemTypeId FROM pWorkflowItemType WHERE MapId = '40000000-0000-0000-0000-000000000090'),
			@WorkFlowItemName NVARCHAR(200) = (SELECT PlanningSKUHeaderName FROM pPlanningSKUHeader WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID),
			@StyleSKUTemplateID UNIQUEIDENTIFIER = (SELECT StyleSKUTemplateID FROM pPlanningSKUHeader WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID);
			
	WHILE @Row <= @Total
	BEGIN
		DECLARE @StyleID UNIQUEIDENTIFIER,
				@StyleBOMDimensionID UNIQUEIDENTIFIER,
				@SeasonYearID UNIQUEIDENTIFIER,
				@PlanningItemID UNIQUEIDENTIFIER;
				
		DECLARE @DimTypes TABLE(ROW INT, DimTypeID UNIQUEIDENTIFIER);
		DELETE FROM @DimTypes
		
		SELECT @StyleID = StyleID, 
			@StyleBOMDimensionID = StyleBOMDimensionID,
			@SeasonYearID = SeasonYearID,
			@PlanningItemID = PlanningItemID
		FROM @Styles WHERE ROW = @Row
		
		-- gather info for new workflowitem and sku page
		;WITH BOMTypes AS (
			SELECT V.* FROM pStyleBOMDimension sbd
			CROSS APPLY (VALUES (sbd.ItemDim1TypeId),
						        (sbd.ItemDim2TypeId),
						        (sbd.ItemDim3TypeId)) 
					           V(ItemDimTypeID)
			WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
		)
		INSERT INTO @DimTypes(ROW, DimTypeID)
		SELECT ROW_NUMBER() OVER(ORDER BY pshdt.Position), bt.ItemDimTypeID FROM pPlanningSKUHeaderDimType pshdt
		INNER JOIN BOMTypes bt ON pshdt.DimTypeID = bt.ItemDimTypeID
		WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID
		
		DECLARE @ItemDim1TypeID UNIQUEIDENTIFIER = (SELECT DimTypeID FROM @DimTypes WHERE ROW = 1),
				@ItemDim2TypeID UNIQUEIDENTIFIER = (SELECT DimTypeID FROM @DimTypes WHERE ROW = 2),
				@ItemDim3TypeID UNIQUEIDENTIFIER = (SELECT DimTypeID FROM @DimTypes WHERE ROW = 3),
				@WorkFlowItemId UNIQUEIDENTIFIER = NEWID();
		
		-- if BOM has at least one dimension and style has a Style SKU workflow
		IF @ItemDim1TypeID IS NOT NULL 
			AND EXISTS(SELECT * FROM pStyleWorkflow 
					   WHERE StyleID = @StyleID AND StyleSet = 1 
						   AND WorkflowID = '40000000-0000-0000-0000-000000000090')
		BEGIN		
			-- spaces around set and where keywords are crucial
			DECLARE @UpdateSQL NVARCHAR(MAX) = N'update pWorkFlowItem set  			
				StyleSKUTemplateID = N''' + CAST(@StyleSKUTemplateID AS nVARCHAR(40)) + ''', 
				StyleBOMDimensionID = N''' + CAST(@StyleBOMDimensionID AS nVARCHAR(40)) + ''', 			
				ItemDim1TypeID = N''' + CAST(ISNULL(@ItemDim1TypeID, '00000000-0000-0000-0000-000000000000') AS nVARCHAR(40)) + ''', 
				ItemDim2TypeID = N''' + CAST(ISNULL(@ItemDim2TypeID, '00000000-0000-0000-0000-000000000000') AS nVARCHAR(40)) + ''', 
				ItemDim3TypeID = N''' + CAST(ISNULL(@ItemDim3TypeID, '00000000-0000-0000-0000-000000000000') AS nVARCHAR(40)) + ''', 
				MUser = N''' + @CUser + ''', 
				MDate = ''' + CONVERT(nVARCHAR(100), @CDate, 120) + ''' 
			 where WorkFlowItemID = N''' + CAST(@WorkFlowItemId AS nVARCHAR(40)) + ''' '
			
			EXEC spx_WorkFlowItem_Seasonal_INSERT 
				@WorkFlowItemId = @WorkFlowItemId,
				@WorkflowID = '40000000-0000-0000-0000-000000000090',
				@WorkflowItemTypeId = @WorkflowItemTypeId,
				@StyleID = @StyleID,
				@StyleSet = 1,
				@WorkFlowItemName = @WorkFlowItemName,
				@CreatedDate = @CDate,
				@CreatedBy = @CUser,
				@SeasonYearID = @SeasonYearID,
				@UpdateSQL = @UpdateSQL
				
			-- link style sku plan to planning sku plan
			UPDATE pStyleSKUItem SET PlanningSKUHeaderID = @PlanningSKUHeaderID	WHERE WorkflowItemID = @WorkFlowItemId			
		END
	
		SET @Row = @Row + 1
	END
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07363', GetDate())
GO
