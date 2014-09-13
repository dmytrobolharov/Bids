IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingUnits_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_UPDATE]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER,
	@FieldName NVARCHAR(200),
	@NewFirstColumnValue NVARCHAR(200),
	@NewSecondColumnValue NVARCHAR(200),
	@NewThirdColumnValue NVARCHAR(200),
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @strSql NVARCHAR(MAX)
    
    SET @strSql = 'UPDATE pStyleCostingScenarioItems SET ' + @FieldName + ' = ''' + @NewFirstColumnValue + ''', MDate = ''' + CAST(@MDate AS NVARCHAR(100)) + ''', MUser = ''' + @MUser +
    ''' WHERE StytleCostingScenarioItemsID = ''' + CAST(@FirstColumnScenarioID AS NVARCHAR(50)) + ''''
    EXEC(@strSql)
    
    SET @strSql = 'UPDATE pStyleCostingScenarioItems SET ' + @FieldName + ' = ''' + @NewSecondColumnValue + ''', MDate = ''' + CAST(@MDate AS NVARCHAR(100)) + ''', MUser = ''' + @MUser +
    ''' WHERE StytleCostingScenarioItemsID = ''' + CAST(@SecondColumnScenarioID AS NVARCHAR(50)) + ''''
    EXEC(@strSql)
    
    SET @strSql = 'UPDATE pStyleCostingScenarioItems SET ' + @FieldName + ' = ''' + @NewThirdColumnValue + ''', MDate = ''' + CAST(@MDate AS NVARCHAR(100)) + ''', MUser = ''' + @MUser +
    ''' WHERE StytleCostingScenarioItemsID = ''' + CAST(@ThirdColumnScenarioID AS NVARCHAR(50)) + ''''
    EXEC(@strSql)

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03932', GetDate())
GO

