IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CostSheetItem_CostingUnits_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CostSheetItem_CostingUnits_SELECT]
	@FirstColumnScenarioID UNIQUEIDENTIFIER,
	@SecondColumnScenarioID UNIQUEIDENTIFIER,
	@ThirdColumnScenarioID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SqlSelectQuery NVARCHAR(MAX)
	
	DECLARE @FieldListForSelect NVARCHAR(MAX)
	DECLARE @FieldListForPivot NVARCHAR(MAX)
	
	/************* Creating temporary table with style, insted of XML-driven thing *****/
	CREATE TABLE #tempUnitStyle(
		ColumnOrder INT,
		ColumnName NVARCHAR(200) COLLATE database_default PRIMARY KEY,
		ColumnAlias NVARCHAR(200) COLLATE database_default,
		ColumnDatatype NVARCHAR(200) COLLATE database_default,
		ColumnEnabled INT,
		ColumnVisible INT,
		CssClass NVARCHAR(200) COLLATE database_default,
		DefaultValue NVARCHAR(200) COLLATE database_default,
		DropdownLookupQuery NVARCHAR(200) COLLATE database_default,
		DropdownTextField NVARCHAR(200) COLLATE database_default,
		DropdownValueField NVARCHAR(200) COLLATE database_default
	)
	
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(0, 'StyleCostingCustomField6', 'First Cost', 'numeric', 0, 1, 'TableHeaderGreen GridGroupEnd', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(1, 'StyleCostingHTS', 'HTS Code', 'string', 1, 1, 'GridGroupEnd', '')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(2, 'StyleCostingCustomField7', 'Duty %', 'numeric', 1, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(3, 'StyleCostingCustomField8', 'Duty $', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(4, 'StyleCostingCustomField9', 'Comission %', 'numeric', 1, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(5, 'StyleCostingCustomField10', 'Comission $', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(6, 'StyleCostingCustomField11', 'Agent %', 'numeric', 1, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(7, 'StyleCostingCustomField12', 'Agent $', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(8, 'StyleCostingCustomField13', 'Freight', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(9, 'StyleCostingCustomField14', 'Total Cost/LDP', 'numeric', 0, 1, 'TableHeaderRed GridGroupEnd', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(10, 'StyleCostingCurrency', 'Currency', 'dropdown', 1, 1, '', '')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(11, 'StyleCostingConvertedCurr', 'Conversion', 'numeric', 1, 1, 'GridGroupEnd', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(12, 'StyleCostingCustomField19', 'Proposed UNITS', 'integer', 0, 1, 'TableHeader', '0')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(13, 'StyleCostingCustomField3', 'Wholesale UNITS', 'integer', 1, 1, '', '0')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(14, 'StyleCostingCustomField4', 'Retail UNITS', 'integer', 1, 1, 'GridGroupEnd', '0')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(15, 'StyleCostingCustomField20', 'COST/LDP Extended', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(16, 'StyleCostingCustomField36', 'Wholesale Margin Unit', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(17, 'StyleCostingCustomField38', 'Wholesale Margin Extended', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(18, 'StyleCostingCustomField15', 'Wholesale Unit', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(19, 'StyleCostingCustomField21', 'Wholesale Extended', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(20, 'StyleCostingCustomField17', 'Wholesale Mark Up %', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(21, 'StyleCostingCustomField37', 'Retail Margin Unit', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(22, 'StyleCostingCustomField39', 'Retail Margin Extended', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(23, 'StyleCostingCustomField16', 'Retail Unit', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(24, 'StyleCostingCustomField22', 'Retail Extended', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(25, 'StyleCostingCustomField18', 'Retail Mark Up %', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(26, 'StyleCostingCustomField42', 'Weighted Price Unit', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(27, 'StyleCostingCustomField40', 'Total Sales $ Extended', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(28, 'StyleCostingCustomField43', 'Weighted Margin Unit', 'numeric', 0, 1, '', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(29, 'StyleCostingCustomField41', 'Total Margin $ Extended', 'numeric', 0, 1, 'Underlined', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(30, 'StyleCostingCustomField44', 'Weighted Markup%', 'numeric', 0, 1, 'GridGroupEnd', '0.00')
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype, ColumnEnabled, ColumnVisible, CssClass, DefaultValue)
	VALUES(31, 'StyleCostingComments', 'Comments', 'textbox', 1, 1, '', '')
	
	/********* End of SQL-driven style management *****/
	
	/** Getting the list of fields from 'sql-xml' **/
	
	DECLARE @TempColumnName NVARCHAR(200)
	DECLARE @TempTableCursor AS CURSOR
	SET @TempTableCursor = CURSOR SCROLL FOR
	SELECT ColumnName FROM #tempUnitStyle WHERE ColumnVisible <> 0 ORDER BY ColumnOrder
	
	OPEN @TempTableCursor
	SET @FieldListForPivot = ''
	SET @FieldListForSelect = ''
	FETCH NEXT FROM @TempTableCursor INTO @TempColumnName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @FieldListForPivot <> ''
		BEGIN
			SET @FieldListForPivot = @FieldListForPivot + ', '
		END
		IF @FieldListForSelect <> ''
		BEGIN
			SET @FieldListForSelect = @FieldListForSelect + ', '
		END
		
		SET @FieldListForSelect = @FieldListForSelect + 'ISNULL(CAST(' + @TempColumnName + ' AS NVARCHAR(50)), '''')' + @TempColumnName
		SET @FieldListForPivot = @FieldListForPivot + @TempColumnName
		
		FETCH NEXT FROM @TempTableCursor INTO @TempColumnName
	END
	CLOSE @TempTableCursor
	DEALLOCATE @TempTableCursor
	
    SET @SqlSelectQuery = 'SELECT * FROM
	(
		SELECT StytleCostingScenarioItemsId,' + @FieldListForSelect + '
		FROM pStyleCostingScenarioItems WHERE StytleCostingScenarioItemsId=''' + CAST(@FirstColumnScenarioID AS VARCHAR(50)) + ''' OR 
		StytleCostingScenarioItemsId=''' + CAST(@SecondColumnScenarioID AS VARCHAR(50)) + ''' OR 
		StytleCostingScenarioItemsId=''' + CAST(@ThirdColumnScenarioID AS VARCHAR(50)) + ''') as PV 
		UNPIVOT (
				paramValue for paramHeader in (' + @FieldListForPivot + ') 
	) AS UNPV
	PIVOT (MAX(paramValue) FOR StytleCostingScenarioItemsId in ([' + CAST(@FirstColumnScenarioID AS VARCHAR(50)) + '],[' + CAST(@SecondColumnScenarioID AS VARCHAR(50)) + '],[' + CAST(@ThirdColumnScenarioId AS VARCHAR(50)) + '])) AS PVT
	LEFT JOIN #tempUnitStyle ON paramHeader = ColumnName
	ORDER BY ColumnOrder'
	
	EXEC (@SqlSelectQuery)
	
	DROP TABLE #tempUnitStyle
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03916', GetDate())
GO
