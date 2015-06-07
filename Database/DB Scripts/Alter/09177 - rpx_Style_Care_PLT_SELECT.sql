IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Care_PLT_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Care_PLT_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Care_PLT_SELECT](
	@StyleId NVARCHAR(255)
	, @StyleSet INT
)
AS
DECLARE @DataXmlFile XML

/*Check for a valid record in the 'pStyleCareXML' table.*/
IF NOT EXISTS (
		SELECT SCHEMAXML
		FROM pStyleCareXML
		WHERE StyleID = @StyleId
			AND StyleSet = @StyleSet
		)
BEGIN
	/*Add a record to the 'pStyleCareXML' table to prevent an error.*/
	INSERT INTO pStyleCareXML (
		StyleID
		, StyleSet
		, SchemaXML
		)
	SELECT TOP 1 @StyleId
		, @StyleSet
		, SchemaXML
	FROM pStyleCareXML
END

SELECT @DataXmlFile = SCHEMAXML
FROM pStyleCareXML
WHERE StyleID = @StyleId
	AND StyleSet = @StyleSet

BEGIN
	-- Import Schema File to #tmpXmlImportFile
	CREATE TABLE #tmpXmlImportFile (
		[xmlFileName] NVARCHAR(300) NULL
		, [xmlData] XML NOT NULL
		)

	INSERT INTO #tmpXmlImportFile ([xmlData])
	VALUES (@DataXmlFile)
END

