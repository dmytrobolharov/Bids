/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyle_SELECT]    Script Date: 09/27/2013 14:53:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemStyle_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyle_SELECT]    Script Date: 09/27/2013 14:53:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItemStyle_SELECT]
(
    @LineFolderID uniqueidentifier,
    @SeasonYearID uniqueidentifier = NULL,
    @LineFolderItemDrop nvarchar(10) = NULL,
    @LineFolderItemSort nvarchar(10) = NULL,
    @SqlViewName nvarchar(4000) = NULL,
    @SqlWhere nvarchar(4000) = NULL
)

AS

/* If LineListHandler is used in Planning folder */
IF CHARINDEX('PlanningID', @SqlWhere) <> 0
BEGIN
	EXEC('SELECT * FROM ' + @SqlViewName + ' ' + @SqlWhere + ' ORDER BY PlanningItemSort, StyleNo')
	EXEC('SELECT COUNT(*) FROM ' + @SqlViewName + ' ' + @SqlWhere)
	RETURN
END
/*Create temp tables.*/
--Holds Style record.
CREATE TABLE #temp
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,LineFolderID UNIQUEIDENTIFIER
	,LineFolderItemID UNIQUEIDENTIFIER
	,LineItemFolder1 nvarchar(100)
	,LineItemFolder2 nvarchar(100)
	,LineItemFolder3 nvarchar(100)
	,LineItemFolder4 nvarchar(100)
	,LineItemFolder5 nvarchar(100)
	,LineItemFolder6 nvarchar(100)
	,LineItemFolder7 nvarchar(100)
	,LineItemFolder8 nvarchar(100)
	,LineItemFolder9 nvarchar(100)
	,LineFolderItemDrop nvarchar(5)
	,LineFolderItemDropUser nvarchar(200)
	,LineFolderItemDropDate datetime
	,LineFolderImageID uniqueidentifier
	,LineFolderImageVersion int
	,LineFolderItemSort nvarchar(5)
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
	,MChange int
	,SeasonYearID UNIQUEIDENTIFIER
	,StyleID UNIQUEIDENTIFIER				--pStyleHeader.StyleID
	,DesignSketchID UNIQUEIDENTIFIER		--pStyleHeader.DesignSketchID
	,StyleCategory NVARCHAR(200)			--pStyleHeader.StyleCategory
	,DesignSketchVersion int				--pStyleHeader.DesignSketchVersion
	,ConceptNo NVARCHAR(200)				--pStyleHeader.DevelopmentNo + pStyleDevelopmentItem.Variation
	,DevelopmentNo NVARCHAR(20)             --pStyleHeader.DevelopmentNo
	,StyleNo NVARCHAR(20)					--pStyleHeader.StyleNo
	,CustomField1 NVARCHAR(200)             --pStyleHeader.CustomField1
	,PatternRef NVARCHAR(200)				--pStyleHeader.CustomField5
	,[Description] NVARCHAR(200)			--pStyleHeader.[Description]
	,DMCStyleType NVARCHAR(200)				--pStyleHeader.CustomField8
	,FabricYarnType NVARCHAR(200)			--pStyleMaterials.F
	,MainMaterial NVARCHAR(200)				--pStyleMaterials.MaterialName
	,[Content] NVARCHAR(200)				--pStyleMaterials.H
	,FabricWeight NVARCHAR(200)				--pStyleMaterials.I
	,SizeClass NVARCHAR(50)					--pStyleHeader.SizeClass
	,SizeRange NVARCHAR(50)					--pStyleHeader.SizeRange
	,CustomField3 NVARCHAR(200)					--pStyleHeader.CustomField3
	,BOMName NVARCHAR(200)					--pWorkflowItem.WorkflowItemName (BOM)
	,TPAgent1 NVARCHAR(200)					--uTradePartner.TradePartnerName
	,TPAgent2 NVARCHAR(200)					--uTradePartner.TradePartnerName
	,TPAgent3 NVARCHAR(200)					--uTradePartner.TradePartnerName
	,TPAgent4 NVARCHAR(200)					--uTradePartner.TradePartnerName
	,TPAgent5 NVARCHAR(200)					--uTradePartner.TradePartnerName
	,TPAgent6 NVARCHAR(200)					--uTradePartner.TradePartnerName
	,ColorName NVARCHAR(4000)				--pLineFolderItemColor.StyleColorName (Items strung together)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp ADD CONSTRAINT
	PK_#temp PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


