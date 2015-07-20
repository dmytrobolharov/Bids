IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportMaterialHeader_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ReportMaterialHeader_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ReportMaterialHeader_INSERT](
	@DataXmlID VARCHAR(40),
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialTradePartnerID VARCHAR(40),
	@MaterialRequestSubmitID VARCHAR(40),
	@DataXmlFile XML
)
AS 

BEGIN
	-- Import Schema File to #tmpXmlImportFile
	CREATE TABLE #tmpXmlImportFile(
		[xmlFileName] VARCHAR(300) NULL,
		[xmlData] XML NOT NULL
	)

	INSERT INTO #tmpXmlImportFile([xmlData]) VALUES (@DataXmlFile)

--	EXEC('INSERT INTO #tmpXmlImportFile(xmlFileName, xmlData)
--		SELECT ''' + @XmlPath + ''', xmlData
--		FROM(
--		SELECT *
--		FROM OPENROWSET (BULK ''' + @XmlPath + ''' , SINGLE_BLOB) AS XMLDATA
--		) AS FileImport (XMLDATA)
--		')
END

BEGIN
	-- Import table schema values to #tmpXmlDocTable

	CREATE TABLE #tmpXmlDoc(
					[XmlDocId] [int] IDENTITY(1,1) NOT NULL,
					[Name] [nvarchar](200) NULL,
					[formcolumns] VARCHAR(5),
					[gridcolumns] VARCHAR(5),
					[FormSQL] VARCHAR(2000),	
					[GridReadSQL] VARCHAR(2000),
					[GridSQL] VARCHAR(2000),
					[CDate] [datetime]
					)


	CREATE TABLE #tmpXmlDocTable(
					[XmlDocId] [int] IDENTITY(1,1) NOT NULL,
					[Name] [nvarchar](200) NULL,
					[Alias] [nvarchar](200) NULL,	
					[Type] VARCHAR(200),
					[datatype] VARCHAR(200),
					[column] VARCHAR(2),
					[order] VARCHAR(3),
					[lookupquery] VARCHAR(800),
					[ValueField] VARCHAR(200),
					[Visible] [varchar](5) NULL,
					[CDate] [datetime]
					)


	DECLARE @idoc INT
	DECLARE @idoc1 INT
	DECLARE @doc XML
	SELECT @doc = xmlData FROM #tmpXmlImportFile

	EXEC sp_xml_preparedocument @idoc OUTPUT, @doc
	INSERT INTO #tmpXmlDocTable([Name], alias, Visible, CDate, [Type], datatype, lookupquery, ValueField, [column], [order])
	SELECT [Name], alias, Visible, GETDATE(), [Type], datatype, lookupquery, ValueField, [column], [order]
	FROM       OPENXML (@idoc, '/Table/column',1)
				WITH (	[Name]  VARCHAR(200),
						alias VARCHAR(200),
						[Type] VARCHAR(200),
						[column] VARCHAR(2),
						[order] VARCHAR(3),
						datatype VARCHAR(200),
						lookupquery VARCHAR(800),
						ValueField VARCHAR(200),
						Visible VARCHAR(200)				
				)
	WHERE Visible='true'
	EXEC sp_xml_removedocument @idoc --Clean Cache
	SELECT * FROM #tmpXmlDocTable


	EXEC sp_xml_preparedocument @idoc1 OUTPUT, @doc
	INSERT INTO #tmpXmlDoc([Name], FormSQL, GridReadSQL, GridSQL)
	SELECT [Name], FormSQL, GridReadSQL, GridSQL
	FROM       OPENXML (@idoc1, '/Table', 0)
				WITH (	[Name]  VARCHAR(200),
						FormSQL VARCHAR(2000),
						GridReadSQL VARCHAR(2000),
						GridSQL VARCHAR(2000)				
				)
	WHERE FormSQL <> ''
	EXEC sp_xml_removedocument @idoc1 --Clean Cache
	SELECT * FROM #tmpXmlDoc

END

BEGIN
	--Select table to import
	SELECT * INTO #tmpMaterialHeader
	FROM pMaterialTradePartner WHERE MaterialTradePartnerID = @MaterialTradePartnerID

	ALTER TABLE #tmpMaterialHeader ADD
	RecID INT NOT NULL IDENTITY (1, 1)
	--SELECT * FROM #tmpMaterialHeader
