IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportMaterialRequestSubmitItem_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ReportMaterialRequestSubmitItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ReportMaterialRequestSubmitItem_INSERT]
(
	@DataXmlID varchar(40),
	@MaterialRequestWorkflowID varchar(5),
	@MaterialRequestSubmitID varchar(40),
	@DataXmlFile xml
)
AS 

--DECLARE @MaterialRequestWorkflowID varchar(5)
--DECLARE @MaterialRequestSubmitID uniqueidentifier
--DECLARE @DataXmlID varchar(36)

DECLARE @XmlPath varchar(400)
DECLARE @XmlFileName VARCHAR(200)
DECLARE @XmlFolderName varchar(200)

--SET @MaterialRequestSubmitID = '97dc2fc9-74a7-4530-b4fd-edceab1114e5' 
--SET @MaterialRequestWorkflowID = 'A90'
--SET @DataXmlID = newId()


BEGIN
	-- Select Schema File
	SELECT @XmlFolderName = XmlSchemaPath FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1
	SELECT @XmlFileName = MaterialRequestWorkflowSchema FROM dbo.pMaterialRequestWorkflow WHERE MaterialRequestWorkflowID = @MaterialRequestWorkflowID
	SELECT @XmlPath = @XmlFolderName + '\' + @XmlFileName
END

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
	CREATE TABLE #tmpXmlDocTable(
					[XmlDocId] [int] IDENTITY(1,1) NOT NULL,
					[Name] [nvarchar](200) NULL,
					[Alias] [nvarchar](200) NULL,	
					[Type] varchar(200),
					[datatype] varchar(200),
					[lookupquery] varchar(800),
					[ValueField] varchar(200),
					[Visible] [varchar](5) NULL,
					[CDate] [datetime])


	DECLARE @idoc int
	DECLARE @doc XML
	SELECT @doc = xmlData FROM #tmpXmlImportFile

	EXEC sp_xml_preparedocument @idoc OUTPUT, @doc
	INSERT INTO #tmpXmlDocTable([Name], alias, Visible, CDate, [Type], datatype, lookupquery, ValueField)
	SELECT [Name], alias, Visible, getdate(), [Type], datatype, lookupquery, ValueField
	FROM       OPENXML (@idoc, '/Table/column',1)
				WITH (	[Name]  varchar(200),
						alias varchar(200),
						[Type] varchar(200),
						datatype varchar(200),
						lookupquery varchar(800),
						ValueField varchar(200),
						Visible varchar(200)				
				)
	WHERE Visible='true'
	EXEC sp_xml_removedocument @idoc --Clean Cache
	--SELECT * FROM #tmpXmlDocTable

END

BEGIN
	--Import pMaterialRequestSubmitItem values to temp table
	SELECT * INTO #tmpMaterialRequest
	FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID
	ORDER BY MaterialRequestSubmitItemSort ASC

	ALTER TABLE #tmpMaterialRequest ADD
	RecID int NOT NULL IDENTITY (1, 1)
	--SELECT * FROM #tmpMaterialRequest
END

BEGIN
		
	DECLARE @TotalCountM int
	DECLARE @RowCounterM int

	SELECT @TotalCountM = COUNT(*) FROM #tmpMaterialRequest
	SET @RowCounterM = 1

	DECLARE @tmpMaterialRequestSubmitItemID varchar(40)

	WHILE(@RowCounterM <= @TotalCountM)
		BEGIN

			SELECT @tmpMaterialRequestSubmitItemID = MaterialRequestSubmitItemID
						FROM #tmpMaterialRequest WHERE RecID = @RowCounterM

			DECLARE @TotalCount int
			DECLARE @RowCounter int

			SELECT @TotalCount = COUNT(*) FROM #tmpXmlDocTable
			SET @RowCounter = 1

			DECLARE @tmpName varchar(200)
			DECLARE @tmpAlias varchar(200)	
			DECLARE @tmpType varchar(200)
			DECLARE @tmpDataType varchar(200)
			DECLARE @tmpLookup varchar(800)
			DECLARE @tmpValueField varchar(200)

			WHILE(@RowCounter <= @TotalCount)
				BEGIN

					SELECT @tmpAlias = Alias, @tmpName = [Name], @tmpType = [Type], @tmpDataType = datatype, @tmpLookup = lookupquery, @tmpValueField = ValueField
						FROM #tmpXmlDocTable WHERE XmlDocId = @RowCounter
					
					IF @tmpDataType = 'query'
						BEGIN

							CREATE TABLE #tmpTable (FieldID varchar(200), FieldValue varchar(200))
							CREATE TABLE #tmpVar (FieldValue varchar(200))

							DECLARE @tmpReturnValue varchar(100)

							EXEC ('INSERT INTO #tmpTable (FieldID, FieldValue) ' + @tmpLookup) 
							EXEC ('INSERT INTO #tmpVar(FieldValue) SELECT ' + @tmpName + ' FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitItemID = ''' + @tmpMaterialRequestSubmitItemID + '''')

							SET @tmpReturnValue = (SELECT FieldValue FROM #tmpTable WHERE FieldID = (SELECT FieldValue FROM #tmpVar))

							DROP TABLE #tmpTable
							DROP TABLE #tmpVar

							EXEC('
								INSERT INTO rReportMaterialRequestItemTemp(DataXmlId, MaterialRequestSubmitItemID, MaterialRequestSubmitID, DataColumnNumber, DataColumnName, DataColumnValue, DataSort)
								SELECT ''' + @DataXmlId + ''', MaterialRequestSubmitItemID, MaterialRequestSubmitID, ' + @RowCounter + ',''' + @tmpAlias + ''', ''' + @tmpReturnValue + ''', MaterialRequestSubmitItemSort FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitItemID = ''' + @tmpMaterialRequestSubmitItemID + ''' 
								')

						END
					ELSE
						BEGIN
							EXEC('
								INSERT INTO rReportMaterialRequestItemTemp(DataXmlId, MaterialRequestSubmitItemID, MaterialRequestSubmitID, DataColumnNumber, DataColumnName, DataColumnValue, DataSort)
								SELECT ''' + @DataXmlId + ''', MaterialRequestSubmitItemID, MaterialRequestSubmitID, ' + @RowCounter + ',''' + @tmpAlias + ''', ' + @tmpName + ', MaterialRequestSubmitItemSort FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitItemID = ''' + @tmpMaterialRequestSubmitItemID + ''' 
								')
						END
					

					SET @RowCounter = @RowCounter + 1
				END
		SET @RowCounterM = @RowCounterM + 1

	END
END

--BEGIN
--	SELECT * FROM rReportMaterialRequestItemTemp WHERE DataColumnName <> 'Sort'
--END

BEGIN
	--Clean up
	--DELETE FROM rReportMaterialRequestItemTemp WHERE DataXmlID = @DataXmlID
	DROP TABLE #tmpMaterialRequest
	DROP TABLE #tmpXmlDocTable
	DROP TABLE #tmpXmlImportFile
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01396', GETDATE())
GO	


