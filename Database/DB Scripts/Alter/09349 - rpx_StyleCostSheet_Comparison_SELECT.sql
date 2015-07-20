IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCostSheet_Comparison_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCostSheet_Comparison_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_StyleCostSheet_Comparison_SELECT]
	@StyleID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @StyleCostingComparisonId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @ListOfCostingScenarios NVARCHAR(MAX)
	
	IF @StyleCostingComparisonId IS NOT NULL
		SELECT @ListOfCostingScenarios = COALESCE(@ListOfCostingScenarios + ',', '') + 
			CAST(StyleCostingScenarioID AS nVARCHAR(36))
		FROM pStyleCostingComparisonTemp
		WHERE StyleCostingComparisonID = @StyleCostingComparisonId
		ORDER BY ID
	ELSE
		SELECT @ListOfCostingScenarios = COALESCE(@ListOfCostingScenarios + ',', '') + 
			CAST(ScenarioID AS nVARCHAR(36))
		FROM vwx_StyleCosting_SEL sc
			INNER JOIN pStyleSeasonYear ssy ON sc.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sc.StyleID = @StyleID AND ssy.SeasonYearID = @SeasonYearID
		
	--DECLARE @StyleId UNIQUEIDENTIFIER
	--DECLARE @StyleSet INT
	--SELECT @StyleId = StyleID FROM vwx_StyleCosting_SEL WHERE ScenarioID = (SELECT TOP 1 StyleCostingScenarioID FROM pStyleCostingComparisonTemp WHERE StyleCostingComparisonID = @StyleCostingComparisonId)

	DECLARE @CostingXMLData XML
	SELECT @CostingXMLData = SCHEMAXML FROM pStyleCostingXML WHERE StyleID = @StyleId AND StyleSet = 1
	

	DECLARE @SqlSelectQuery NVARCHAR(MAX)
	
	DECLARE @FieldListForSelect NVARCHAR(MAX)
	DECLARE @FieldListForPivot NVARCHAR(MAX)
	

	/************* Creating temporary table with style for of XML-driven thing *****/
	CREATE TABLE #tempUnitStyle(
		ColumnOrder INT,
		ColumnName NVARCHAR(200) COLLATE database_default PRIMARY KEY,
		ColumnAlias NVARCHAR(200) COLLATE database_default,
		ColumnDatatype NVARCHAR(200) COLLATE database_default,
		ColumnType NVARCHAR(200) COLLATE database_default,
		ColumnEnabled NVARCHAR(10) COLLATE database_default,
		ColumnVisible NVARCHAR(10) COLLATE database_default,
		ColumnGridVisible NVARCHAR(10) COLLATE database_default,
		CssClass NVARCHAR(200) COLLATE database_default,
		DefaultValue NVARCHAR(200) COLLATE database_default,
		DropdownLookupQuery NVARCHAR(4000) COLLATE database_default,
		DropdownTextField NVARCHAR(200) COLLATE database_default,
		DropdownValueField NVARCHAR(200) COLLATE database_default,
		ColumnCalculated NVARCHAR(10) DEFAULT 'false' COLLATE database_default
	)
	
	DECLARE @idoc int
	EXEC sp_xml_preparedocument @idoc OUTPUT, @CostingXMLData
	
	INSERT INTO #tempUnitStyle (ColumnOrder, ColumnName, ColumnAlias, ColumnDatatype,
	ColumnType, ColumnEnabled, ColumnVisible, ColumnGridVisible, CssClass, DefaultValue, DropdownLookupQuery,
	DropdownTextField, DropdownValueField, ColumnCalculated)
	SELECT [order], [Name], [alias], datatype, [Type], [enabled], Visible, GridVisible,
			CssClass, DefaultValue, lookupquery, textfield, ValueField, calculated
	FROM  OPENXML (@idoc, '/Table/column',1)
				WITH (	[order] int,
						[Name]  nvarchar(200),
						alias nvarchar(200),
						datatype nvarchar(200),
						[Type] nvarchar(200),
						[enabled] nvarchar(10),
						Visible nvarchar(10),
						GridVisible nvarchar(10),
						CssClass nvarchar(200),
						DefaultValue nvarchar(200),
						lookupquery nvarchar(4000),
						textfield nvarchar(200),
						valuefield nvarchar(200),
						calculated nvarchar(10)									
				)
	EXEC sp_xml_removedocument @idoc --Clean Cache
	
	/********* End of SQL-driven style management *****/

	/** Getting the list of fields from 'sql-xml' **/
	
	DECLARE @TempColumnName NVARCHAR(200)
	DECLARE @TempTableCursor AS CURSOR
	SET @TempTableCursor = CURSOR SCROLL FOR
	SELECT ColumnName FROM #tempUnitStyle WHERE UPPER(ColumnVisible) <> 'FALSE' ORDER BY ColumnOrder

	OPEN @TempTableCursor
	SET @FieldListForPivot = ''
	SET @FieldListForSelect = ''

	FETCH NEXT FROM @TempTableCursor INTO @TempColumnName
	WHILE @@FETCH_STATUS = 0
	BEGIN
	print @TempColumnName
		IF @FieldListForPivot <> ''
		BEGIN
			SET @FieldListForPivot = @FieldListForPivot + ', '
		END
		IF @FieldListForSelect <> ''
		BEGIN
			SET @FieldListForSelect = @FieldListForSelect + ', '
		END
		
		SET @FieldListForSelect = @FieldListForSelect + 'ISNULL(CAST(' + @TempColumnName + ' AS NVARCHAR(200)), '''')' + @TempColumnName
		SET @FieldListForPivot = @FieldListForPivot + @TempColumnName

		FETCH NEXT FROM @TempTableCursor INTO @TempColumnName
	END
	CLOSE @TempTableCursor
	DEALLOCATE @TempTableCursor

	print '@FieldListForPivot = ' + @FieldListForPivot
    SET @SqlSelectQuery = 
    'SELECT UNPV.ScenarioID, CDate, StyleCostingID, StyleCostingScenarioNo, 
    StyleCostingName + '' ('' + StyleCostingType + '')'' as StyleCostingName, 
    paramHeader, ' +
    'CASE 
		WHEN paramValue = '''' THEN ''''
		WHEN ColumnDatatype = ''percent'' THEN CAST( CAST(ROUND(CAST(paramValue AS DECIMAL(18,5)) * 100,2) AS DECIMAL(18,2)) AS NVARCHAR(200)) + '' %''
		WHEN ColumnDatatype = ''numeric'' OR ColumnDatatype = ''money'' OR ColumnDatatype = ''decimal'' THEN  ''$'' + CAST( CAST(ROUND(CAST(paramValue AS DECIMAL(18,5)),2) AS DECIMAL(18,2)) AS NVARCHAR(200))
		WHEN ColumnDatatype = ''integer'' THEN CAST( CAST(paramValue AS INT) AS NVARCHAR(200))
		WHEN ColumnDatatype = ''string'' THEN paramValue
		ELSE paramValue
    END as paramValue, ColumnAlias, ColumnDatatype, ColumnOrder FROM
	(
		SELECT ScenarioID,' + @FieldListForSelect + '
		FROM vwx_StyleCosting_SEL WHERE ScenarioID IN (''' + REPLACE(@ListOfCostingScenarios, ',', ''',''') + ''') 
		) as PV 
		UNPIVOT (
				paramValue for paramHeader in (' + @FieldListForPivot + ') 
	) AS UNPV
	LEFT JOIN #tempUnitStyle ON paramHeader = ColumnName
	LEFT JOIN vwx_StyleCosting_SEL ON UNPV.ScenarioID = vwx_StyleCosting_SEL.ScenarioID
	ORDER BY ColumnOrder'

	--print @SqlSelectQuery
	EXEC (@SqlSelectQuery)
	
	DROP TABLE #tempUnitStyle	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09349', GetDate())
GO
