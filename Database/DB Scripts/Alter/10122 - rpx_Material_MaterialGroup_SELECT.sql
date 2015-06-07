IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_MaterialGroup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_MaterialGroup_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_MaterialGroup_SELECT]
(
	@MaterialCoreID NVARCHAR(50)
)

AS


--/************/
--/*Testing.	*/
--/************/
--DECLARE @MaterialCoreID UNIQUEIDENTIFIER
--SET @MaterialCoreID = '4680ce07-e4c7-4c83-8078-17377ddd697f'


/*Declare variables.*/
DECLARE @MaterialCount INT
DECLARE @ColorwayCount INT


/*Create temp table.*/
CREATE TABLE dbo.#temp_Main
	(
	TableRow int NOT NULL IDENTITY (0, 1)
	,Row INT
	,[Column] INT
	,FolderName NVARCHAR(100)
	,FolderDescription NVARCHAR(4000)
	,Active NVARCHAR(5)
	,MaterialCoreItemID UNIQUEIDENTIFIER
	,ImageFilePath NVARCHAR(255)
	,RecordCode NVARCHAR(50)
	,MaterialName NVARCHAR(200)
	,MaterialCode nVARCHAR(50)
	,TreatmentSizeGuage NVARCHAR(100)
	,Qty NVARCHAR(18)
	,UOM NVARCHAR(50)
	,CLR INT
	,IMG INT
	,Placement NVARCHAR(4000)
	,MaterialCoreColorID UNIQUEIDENTIFIER
	,ColorwayName NVARCHAR(200)
	,MaterialCoreColorItemID UNIQUEIDENTIFIER
	,ColorChipName NVARCHAR(150)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_Main ADD CONSTRAINT
	PK_#temp_Main PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


/*Select items and put in temp table.*/
INSERT INTO #temp_Main
(
	FolderName
	,FolderDescription
	,Active
	,MaterialCoreItemID
	,ImageFilePath
	,RecordCode
	,MaterialName
	,MaterialCode
	,TreatmentSizeGuage
	,Qty
	,UOM
	,CLR
	,IMG
	,Placement
	,MaterialCoreColorID
	,ColorwayName
	,MaterialCoreColorItemID
	,ColorChipName
)
SELECT
	pMaterialCore.MaterialCoreName AS FolderName
	,pMaterialCore.MaterialCoreDescription AS FolderDescription
	,pMaterialCore.Active
	,pMaterialCoreItem.MaterialCoreItemID
	,dbo.fnx_GetStreamingImagePath(pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 500) AS ImageFilePath
	,pMaterial.MaterialNo AS RecordCode
	,pMaterial.MaterialName
	,pMaterial.MaterialCode
	,pMaterialCoreItem.MaterialSize AS TreatmentSizeGuage
	,pMaterialCoreItem.Qty
	,pMaterial.UOM
	,pMaterialCoreItem.Colorway AS CLR
	,pMaterialCoreItem.Artwork AS IMG
	,pMaterialCoreItem.Placement
	,pMaterialCoreColor.MaterialCoreColorID
	,pMaterialCoreColor.ColorName AS ColorwayName
	,pMaterialCoreColorItem.MaterialCoreColorItemID
	,pMaterialColor.ColorName AS ColorChipName
FROM pMaterialCore
	INNER JOIN pMaterialCoreItem ON	pMaterialCore.MaterialCoreID = pMaterialCoreItem.MaterialCoreID
	INNER JOIN pMaterial ON	pMaterialCoreItem.MaterialID = pMaterial.MaterialID
	INNER JOIN pMaterialCoreColor ON	pMaterialCore.MaterialCoreID = pMaterialCoreColor.MaterialCoreID
	INNER JOIN pMaterialCoreColorItem ON	pMaterialCoreItem.MaterialCoreItemID = pMaterialCoreColorItem.MaterialCoreItemID
											AND pMaterialCoreColor.MaterialCoreColorID = pMaterialCoreColorItem.MaterialCoreColorID
	LEFT OUTER JOIN pMaterialColor ON	pMaterialCoreColorItem.MaterialColorID = pMaterialColor.MaterialColorID
WHERE pMaterialCore.MaterialCoreID = @MaterialCoreID
ORDER BY pMaterial.MaterialName
	,pMaterialCoreColor.ColorName


/*Get the 'MaterialCoreItemID' values for row organizing.*/
SELECT
	IDENTITY(INT, 0, 1) AS TableRow
	,MaterialCoreItemID
	,MaterialName
INTO #temp_Materials
FROM #temp_Main
GROUP BY MaterialCoreItemID, MaterialName
ORDER BY MaterialName


/*Get the 'MaterialCoreItemID' values for row organizing.*/
SELECT
	IDENTITY(INT, 0, 1) AS TableRow
	,MaterialCoreColorID
	,ColorwayName
INTO #temp_Colorways
FROM #temp_Main
GROUP BY MaterialCoreColorID, ColorwayName
ORDER BY ColorwayName


/*Update main temp table with row and column values.*/
UPDATE #temp_Main
SET #temp_Main.Row = #temp_Materials.TableRow
	,#temp_Main.[Column] = #temp_Colorways.TableRow
FROM #temp_Main
	INNER JOIN #temp_Materials ON	#temp_Main.MaterialCoreItemID = #temp_Materials.MaterialCoreItemID
	INNER JOIN #temp_Colorways ON	#temp_Main.MaterialCoreColorID = #temp_Colorways.MaterialCoreColorID


/*Select records with row and column numbers.*/
SELECT
	Row
	,[Column]
	,FolderName
	,FolderDescription
	,Active
	,MaterialCoreItemID
	,ImageFilePath
	,RecordCode
	,MaterialName
	,MaterialCode
	,TreatmentSizeGuage
	,Qty
	,UOM
	,CLR
	,IMG
	,Placement
	,MaterialCoreColorID
	,ColorwayName
	,MaterialCoreColorItemID
	,ColorChipName
FROM #temp_Main


/*Drop temp table.*/
DROP TABLE #temp_Main
DROP TABLE #temp_Materials
DROP TABLE #temp_Colorways



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10122', GetUTCDate())
GO