END

BEGIN
		
	DECLARE @TotalCountM INT
	DECLARE @RowCounterM INT

	SELECT @TotalCountM = COUNT(*) FROM #tmpMaterialHeader
	SET @RowCounterM = 1

	DECLARE @tmpMaterialID VARCHAR(40)

	WHILE(@RowCounterM <= @TotalCountM)
		BEGIN

			SELECT @tmpMaterialID = MaterialID
						FROM #tmpMaterialHeader WHERE RecID = @RowCounterM

			DECLARE @TotalCount INT
			DECLARE @RowCounter INT

			SELECT @TotalCount = COUNT(*) FROM #tmpXmlDocTable
			SET @RowCounter = 1

			DECLARE @tmpName VARCHAR(200)
			DECLARE @tmpAlias VARCHAR(200)	
			DECLARE @tmpType VARCHAR(200)
			DECLARE @tmpDataType VARCHAR(200)
			DECLARE @tmpLookup VARCHAR(800)
			DECLARE @tmpValueField VARCHAR(200)
			DECLARE @tmpColumn VARCHAR(2)
			DECLARE @tmpOrder VARCHAR(3)

			WHILE(@RowCounter <= @TotalCount)
				BEGIN

					SELECT @tmpAlias = REPLACE(Alias,'''',''''''), @tmpName = [Name], @tmpType = [Type], @tmpDataType = datatype, 
						@tmpLookup = lookupquery, @tmpValueField = ValueField, @tmpColumn = [column], @tmpOrder = [order]
						FROM #tmpXmlDocTable WHERE XmlDocId = @RowCounter
					
					IF @tmpDataType = 'query'
						BEGIN

							CREATE TABLE #tmpTable (FieldID VARCHAR(200), FieldValue VARCHAR(200))
							CREATE TABLE #tmpVar (FieldValue VARCHAR(200))

							DECLARE @tmpReturnValue VARCHAR(100)

							EXEC ('INSERT INTO #tmpTable (FieldID, FieldValue) ' + @tmpLookup) 
							EXEC ('INSERT INTO #tmpVar(FieldValue) SELECT ' + @tmpName + ' FROM pMaterial WHERE MaterialID = ''' + @tmpMaterialID + '''')

							SET @tmpReturnValue = (SELECT REPLACE(FieldValue,'''','''''') FROM #tmpTable WHERE FieldID = (SELECT FieldValue FROM #tmpVar))

							DROP TABLE #tmpTable
							DROP TABLE #tmpVar

							EXEC('
								INSERT INTO rReportMaterialHeaderTemp(DataXmlId, DataColumnNumber, DataColumnName, DataHeader, DataValue, DataSort)
								SELECT ''' + @DataXmlId + ''', ' + @tmpColumn + ',''' + @tmpName + ''',''' + @tmpAlias + ''', ''' + @tmpReturnValue + ''', ''' + @tmpOrder + ''' FROM pMaterialTradePartner WHERE MaterialTradePartnerID = ''' + @MaterialTradePartnerID + ''' 
								')

						END
					ELSE
						BEGIN
							
							EXEC('
								INSERT INTO rReportMaterialHeaderTemp(DataXmlId, DataColumnNumber, DataColumnName, DataHeader, DataValue, DataSort)
								SELECT ''' + @DataXmlId + ''', ' + @tmpColumn + ',''' + @tmpName + ''', ''' + @tmpAlias + ''', ' + @tmpName + ', ''' + @tmpOrder + ''' FROM pMaterialTradePartner WHERE MaterialTradePartnerID = ''' + @MaterialTradePartnerID + ''' 
								')
						END
					

					SET @RowCounter = @RowCounter + 1
				END
		SET @RowCounterM = @RowCounterM + 1

	END
END

--BEGIN
--	SELECT * FROM rReportMaterialHeaderTemp WHERE DataXmlId = @DataXmlId ORDER BY DataColumnNumber, DataSort
--END

BEGIN
	--Clean up
	--DELETE FROM rReportMaterialHeaderTemp WHERE DataXmlID = @DataXmlID
	DROP TABLE #tmpMaterialHeader
	DROP TABLE #tmpXmlDocTable
	DROP TABLE #tmpXmlDoc
	DROP TABLE #tmpXmlImportFile
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01395', GETDATE())
GO	


