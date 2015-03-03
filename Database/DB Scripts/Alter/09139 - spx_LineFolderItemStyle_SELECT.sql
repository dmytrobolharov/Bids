IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemStyle_SELECT]
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
	,StyleType int							--pStyleHeader.StyleType
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
	,StyleType 
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
	,StyleType
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


-- select tech pack agent names
;WITH DistinctPartners AS (
	SELECT DISTINCT pTechPackTeam.StyleID
	, pTechPackTeam.TeamID
	, uTradePartner.TradePartnerName AS TPAgent
	FROM pTechPackTeam
	INNER JOIN uTradePartner ON pTechPackTeam.TeamID = uTradePartner.TradePartnerID
	INNER JOIN #temp t ON pTechPackTeam.StyleId = t.StyleID)
, TeackPackTeam AS (
	SELECT StyleID
		, TPAgent
		, ROW_NUMBER() OVER (PARTITION BY StyleID ORDER BY TPAgent ASC) AS RowNo
	FROM DistinctPartners)
, Top6 AS (
	SELECT * FROM TeackPackTeam
	WHERE RowNo <= 6)
, Pivoted AS (
	SELECT StyleId, [1], [2], [3], [4], [5], [6] FROM Top6
	PIVOT (MAX(TPAgent) FOR RowNo IN ([1], [2], [3], [4], [5], [6])) pvt)
UPDATE t SET t.TPAgent1 = p.[1]
	, t.TPAgent2 = p.[2]
	, t.TPAgent3 = p.[3]
	, t.TPAgent4 = p.[4]
	, t.TPAgent5 = p.[5]
	, t.TPAgent6 = p.[6]
FROM #temp t
INNER JOIN Pivoted p ON t.StyleID = p.StyleId

-- concatenate color names into one string and update #temp table with it
IF @LineFolderTypeID='00000000-0000-0000-0000-000000000000'
BEGIN
	UPDATE t SET ColorName = STUFF((
		SELECT ', ' + lfic.StyleColorName
		FROM pLineFolderItemColor lfic
		WHERE lfic.LineFolderItemID = t.LineFolderItemID
			AND lfic.LineFolderItemColorDrop <> 1
		ORDER BY lfic.StyleColorName FOR XML PATH(''))
		, 1, 2, '')
	FROM #temp t
END
ELSE
BEGIN
	UPDATE t SET ColorName = STUFF((
		SELECT ', ' + pStyleColorway.StyleColorName
		FROM pLineFolderItem
		INNER JOIN pStyleBOMDimension ON pLineFolderItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID
		INNER JOIN pStyleColorway ON pStyleBOMDimensionItem.ItemDim1Id = pStyleColorway.StyleColorID
			OR pStyleBOMDimensionItem.ItemDim2Id = pStyleColorway.StyleColorID
			OR pStyleBOMDimensionItem.ItemDim3Id = pStyleColorway.StyleColorID
		WHERE pLineFolderItem.LineFolderItemID = t.LineFolderItemID
		ORDER BY pStyleColorway.StyleColorName FOR XML PATH(''))
		, 1, 2, '')
	FROM #temp t
END


/*Final SELECT.*/
SELECT * FROM #temp ORDER BY LineFolderItemSort, StyleNo

/*Final COUNT(*)
It's required for paging on ASPX page
*/
SELECT COUNT(*) FROM #temp

/*Drop temp table.*/
DROP TABLE #temp




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09139', GetDate())
GO