BEGIN
	-- Import table schema values to #tmpXmlDocTable
	CREATE TABLE #tmpXmlDocTable (
		XmlDocId INT IDENTITY(1, 1) NOT NULL
		, NAME NVARCHAR(200) NULL
		, Alias NVARCHAR(200) NULL
		, Visible NVARCHAR(5) NULL
		, lookupquery NVARCHAR(200)
		)

	DECLARE @idoc INT
	DECLARE @doc XML

	SELECT @doc = xmlData
	FROM #tmpXmlImportFile

	EXEC sp_xml_preparedocument @idoc OUTPUT
		, @doc

	INSERT INTO #tmpXmlDocTable (
		NAME
		, Alias
		, Visible
		, lookupquery
		)
	SELECT NAME
		, alias
		, Visible
		, lookupquery
	FROM OPENXML(@idoc, '//Table/column', 1) WITH (
			NAME NVARCHAR(200)
			, alias NVARCHAR(200)
			, Visible NVARCHAR(200)
			, lookupquery NVARCHAR(200)
			)
	WHERE Visible = 'true'
		AND lookupquery IS NOT NULL
		AND lookupquery <> ''

	EXEC sp_xml_removedocument @idoc --Clean Cache

	DECLARE @TotalRowCount INT
	DECLARE @RowCount INT
	DECLARE @Name NVARCHAR(30)
	DECLARE @Alias NVARCHAR(30)
	DECLARE @Visible NVARCHAR(30)
	DECLARE @QUERY NVARCHAR(MAX)
	DECLARE @Name_1 NVARCHAR(30)
	DECLARE @lookupquery NVARCHAR(200)
	DECLARE @TableName NVARCHAR(200)
	DECLARE @SpecialInstruction NVARCHAR(MAX)

	SET @QUERY = 'ALTER TABLE #tmpXmlDocTable ADD [' + 'ImagePath ' + '] NVARCHAR(200);'
	SET @QUERY = @QUERY + 'ALTER TABLE #tmpXmlDocTable ADD [' + 'Expression ' + '] NVARCHAR(200);'
	SET @QUERY = @QUERY + 'ALTER TABLE #tmpXmlDocTable ADD [' + 'CareInstruction ' + '] NVARCHAR(MAX);'
	SET @QUERY = @QUERY + 'ALTER TABLE #tmpXmlDocTable ADD [' + 'SpecialInstruction ' + '] NVARCHAR(MAX);'

	EXEC (@QUERY)

	SELECT @TotalRowCount = COUNT(*)
	FROM #tmpXmlDocTable

	SELECT @SpecialInstruction = StyleCareInstruction
	FROM pStyleCare
	WHERE StyleId = @StyleId
		AND StyleSet = @StyleSet

	SET @RowCount = 1

	WHILE (@RowCount <= @TotalRowCount)
	BEGIN
		SELECT @Name = NAME
			, @Alias = alias
			, @Visible = visible
			, @lookupquery = lookupquery
		FROM #tmpXmlDocTable
		WHERE XmlDocId = @RowCount
			AND Visible = 'true'
			AND lookupquery IS NOT NULL

		SET @TableName = dbo.fnx_GetTableName(@lookupquery)
		SET @QUERY = 'UPDATE #tmpXmlDocTable'
		SET @QUERY = @QUERY + '	SET ImagePath=dbo.fnx_GetStreamingCareImagePath(RTRIM(' + @TableName + '.CustomKey), ''' + RTRIM(LTRIM(REPLACE(REPLACE(@Alias, ' ', ''), 'ING', ''))) + ''')'
		SET @QUERY = @QUERY + '	,Expression=RTRIM(' + @TableName + '.CustomKey)'
		SET @QUERY = @QUERY + '	,CareInstruction=RTRIM(' + @TableName + '.Custom)'
		SET @QUERY = @QUERY + '	FROM ' + @TableName + ''
		SET @QUERY = @QUERY + '	INNER JOIN  pStyleCare'
		SET @QUERY = @QUERY + '	ON ' + @TableName + '.CustomKey= pStyleCare.' + @Name + ''
		SET @QUERY = @QUERY + '	WHERE pStyleCare.styleid=''' + @StyleId + ''''
		SET @QUERY = @QUERY + '	AND pStyleCare.styleset=''' + CONVERT(nVARCHAR(20), @StyleSet) + ''''
		SET @QUERY = @QUERY + '	AND XmlDocId = ''' + CONVERT(nVARCHAR(20), @RowCount) + ''';'
		SET @QUERY = @QUERY + '	UPDATE #tmpXmlDocTable'
		SET @QUERY = @QUERY + '	SET SpecialInstruction=N''' + ISNULL(@SpecialInstruction, '') + ''''
		SET @QUERY = @QUERY + '	FROM pStyleCare'
		SET @QUERY = @QUERY + '	WHERE pStyleCare.styleid=''' + @StyleId + ''''
		SET @QUERY = @QUERY + '	AND pStyleCare.styleset=''' + CONVERT(nVARCHAR(20), @StyleSet) + ''''
		SET @QUERY = @QUERY + '	AND XmlDocId = ''' + CONVERT(nVARCHAR(20), @RowCount) + ''';'

		--Print @QUERY 
		EXEC (@QUERY)

		SET @RowCount = @RowCount + 1
	END

	/*Temp Table for Table row Identity Column*/
	CREATE TABLE #tempFinalSelect (
		TableRow INT IDENTITY(0, 1)
		, XmlDocId INT
		, NAME NVARCHAR(200) NULL
		, Alias NVARCHAR(200) NULL
		, Visible NVARCHAR(5) NULL
		, lookupquery NVARCHAR(200)
		, Imagepath NVARCHAR(200)
		, Expression NVARCHAR(200)
		, CareInstruction NVARCHAR(MAX)
		, SpecialInstruction NVARCHAR(MAX)
		)

	/*End Of Temp Table*/
	INSERT INTO #tempFinalSelect (
		XmlDocId
		, NAME
		, Alias
		, Visible
		, lookupquery
		, Imagepath
		, Expression
		, CareInstruction
		, SpecialInstruction
		)
	SELECT XmlDocId
		, NAME
		, Alias
		, Visible
		, lookupquery
		, Imagepath
		, Expression
		, CareInstruction
		, SpecialInstruction
	FROM #tmpXmlDocTable

	/*Final Select */
	SELECT TableRow / 5 AS Row
		, TableRow % 5 AS [Column]
		, XmlDocId
		, NAME
		, Alias
		, Visible
		, lookupquery
		, Imagepath
		, Expression
		, CareInstruction
		, SpecialInstruction
	FROM #tempFinalSelect

	BEGIN
		--Clean up
		DROP TABLE #tmpXmlDocTable

		DROP TABLE #tmpXmlImportFile

		DROP TABLE #tempFinalSelect
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09177', GetDate())
GO