--Holds Tech Pack Agent records.
CREATE TABLE dbo.#tempTPAgents
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,TradePartnerID UNIQUEIDENTIFIER
	,TPAgent NVARCHAR(200)
	)  ON [PRIMARY]

ALTER TABLE dbo.#tempTPAgents ADD CONSTRAINT
	PK_#tempTPAgents PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


--Holds Colorway records.
CREATE TABLE dbo.#tempColorways
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,ColorNameIndividual NVARCHAR(200)
	)  ON [PRIMARY]

ALTER TABLE dbo.#tempColorways ADD CONSTRAINT
	PK_#tempColorways PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


/*Declare variables.*/
DECLARE @TotalCount2 INT
DECLARE @RowCounter2 INT

DECLARE @LineFolderItemID UNIQUEIDENTIFIER
DECLARE @StyleID UNIQUEIDENTIFIER

DECLARE @TotalCount INT
DECLARE @RowCounter INT

DECLARE @TPAgent NVARCHAR(200)

DECLARE @SQLString nvarchar(4000)

DECLARE @ColorNameIndividual NVARCHAR(200)
DECLARE @ColorName NVARCHAR(4000)

DECLARE @LineFolderTypeID uniqueidentifier
SELECT @LineFolderTypeID = LineFolderTypeID from pLineFolder WHERE LineFolderID=@LineFolderID
/*
Get the initial data for the Style records 
FROM VIEW IN THE PARAMS
*/

EXEC('INSERT INTO #temp(
	LineFolderID
	,LineFolderItemID
	,LineItemFolder1 
	,LineItemFolder2 
	,LineItemFolder3 
	,LineItemFolder4 
	,LineItemFolder5 
	,LineItemFolder6 
	,LineItemFolder7 
	,LineItemFolder8 
	,LineItemFolder9 
	,LineFolderItemDrop 
	,LineFolderItemDropUser 
	,LineFolderItemDropDate 
	,LineFolderImageID 
	,LineFolderImageVersion 
	,LineFolderItemSort
	,DesignSketchID
	,StyleCategory
	,DesignSketchVersion
	,CUser 
	,CDate 
	,MUser 
	,MDate 
	,MChange 
	,StyleID
	,ConceptNo
	,DevelopmentNo
	,StyleNo
	,CustomField1
	,PatternRef
	,[Description]
	,DMCStyleType
	,FabricYarnType
	,MainMaterial
	,[Content]
	,FabricWeight
	,SizeClass
	,SizeRange
	,CustomField3
	,BOMName
)
SELECT
	LineFolderID
	,LineFolderItemID
	,LineItemFolder1 
	,LineItemFolder2 
	,LineItemFolder3 
	,LineItemFolder4 
	,LineItemFolder5 
	,LineItemFolder6 
	,LineItemFolder7 
	,LineItemFolder8 
	,LineItemFolder9 
	,LineFolderItemDrop 
	,LineFolderItemDropUser 
	,LineFolderItemDropDate 
	,LineFolderImageID 
	,LineFolderImageVersion 
	,LineFolderItemSort
	,DesignSketchID
	,StyleCategoryName
	,DesignSketchVersion
	,CUser 
	,CDate 
	,MUser 
	,MDate 
	,MChange 
	,StyleID
	,ConceptNo
	,DevelopmentNo
	,StyleNo
	,CustomField1
	,PatternRef
	,[Description]
	,DMCStyleType
	,FabricYarnType
	,MainMaterial
	,[Content]
	,FabricWeight
	,SizeClass
	,SizeRange
	,StyleStatus
	,BOMName
FROM ' + @SqlViewName + ' 
' + @SqlWhere + ' 
ORDER BY LineFolderItemSort, StyleNo')



/*Get and set counts for records in the Line Folder.*/
SELECT @TotalCount2 = COUNT(*) FROM #temp
SET @RowCounter2 = 1



