/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingAdditionalItem_DELETE]    Script Date: 12/04/2012 17:09:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingAdditionalItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditionalItem_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CostSheetItem_CostingAdditionalItem_DELETE]    Script Date: 12/04/2012 17:09:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingAdditionalItem_DELETE]
	@StyleCostingID UNIQUEIDENTIFIER,
	@AdditionalItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @CurrentScenarioItemID UNIQUEIDENTIFIER
    DECLARE @ScenarioCursor AS CURSOR
    
    SET @ScenarioCursor = CURSOR SCROLL
    FOR SELECT StytleCostingScenarioItemsID from pStyleCostingScenarioItems WHERE StyleCostingID=@StyleCostingID
	
	OPEN @ScenarioCursor
	FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE FROM pstyleCostingAdditionalItems WHERE StyleAdditionalItemID = @AdditionalItemID
		AND StytleCostingScenarioItemsID = @CurrentScenarioItemID
		
		FETCH NEXT FROM @ScenarioCursor INTO @CurrentScenarioItemID
	END
	CLOSE @ScenarioCursor
	DEALLOCATE @ScenarioCursor
	
	DELETE FROM pstyleCostingAdditionalItems WHERE StyleAdditionalItemID = @AdditionalItemID
		AND StytleCostingScenarioItemsID = @StyleCostingID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04530', GetDate())
GO
