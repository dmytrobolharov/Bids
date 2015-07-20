IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingUnits_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_UPDATE]
	@ColumnScenarioID UNIQUEIDENTIFIER,
	@FieldName NVARCHAR(200),
	@NewColumnValue NVARCHAR(200),
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @strSql NVARCHAR(MAX)
    
    IF @NewColumnValue IS NOT NULL
		BEGIN
			SET @strSql = 'UPDATE pStyleCostingScenarioItems SET ' + @FieldName + ' = N''' + @NewColumnValue + ''', MDate = ''' + CAST(@MDate AS NVARCHAR(100)) + ''', MUser = N''' + @MUser +
			''' WHERE StytleCostingScenarioItemsID = ''' + CAST(@ColumnScenarioID AS NVARCHAR(50)) + ''''
		END
    ELSE
		BEGIN
			SET @strSql = 'UPDATE pStyleCostingScenarioItems SET ' + @FieldName + ' = NULL, MDate = ''' + CAST(@MDate AS NVARCHAR(100)) + ''', MUser = N''' + @MUser +
			''' WHERE StytleCostingScenarioItemsID = ''' + CAST(@ColumnScenarioID AS NVARCHAR(50)) + ''''
		END
    EXEC(@strSql)

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04039', GetDate())
GO
