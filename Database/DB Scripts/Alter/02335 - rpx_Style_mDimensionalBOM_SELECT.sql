
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 16 Dec 2011                                                                                */
-- * WorkItem #5300                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[rpx_Style_mDimensionalBOM_SELECT]    Script Date: 12/16/2011 12:38:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_mDimensionalBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_mDimensionalBOM_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Style_mDimensionalBOM_SELECT]    Script Date: 12/16/2011 12:38:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rpx_Style_mDimensionalBOM_SELECT]
(
	@StyleID	VARCHAR(50)
	,@StyleSet	INT
	,@WorkflowItemID NVARCHAR(100)
)
AS
BEGIN

		/*-----------Begin Declare Variable-----------------*/
		DECLARE @DataXmlFile		XML
		DECLARE @idoc				INT
		DECLARE @doc				XML
		DECLARE @TotalRowCount		INT
		DECLARE @RowCount			INT
		DECLARE @Name				NVARCHAR(30)
		DECLARE @Alias				NVARCHAR(30)
		DECLARE @Visible			NVARCHAR(30)
		DECLARE @QUERY				NVARCHAR(MAX)
		DECLARE @RowCount_StyleBOM	INT
		DECLARE @RowIDCount			INT
		DECLARE @StyleMaterialID	NVARCHAR(200)
		DECLARE @MaterialID			NVARCHAR(200)
		DECLARE @ColumnName			NVARCHAR(20)		
		DECLARE @QUERY1				NVARCHAR(MAX)
		DECLARE @QUERY2				NVARCHAR(MAX)
		DECLARE @SQLQUERY			NVARCHAR(MAX)
		DECLARE @SQLQUERY1			NVARCHAR(MAX)
		DECLARE @DimensionsFlag		INT
		DECLARE @MaterialQuantity	VARCHAR(2000)
		DECLARE @CSV				NVARCHAR(255)
		DECLARE @CSV1				NVARCHAR(255)
		DECLARE @CSV2				NVARCHAR(255)
		DECLARE @IsColor			INT
		DECLARE @QUERY3				NVARCHAR(MAX)
		DECLARE @StatusColName		NVARCHAR(100)
		DECLARE @XMLColumnCount		INT
		
		/*-----------End Declare Variable-----------------*/
		
		SET @MaterialQuantity=''
		SET @IsColor=0
		
		IF @WorkflowItemID IS NULL OR @WorkflowItemID=''
		BEGIN
			SET @WorkflowItemID='00000000-0000-0000-0000-000000000000'
		END 

		SELECT @DataXmlFile=SchemaXML FROM pStyleBOMXML WHERE StyleID= @StyleID 
		AND StyleSet=@StyleSet
		AND WorkflowItemID=@WorkflowItemID
	

		BEGIN
			-- Import Schema File to #tmpXmlImportFile
			CREATE TABLE #tmpXmlImportFile
			(
				[xmlFileName]	VARCHAR(300) NULL,
				[xmlData]		XML NOT NULL
			)

			INSERT INTO #tmpXmlImportFile([xmlData]) VALUES (@DataXmlFile)
		END
		
		

		BEGIN
			-- Import table schema values to #tmpXmlDocTable
			CREATE TABLE #tmpXmlDocTable
			(
				XmlDocId		INT IDENTITY(1,1)	NOT NULL,
				Name			NVARCHAR	(200)	NULL,
				Alias			NVARCHAR	(200)	NULL,
				Visible			VARCHAR		(5)		NULL,
				StatusFlag		VARCHAR		(5)		NULL			
			)
			
			SELECT	@doc = xmlData FROM #tmpXmlImportFile

			EXEC sp_xml_preparedocument @idoc OUTPUT, @doc
			
			INSERT INTO #tmpXmlDocTable
			(
			Name
			,Alias
			,Visible
			,StatusFlag
			)
			SELECT 
			Name
			,alias
			,Visible
			,StatusFlag
			FROM OPENXML (@idoc, '/NewDataSet/Table/column',1)
				WITH 
				(	
					Name			VARCHAR(200)
					,alias			VARCHAR(200)
					,Visible		VARCHAR(200)
					,StatusFlag		VARCHAR(200)
				)
			WHERE Visible='true'
			EXEC sp_xml_removedocument @idoc --Clean Cache
			
		END
		
		SELECT @XMLColumnCount=COUNT(*) FROM #tmpXmlDocTable
		
		SELECT DimensionColumnName,DimensionColumnValue,ItemDim1TypeName,ItemDim2TypeName,ItemDim3TypeName
				INTO #tblStyleBOMDimension 
					FROM 
					(SELECT StyleBOMDimensionID,ItemDim1TypeId,ItemDim2TypeId,ItemDim3TypeId,ItemDim1TypeName,ItemDim2TypeName,ItemDim3TypeName 
					FROM pStyleBOMDimension WHERE StyleID = @StyleID
					AND StyleSet=@StyleSet
					AND WorkFlowItemID=@WorkflowItemID
					)p
					UNPIVOT
					(DimensionColumnValue FOR DimensionColumnName 
					IN (ItemDim1TypeId,ItemDim2TypeId,ItemDim3TypeId)) AS unpvt;
					
		SELECT  @DimensionsFlag=COUNT(*) FROM #tblStyleBOMDimension WHERE DimensionColumnValue <>'00000000-0000-0000-0000-000000000000' 
				
		SELECT @IsColor= COUNT(*) FROM #tblStyleBOMDimension WHERE ItemDim1TypeName='COLOR'  
		OR  ItemDim2TypeName='COLOR' OR ItemDim3TypeName='COLOR' 
		
		IF @IsColor>0
		BEGIN
			SET @IsColor=1
		END
		ELSE
		BEGIN
			SET @IsColor=0
		END
				
		IF @XMLColumnCount>0
		BEGIN	
				SELECT @CSV= SUBSTRING((SELECT ',' + 'ISNULL(SB.'+Name + ','''') AS ['+ Alias +']' FROM #tmpXmlDocTable 
				WHERE Visible='true' FOR XML PATH('')),2,200000)
				
				SELECT @StatusColName=Name from  #tmpXmlDocTable where StatusFlag='true'
				
				SET @CSV=REPLACE(@CSV,'SB.'+@StatusColName+'','dbo.fnx_GetMaterialStatus(SB.'+@StatusColName+')')
				
				SET @SQLQUERY='SELECT dbo.fnx_GetMaterialType(SB.MaterialType) AS MaterialType'
				SET @SQLQUERY=@SQLQUERY+	'	,SB.MaterialNo'
				SET @SQLQUERY=@SQLQUERY+	'	,SB.MaterialName'
				SET @SQLQUERY=@SQLQUERY+	'	,SB.Placement'
				SET @SQLQUERY=@SQLQUERY+	'	,CONVERT(NVARCHAR(50),SB.width) AS WIDTH'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetStreamingImagePath(SB.MaterialImageID,SB.MaterialImageVersion) AS ImagePath'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.ItemDim1Name'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.ItemDim2Name'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.ItemDim3Name'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.MaterialQuantity'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.MaterialDimension'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.Comments'
				SET @SQLQUERY=@SQLQUERY+	'	,CONVERT(NVARCHAR(50),dbo.fnx_GetUnitOfMeasurement(SB.UOM)) AS UOM'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.StyleSet'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.WorkFlowID'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetDimensionName(SBI.ItemDim1TypeId) AS Dimension1'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetDimensionName(SBI.ItemDim2TypeId) AS Dimension2'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetDimensionName(SBI.ItemDim3TypeId) AS Dimension3'
				SET @SQLQUERY=@SQLQUERY+	'	,SBD.ItemDim1Sort'
				SET @SQLQUERY=@SQLQUERY+	'	,SBD.ItemDim2Sort'
				SET @SQLQUERY=@SQLQUERY+	'	,SBD.ItemDim3Sort'
				SET @SQLQUERY=@SQLQUERY+	'	,SBD.StyleID'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.WorkflowItemID'				
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialMainColorName(SBD.ItemDim1Id) AS HeaderColorName'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialMainColorCode(SBD.ItemDim1Id) AS HeaderColorCode'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialMainColorImagePath(SBD.ItemDim1Id) AS HeaderColorImagePath'
				SET @SQLQUERY=@SQLQUERY+	'	,SBI.MaterialColorId'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialItemColorName(SBI.MaterialColorId) AS ItemColorName'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialItemColorCode(SBI.MaterialColorId) AS ItemColorCode'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialItemColorImagePath(SBI.MaterialColorId) AS ItemColorImagePath'
				SET @SQLQUERY=@SQLQUERY+	'	,dbo.fnx_GetMaterialTreatmentSize(SBI.MaterialDimension) AS TreatmentSize'
				SET @SQLQUERY=@SQLQUERY+	'	,'''+CONVERT(NVARCHAR(10),@DimensionsFlag)+ ''' AS DimensionsFlag'
				SET @SQLQUERY=@SQLQUERY+	'	,'''+CONVERT(NVARCHAR(10),@IsColor)+''' AS ColorStatus'
				SET @SQLQUERY=@SQLQUERY+	'	,'+@CSV+''
				SET @SQLQUERY=@SQLQUERY+	'	INTO tblbeforeUpdate'
				SET @SQLQUERY=@SQLQUERY+	'	FROM pStyleBOM SB '
				SET @SQLQUERY=@SQLQUERY+	'	INNER JOIN pStyleBOMItem SBI ON SB.StyleMaterialID=SBI.StyleMaterialID'
				SET @SQLQUERY=@SQLQUERY+	'	INNER JOIN pStyleBOMDimensionItems SBD ON SBI.StyleBOMDimensionID=SBD.StyleBOMDimensionID'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBD.StyleBOMDimensionID=SB.StyleBOMDimensionId'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBD.StyleBOMDimensionItemID=SBI.StyleBOMDimensionItemID'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBI.StyleID=SBD.StyleID'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBI.WorkflowItemID=SBD.WorkflowItemID'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBD.ItemDim1Active=1'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBD.ItemDim2Active=1'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBD.ItemDim3Active=1'
				SET @SQLQUERY=@SQLQUERY+	'	AND SBI.StyleID='''+@StyleID+''''
				SET @SQLQUERY=@SQLQUERY+	'	AND SBI.StyleSet='''+CONVERT(NVARCHAR(10),@StyleSet)+''''
				SET @SQLQUERY=@SQLQUERY+	'	AND SBI.WorkFlowItemID='''+CONVERT(NVARCHAR(100),@WorkflowItemID)+''''
				SET @SQLQUERY=@SQLQUERY+	'	ORDER BY SBD.ItemDim2Sort'
				
				EXEC (@SQLQUERY)
				
				SELECT * INTO #tblbeforeUpdate  FROM tblbeforeUpdate
				
				DROP TABLE tblbeforeUpdate
				
				BEGIN
					CREATE TABLE #tblFinalTable
					(
						SizeRowid			INT NOT NULL IDENTITY (0, 1)
						,MaterialType			NVARCHAR(50)
						,MaterialNo				NVARCHAR(100)
						,MaterialName			NVARCHAR(100)
						,Placement				NVARCHAR(MAX)
						,WIDTH					NVARCHAR(200)
						,ImagePath				NVARCHAR(500)
						,ItemDim1Name			NVARCHAR(100)
						,ItemDim2Name			NVARCHAR(100)
						,ItemDim3Name			NVARCHAR(100)
						,MaterialQuantity		NUMERIC(18,4)
						,MaterialDimension		UNIQUEIDENTIFIER 
						,Comments				NVARCHAR(1020)
						,UOM					NVARCHAR(100)
						,StyleSet				INT
						,WorkFlowID				UNIQUEIDENTIFIER
						,Dimension1				NVARCHAR(500)
						,Dimension2				NVARCHAR(500)
						,Dimension3				NVARCHAR(500)
						,WorkFlowItemID			UNIQUEIDENTIFIER
						,ItemDim1Sort			INT
						,ItemDim2Sort			INT
						,ItemDim3Sort			INT				
						,HeaderColorName		NVARCHAR(100)
						,HeaderColorCode		NVARCHAR(100)
						,HeaderColorImagePath	NVARCHAR(2000)
						,MaterialColorId		UNIQUEIDENTIFIER
						,ItemColorName			NVARCHAR(100)
						,ItemColorCode			NVARCHAR(100)
						,ItemColorImagePath		NVARCHAR(2000)
						,TreatmentSize			NVARCHAR(100)
						,DimensionsFlag			VARCHAR(10)
						,ColorStatus			VARCHAR(10)
						,ConfigColumnName		NVARCHAR(50)
						,ConfigColumnValue		NVARCHAR(50)
					)
				END
				
			
				SELECT @CSV1= SUBSTRING((SELECT ',' +Alias	FROM #tmpXmlDocTable 
				WHERE Visible='true' FOR XML PATH('')),2,200000)
				
			
				
				SELECT @CSV2= SUBSTRING((SELECT ',' +'CONVERT(NVARCHAR(200),'+ Alias +') AS [' + Alias +']'	FROM #tmpXmlDocTable 
				WHERE Visible='true' FOR XML PATH('')),2,200000)
				
				BEGIN		
					SET @QUERY2 = N'SELECT 
					MaterialType
					,MaterialNo
					,MaterialName
					,Placement
					,CONVERT(NVARCHAR(50),width) AS WIDTH
					,ImagePath
					,ItemDim1Name
					,ItemDim2Name
					,ItemDim3Name
					,MaterialQuantity
					,MaterialDimension
					,Comments
					,UOM
					,StyleSet
					,WorkFlowID
					,Dimension1
					,Dimension2
					,Dimension3
					,WorkFlowItemID
					,ItemDim1Sort
					,ItemDim2Sort
					,ItemDim3Sort
					,HeaderColorName
					,HeaderColorCode
					,HeaderColorImagePath
					,MaterialColorId
					,ItemColorName
					,ItemColorCode
					,ItemColorImagePath
					,TreatmentSize
					,DimensionsFlag
					,ColorStatus
					,ConfigColumnName
					,ConfigColumnValue
					FROM			
					(
					SELECT 
					MaterialType AS MaterialType
					,MaterialNo
					,MaterialName
					,Placement
					,CONVERT(NVARCHAR(50),width) AS WIDTH
					,ImagePath
					,ItemDim1Name
					,ItemDim2Name
					,ItemDim3Name
					,MaterialQuantity
					,MaterialDimension
					,Comments
					,UOM
					,StyleSet
					,WorkFlowID
					,Dimension1
					,Dimension2
					,Dimension3
					,WorkFlowItemID
					,ItemDim1Sort
					,ItemDim2Sort
					,ItemDim3Sort
					,HeaderColorName
					,HeaderColorCode
					,HeaderColorImagePath
					,MaterialColorId
					,ItemColorName
					,ItemColorCode
					,ItemColorImagePath
					,TreatmentSize
					,DimensionsFlag
					,ColorStatus
					, ' + @CSV2 + ' FROM #tblbeforeUpdate
					WHERE StyleID = ''' + CONVERT(NVARCHAR(50),@StyleID) + '''
					AND StyleSet = ''' + CONVERT(NVARCHAR(50),@StyleSet) + '''
					AND WorkflowItemID='''+CONVERT(NVARCHAR(50),@WorkflowItemID)+''') p					
					UNPIVOT
					(ConfigColumnValue For ConfigColumnName IN ('+@CSV1+')) as unpvt;'
				END
				
				
				
					/*--------Insert Data into Temporary Table -----------------*/
				BEGIN
					INSERT #tblFinalTable EXEC (@QUERY2) 
				END
				
				SELECT * FROM #tblFinalTable
				
			--Clean Ups----
			
			BEGIN
				DROP TABLE #tmpXmlImportFile
				DROP TABLE #tmpXmlDocTable
				DROP TABLE #tblbeforeUpdate
				DROP TABLE #tblFinalTable	
			END
	END
	ELSE
	BEGIN
		CREATE TABLE #tblFinalTable2
		(
			SizeRowid			INT NOT NULL IDENTITY (0, 1)
			,MaterialType			NVARCHAR(50)
			,MaterialNo				NVARCHAR(100)
			,MaterialName			NVARCHAR(100)
			,Placement				NVARCHAR(MAX)
			,WIDTH					NVARCHAR(200)
			,ImagePath				NVARCHAR(500)
			,ItemDim1Name			NVARCHAR(100)
			,ItemDim2Name			NVARCHAR(100)
			,ItemDim3Name			NVARCHAR(100)
			,MaterialQuantity		NUMERIC(18,4)
			,MaterialDimension		UNIQUEIDENTIFIER 
			,Comments				NVARCHAR(1020)
			,UOM					NVARCHAR(100)
			,StyleSet				INT
			,WorkFlowID				UNIQUEIDENTIFIER
			,Dimension1				NVARCHAR(500)
			,Dimension2				NVARCHAR(500)
			,Dimension3				NVARCHAR(500)
			,WorkFlowItemID			UNIQUEIDENTIFIER
			,ItemDim1Sort			INT
			,ItemDim2Sort			INT
			,ItemDim3Sort			INT				
			,HeaderColorName		NVARCHAR(100)
			,HeaderColorCode		NVARCHAR(100)
			,HeaderColorImagePath	NVARCHAR(2000)
			,MaterialColorId		UNIQUEIDENTIFIER
			,ItemColorName			NVARCHAR(100)
			,ItemColorCode			NVARCHAR(100)
			,ItemColorImagePath		NVARCHAR(2000)
			,TreatmentSize			NVARCHAR(100)
			,DimensionsFlag			VARCHAR(10)
			,ColorStatus			VARCHAR(10)
			,ConfigColumnName		NVARCHAR(50)
			,ConfigColumnValue		NVARCHAR(50)
		)
		
		
		
		SET @SQLQUERY1='SELECT dbo.fnx_GetMaterialType(SB.MaterialType) AS MaterialType'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SB.MaterialNo'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SB.MaterialName'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SB.Placement'
				SET @SQLQUERY1=@SQLQUERY1+	'	,CONVERT(NVARCHAR(50),SB.width) AS WIDTH'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetStreamingImagePath(SB.MaterialImageID,SB.MaterialImageVersion) AS ImagePath'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.ItemDim1Name'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.ItemDim2Name'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.ItemDim3Name'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.MaterialQuantity'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.MaterialDimension'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.Comments'
				SET @SQLQUERY1=@SQLQUERY1+	'	,CONVERT(NVARCHAR(50),dbo.fnx_GetUnitOfMeasurement(SB.UOM)) AS UOM'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.StyleSet'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.WorkFlowID'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetDimensionName(SBI.ItemDim1TypeId) AS Dimension1'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetDimensionName(SBI.ItemDim2TypeId) AS Dimension2'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetDimensionName(SBI.ItemDim3TypeId) AS Dimension3'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.WorkflowItemID'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBD.ItemDim1Sort'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBD.ItemDim2Sort'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBD.ItemDim3Sort'								
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialMainColorName(SBD.ItemDim1Id) AS HeaderColorName'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialMainColorCode(SBD.ItemDim1Id) AS HeaderColorCode'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialMainColorImagePath(SBD.ItemDim1Id) AS HeaderColorImagePath'
				SET @SQLQUERY1=@SQLQUERY1+	'	,SBI.MaterialColorId'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialItemColorName(SBI.MaterialColorId) AS ItemColorName'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialItemColorCode(SBI.MaterialColorId) AS ItemColorCode'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialItemColorImagePath(SBI.MaterialColorId) AS ItemColorImagePath'
				SET @SQLQUERY1=@SQLQUERY1+	'	,dbo.fnx_GetMaterialTreatmentSize(SBI.MaterialDimension) AS TreatmentSize'
				SET @SQLQUERY1=@SQLQUERY1+	'	,'''+CONVERT(NVARCHAR(10),@DimensionsFlag)+ ''' AS DimensionsFlag'
				SET @SQLQUERY1=@SQLQUERY1+	'	,'''+CONVERT(NVARCHAR(10),@IsColor)+''' AS ColorStatus'
				SET @SQLQUERY1=@SQLQUERY1+	'	,NULL'
				SET @SQLQUERY1=@SQLQUERY1+	'	,NULL'				
				SET @SQLQUERY1=@SQLQUERY1+	'	FROM pStyleBOM SB '
				SET @SQLQUERY1=@SQLQUERY1+	'	INNER JOIN pStyleBOMItem SBI ON SB.StyleMaterialID=SBI.StyleMaterialID'
				SET @SQLQUERY1=@SQLQUERY1+	'	INNER JOIN pStyleBOMDimensionItems SBD ON SBI.StyleBOMDimensionID=SBD.StyleBOMDimensionID'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBD.StyleBOMDimensionID=SB.StyleBOMDimensionId'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBD.StyleBOMDimensionItemID=SBI.StyleBOMDimensionItemID'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBI.StyleID=SBD.StyleID'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBI.WorkflowItemID=SBD.WorkflowItemID'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBD.ItemDim1Active=1'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBD.ItemDim2Active=1'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBD.ItemDim3Active=1'
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBI.StyleID='''+@StyleID+''''
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBI.StyleSet='''+CONVERT(NVARCHAR(10),@StyleSet)+''''
				SET @SQLQUERY1=@SQLQUERY1+	'	AND SBI.WorkFlowItemID='''+CONVERT(NVARCHAR(100),@WorkflowItemID)+''''
				SET @SQLQUERY1=@SQLQUERY1+	'	ORDER BY SBD.ItemDim2Sort'
				
			
				
		BEGIN
			INSERT #tblFinalTable2 EXEC (@SQLQUERY1) 
		END
			
		SELECT * FROM #tblFinalTable2
		DROP  TABLE #tblFinalTable2
	END
	--*Clean Up*--
	DROP  TABLE #tblStyleBOMDimension
	
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02335'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02335', GetDate())

END

GO