/*Loop through the Line Folder records.*/
WHILE(@RowCounter2 <= @TotalCount2)
	BEGIN
		/*Clear variables.*/
		SET @LineFolderItemID = NULL
		SET @StyleID =NULL

		/*Get the LineFolderItemID and StyleID.*/
		SELECT @LineFolderItemID = LineFolderItemID
			,@StyleID = StyleID
		FROM #temp
		WHERE TableRow = @RowCounter2


		/*Get information for TP Agents for the Style.*/
		INSERT INTO #tempTPAgents(
			StyleID
			,TradePartnerID
			,TPAgent
		)
		SELECT DISTINCT TOP 6
			pTechPackTeam.StyleID
			,pTechPackTeam.TeamID AS TradePartnerID
			,uTradePartner.TradePartnerName AS TPAgent
		FROM pTechPackTeam
			INNER JOIN uTradePartner ON	pTechPackTeam.TeamID = uTradePartner.TradePartnerID
		WHERE pTechPackTeam.StyleID = @StyleID
		ORDER BY uTradePartner.TradePartnerName ASC


		/*Get & set counters of TPAgents.*/
		SELECT @TotalCount = COUNT(*) FROM #tempTPAgents
		SET @RowCounter = 1


		/*Loop to update Style record with Tech Pack Agents.*/
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				/*Clear variables.*/
				SET @TPAgent = ''

				/*Get Tech Pack Agent name.*/
				SELECT @TPAgent = Replace(TPAgent,'''','''''')
				FROM #tempTPAgents
				WHERE TableRow = @RowCounter

				/*Build dynamic SQL String.*/
				SET @SQLString = ' UPDATE #temp '
				SET @SQLString = @SQLString + ' SET TPAgent' + CAST(@RowCounter AS NVARCHAR(5)) + ' = ''' + @TPAgent + ''''
				SET @SQLString = @SQLString + ' WHERE TableRow = ' + CAST(@RowCounter2 AS NVARCHAR(5))

				/************/
				/*Testing.	*/
				/************/
--				SELECT @SQLString

				/*Run dynamic SQL String to update Style record.*/
				EXEC(@SQLString)

				/*Up counter.*/
				SET @RowCounter = @RowCounter + 1
			END

		IF @LineFolderTypeID='00000000-0000-0000-0000-000000000000' begin
		/*Get Colorway records.*/
		INSERT INTO #tempColorways(
			ColorNameIndividual
		)
		SELECT
			StyleColorName AS ColorNameIndividual
		FROM pLineFolderItemColor
		WHERE LineFolderItemID = @LineFolderItemID
			AND LineFolderItemColorDrop <> 1
		ORDER BY StyleColorName
		end
		else 
		begin
		/*Get BOM Colorway records.*/
		INSERT INTO #tempColorways(
			ColorNameIndividual
		)
		SELECT
			pColorPalette.ColorName AS ColorNameIndividual
		FROM pLineFolderItem
		INNER JOIN pStyleBOMDimension ON pLineFolderItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID 
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pColorPalette ON pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID
	WHERE pLineFolderItem.LineFolderItemID = @LineFolderItemID
	ORDER BY ColorNameIndividual
		end

		/*Get & set counters.*/
		SELECT @TotalCount = COUNT(*) FROM #tempColorways
		SET @RowCounter = 1


		/*Clear variables.*/
		SET @ColorName = ''


		/*Loop to string the ColorNames together.*/
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				/*Clear variables.*/
				SET @ColorNameIndividual = ''

				/*Get ColorName.*/
				SELECT @ColorNameIndividual = ColorNameIndividual
				FROM #tempColorways
				WHERE TableRow = @RowCounter

				/*Add individual color to the color string.*/
				IF(@RowCounter = 1)
					BEGIN
						SET @ColorName = @ColorNameIndividual
					END
				ELSE
					BEGIN
						SET @ColorName = @ColorName + ', ' + @ColorNameIndividual
					END

				/*Up counter.*/
				SET @RowCounter = @RowCounter + 1
			END


		/*Update temp table with strung together colorway names.*/
		UPDATE #temp
		SET ColorName = @ColorName
		WHERE TableRow = @RowCounter2


		/*Truncate temp tables to be re-used for next pass of a Line Folder record.*/
		TRUNCATE TABLE #tempTPAgents
		TRUNCATE TABLE #tempColorways


		/*Up counter.*/
		SET @RowCounter2 = @RowCounter2 + 1
	END


/*Final SELECT.*/
SELECT * FROM #temp ORDER BY LineFolderItemSort, StyleNo

/*Final COUNT(*)
It's required for paging on ASPX page
*/
SELECT COUNT(*) FROM #temp

/*Drop temp table.*/
DROP TABLE #temp
DROP TABLE #tempTPAgents
DROP TABLE #tempColorways


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06376', GetDate())
GO
