IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCore_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialCore_COPY]
GO



CREATE PROCEDURE [dbo].[spx_MaterialCore_COPY](
@MaterialCoreID UNIQUEIDENTIFIER,
@MaterialCoreNewID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME
)

AS

/*
CREATE TABLE #mi ( 
ROWID INT IDENTITY,
MaterialCoreItemID UNIQUEIDENTIFIER,
MaterialCoreItemCopyID UNIQUEIDENTIFIER
)

INSERT INTO #mi ( MaterialCoreItemID,MaterialCoreItemCopyID)
SELECT NEWID(), MaterialCoreItemID
FROM pMaterialCoreItem
WHERE MaterialCoreID = @MaterialCoreID



--INSERT INTO pMaterialCoreItem ( MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialCoreItemCopyID, 
--CDate, CUser, MDate, MUser ) 
--SELECT NEWID(), @MaterialCoreID, MaterialID, MaterialCoreItemID,
--@CDate, @CUser, @CDate, @CUser
--FROM pMaterialCoreItem WHERE MaterialCoreID =  @MaterialCoreID


CREATE TABLE #mc(
ROWID INT IDENTITY, 
MaterialCoreColorID UNIQUEIDENTIFIER,
MaterialCoreColorCopyID UNIQUEIDENTIFIER
)


CREATE TABLE #mci(
ROWID INT IDENTITY, 
MaterialCoreColorItemID UNIQUEIDENTIFIER,
MaterialCoreColorID UNIQUEIDENTIFIER,
MaterialCoreColorItemCopyID UNIQUEIDENTIFIER,
MaterialCoreColorCopyID UNIQUEIDENTIFIER
)


INSERT INTO #mc ( MaterialCoreColorID,MaterialCoreColorCopyID)
SELECT NEWID(),  MaterialCoreColorID
FROM pMaterialCoreColor 
WHERE MaterialCoreID = @MaterialCoreID 

INSERT INTO #mci ( MaterialCoreColorItemID, MaterialCoreColorItemCopyID, MaterialCoreColorCopyID)
SELECT NEWID(),  MaterialCoreColorItemID, MaterialCoreColorID, MaterialCoreItemID
FROM pMaterialCoreColorItem 
WHERE MaterialCoreID = @MaterialCoreID 



select * from pMaterialCoreColorItem

UPDATE #mci
SET #mci.MaterialCoreColorID = #mc.MaterialCoreColorID
FROM #mci 
INNER JOIN #mc ON #mci.MaterialCoreColorCopyID = #mc.MaterialCoreColorCopyID


INSERT INTO pMaterialCoreColor (MaterialCoreColorID, MaterialCoreID , ColorPaletteID, ColorCode, ColorName, Active, Sort,
CDate, CUser, MDate, MUser) 
SELECT a.MaterialCoreColorID, @MaterialCoreNewID, ColorPaletteID, ColorCode, ColorName, Active, Sort, 
@CUser, @CDate,  @CUser, @CDate
FROM #mc a
INNER JOIN pMaterialCoreColor b ON a.MaterialCoreColorCopyID = b.MaterialCoreColorID


INSERT INTO pMaterialCoreColorItem  ( MaterialCoreColorItemID, MaterialCoreColorID, MaterialCore


SELECT * FROM pMaterialCoreColorItem 






SELECT * FROM pMaterialCoreColorItem


SELECT * FROM pMaterialCoreColorItem



*/





--/************/
--/*Testing.	*/
--/************/
--DECLARE @MaterialCoreID UNIQUEIDENTIFIER
--DECLARE @CreatedBy NVARCHAR(100)
--DECLARE @CreatedDate DATETIME
--SET @MaterialCoreID = '3cdef533-5044-41bc-8646-07076a48a2f8'
--SET @CreatedBy  = 'Homie ''G'''
--SET @CreatedDate = '2010-02-28 12:00:00.000'


/********************/
/*Create variables.	*/
/********************/
DECLARE @MaterialCoreID_Copy UNIQUEIDENTIFIER

DECLARE @MaterialCoreItemID_Original UNIQUEIDENTIFIER
DECLARE @MaterialCoreItemID_Copy UNIQUEIDENTIFIER

DECLARE @MaterialCoreColorID_Original UNIQUEIDENTIFIER
DECLARE @MaterialCoreColorID_Copy UNIQUEIDENTIFIER

DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************/
/*Create temp tables.	*/
/************************/
--Holds original Material Group Header record.
CREATE TABLE dbo.#temp_pMaterialCore_Original
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreID uniqueidentifier
	,MaterialCoreName nvarchar(100)
	,MaterialCoreDescription nvarchar(4000)
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
	,Active nvarchar(5)
	,Sort nvarchar(5)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCore_Original ADD CONSTRAINT
	PK_#temp_pMaterialCore_Original PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--Holds copied Material Group Header record.
CREATE TABLE dbo.#temp_pMaterialCore_Copy
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreID uniqueidentifier
	,MaterialCoreName nvarchar(100)
	,MaterialCoreDescription nvarchar(4000)
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
	,Active nvarchar(5)
	,Sort nvarchar(5)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCore_Copy ADD CONSTRAINT
	PK_#temp_pMaterialCore_Copy PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--Holds original Material Group Materials.
CREATE TABLE dbo.#temp_pMaterialCoreItem_Original
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreItemID uniqueidentifier
	,MaterialCoreID uniqueidentifier
	,MaterialID uniqueidentifier
	,UOM nvarchar(50)
	,Qty nvarchar(18)
	,MaterialPrice money
	,Ext money
	,MaterialSize nvarchar(100)
	,Placement nvarchar(4000)
	,Artwork int
	,License int
	,Colorway int
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCoreItem_Original ADD CONSTRAINT
	PK_#temp_pMaterialCoreItem_Original PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--Holds copied Material Group Materials.
CREATE TABLE dbo.#temp_pMaterialCoreItem_Copy
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreItemID uniqueidentifier
	,MaterialCoreID uniqueidentifier
	,MaterialID uniqueidentifier
	,UOM nvarchar(50)
	,Qty nvarchar(18)
	,MaterialPrice money
	,Ext money
	,MaterialSize nvarchar(100)
	,Placement nvarchar(4000)
	,Artwork int
	,License int
	,Colorway int
	,CUser nvarchar(200)
	,CDate datetime
	,MUser nvarchar(200)
	,MDate datetime
	,MaterialCoreItemCopyID uniqueidentifier
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCoreItem_Copy ADD CONSTRAINT
	PK_#temp_pMaterialCoreItem_Copy PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

/*Holds original Material Group Colors.*/  --#01
CREATE TABLE dbo.#temp_pMaterialCoreColor_Original
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreColorID uniqueidentifier
	,MaterialCoreID uniqueidentifier
	,ColorPaletteID uniqueidentifier
	,ColorCode nvarchar(200)
	,ColorName nvarchar(200)
	,Active int
	,Sort varchar(5)
	,CDate datetime
	,CUser nvarchar(200)
	,MDate datetime
	,MUser nvarchar(200)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCoreColor_Original ADD CONSTRAINT
	PK_#temp_pMaterialCoreColor_Original PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

/*Holds copied Material Group Colors.*/  --#01
CREATE TABLE dbo.#temp_pMaterialCoreColor_Copy
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreColorID uniqueidentifier
	,MaterialCoreID uniqueidentifier
	,ColorPaletteID uniqueidentifier
	,ColorCode nvarchar(200)
	,ColorName nvarchar(200)
	,Active int
	,Sort varchar(5)
	,CDate datetime
	,CUser nvarchar(200)
	,MDate datetime
	,MUser nvarchar(200)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCoreColor_Copy ADD CONSTRAINT
	PK_#temp_pMaterialCoreColor_Copy PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

/*Holds original Material Group Chip Colors.*/  --#01
CREATE TABLE dbo.#temp_pMaterialCoreColorItem_Original
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreColorItemID uniqueidentifier
	,MaterialCoreColorItemMasterID uniqueidentifier
	,MaterialCoreColorID uniqueidentifier
	,MaterialCoreItemID uniqueidentifier
	,MaterialCoreID uniqueidentifier
	,MaterialID uniqueidentifier
	,MaterialColorID uniqueidentifier
	,CDate datetime
	,CUser nvarchar(100)
	,MDate datetime
	,MUser nvarchar(100)
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCoreColorItem_Original ADD CONSTRAINT
	PK_#temp_pMaterialCoreColorItem_Original PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

/*Holds copied Material Group Chip Colors.*/   --#01
CREATE TABLE dbo.#temp_pMaterialCoreColorItem_Copy
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,MaterialCoreColorItemID uniqueidentifier
	,MaterialCoreColorItemMasterID uniqueidentifier
	,MaterialCoreColorID uniqueidentifier
	,MaterialCoreItemID uniqueidentifier
	,MaterialCoreID uniqueidentifier
	,MaterialID uniqueidentifier
	,MaterialColorID uniqueidentifier
	,CDate datetime
	,CUser nvarchar(100)
	,MDate datetime
	,MUser nvarchar(100)
	,MaterialCoreColorItemCopyID uniqueidentifier
	)  ON [PRIMARY]

ALTER TABLE dbo.#temp_pMaterialCoreColorItem_Copy ADD CONSTRAINT
	PK_#temp_pMaterialCoreColorItem_Copy PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


/************************************************************************/
/*Get the original records and put them in the 'original' temp tables.	*/
/************************************************************************/
--Material Group Header Original.
INSERT INTO #temp_pMaterialCore_Original
	(MaterialCoreID, MaterialCoreName, MaterialCoreDescription, CUser, CDate, 
	MUser, MDate, Active, Sort)
SELECT
	MaterialCoreID, MaterialCoreName,MaterialCoreDescription, CUser, CDate,
	MUser, MDate, Active, Sort
FROM pMaterialCore
WHERE MaterialCoreID = @MaterialCoreID

--Material Group Materials Original.
INSERT INTO #temp_pMaterialCoreItem_Original
	(MaterialCoreItemID, MaterialCoreID, MaterialID, UOM, Qty, MaterialPrice,
	Ext, MaterialSize, Placement, Artwork, License, Colorway, CUser, CDate,
	MUser, MDate)
SELECT
	MaterialCoreItemID, MaterialCoreID, MaterialID, UOM, Qty, MaterialPrice,
	Ext, MaterialSize, Placement, Artwork, License, Colorway, CUser, CDate,
	MUser, MDate
FROM pMaterialCoreItem
WHERE MaterialCoreID = @MaterialCoreID

/*Material Group Colors Original.*/  --#01
INSERT INTO #temp_pMaterialCoreColor_Original
	(MaterialCoreColorID, MaterialCoreID, ColorPaletteID, ColorCode, ColorName,
	Active, Sort, CDate, CUser, MDate, MUser)
SELECT
	MaterialCoreColorID, MaterialCoreID, ColorPaletteID, ColorCode, ColorName,
	Active, Sort, CDate, CUser, MDate, MUser
FROM pMaterialCoreColor
WHERE MaterialCoreID = @MaterialCoreID

/*Material Group Color Chips Original.*/ --#01
INSERT INTO #temp_pMaterialCoreColorItem_Original
	(MaterialCoreColorItemID, MaterialCoreColorItemMasterID, MaterialCoreColorID,
	MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialColorID, CDate, CUser,
	MDate, MUser)
SELECT
	MaterialCoreColorItemID, MaterialCoreColorItemMasterID, MaterialCoreColorID,
	MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialColorID, CDate, CUser,
	MDate, MUser
FROM pMaterialCoreColorItem
WHERE MaterialCoreID = @MaterialCoreID


/********************************************************************/
/*Get the original records and put them in the 'copy' temp tables.	*/
/********************************************************************/
--Material Group Header Copy.
INSERT INTO #temp_pMaterialCore_Copy
	(MaterialCoreID, MaterialCoreName,MaterialCoreDescription, CUser, CDate,
	MUser, MDate, Active, Sort)
SELECT
	MaterialCoreID, MaterialCoreName,MaterialCoreDescription, CUser, CDate,
	MUser, MDate, Active, Sort
FROM #temp_pMaterialCore_Original

--Material Group Materials Copy.
INSERT INTO #temp_pMaterialCoreItem_Copy
	(MaterialCoreItemID, MaterialCoreID, MaterialID, UOM, Qty, MaterialPrice,
	Ext, MaterialSize, Placement, Artwork, License, Colorway, CUser, CDate,
	MUser, MDate, MaterialCoreItemCopyID )
SELECT
	MaterialCoreItemID, MaterialCoreID, MaterialID, UOM, Qty, MaterialPrice,
	Ext, MaterialSize, Placement, Artwork, License, Colorway, CUser, CDate,
	MUser, MDate, MaterialCoreItemID 
FROM #temp_pMaterialCoreItem_Original

/*Material Group Colors Copy.*/ --#01
INSERT INTO #temp_pMaterialCoreColor_Copy
	(MaterialCoreColorID, MaterialCoreID, ColorPaletteID, ColorCode, ColorName,
	Active, Sort, CDate, CUser, MDate, MUser)
SELECT
	MaterialCoreColorID, MaterialCoreID, ColorPaletteID, ColorCode, ColorName,
	Active, Sort, CDate, CUser, MDate, MUser
FROM #temp_pMaterialCoreColor_Original

/*Material Group Color Chips Copy.*/  --#01
INSERT INTO #temp_pMaterialCoreColorItem_Copy
	(MaterialCoreColorItemID, MaterialCoreColorItemMasterID, MaterialCoreColorID,
	MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialColorID, CDate, CUser,
	MDate, MUser, MaterialCoreColorItemCopyID )
SELECT
	MaterialCoreColorItemID, MaterialCoreColorItemMasterID, MaterialCoreColorID,
	MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialColorID, CDate, CUser,
	MDate, MUser, MaterialCoreColorItemID 
FROM #temp_pMaterialCoreColorItem_Original


/*************************************************************************************************/
/*HEADER:  Generate new ID and update 'copy' temp tables with it.  Do 'users' and 'dates' too.	*/
/*************************************************************************************************/
--Make new id.
SET @MaterialCoreID_Copy = @MaterialCoreNewID --NEWID()

--Update header 'copy' temp table.
UPDATE #temp_pMaterialCore_Copy
SET MaterialCoreID = @MaterialCoreNewID
	,CUser = @CUser
	,CDate = @CDate
	,MUser = @CUser
	,MDate = @CDate
WHERE MaterialCoreID = @MaterialCoreID

--Update material 'copy' temp table.
UPDATE #temp_pMaterialCoreItem_Copy
SET MaterialCoreID = @MaterialCoreID_Copy
	,CUser = @CUser
	,CDate = @CDate
	,MUser = @CUser
	,MDate = @CDate
WHERE MaterialCoreID = @MaterialCoreID

/*Update color 'copy' temp table.*/  --#01
UPDATE #temp_pMaterialCoreColor_Copy
SET MaterialCoreID = @MaterialCoreID_Copy
	,CUser = @CUser
	,CDate = @CDate
	,MUser = @CUser
	,MDate = @CDate
WHERE MaterialCoreID = @MaterialCoreID

/*Update color chip 'copy' temp table.*/  --#01
UPDATE #temp_pMaterialCoreColorItem_Copy
SET MaterialCoreID = @MaterialCoreID_Copy
	,CUser = @CUser
	,CDate = @CDate
	,MUser = @CUser
	,MDate = @CDate
WHERE MaterialCoreID = @MaterialCoreID


/************************************************************************/
/*MATERIALS:  Generate new ID and update 'copy' temp tables with it.	*/
/************************************************************************/
--Get and set counters.
SELECT @TotalCount = COUNT(*) FROM #temp_pMaterialCoreItem_Original
SET @RowCounter = 1

--Loop to update 'copy' temp tables.
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		--Clear variable.
		SET @MaterialCoreItemID_Original = NULL

		--Make new id.
		SET @MaterialCoreItemID_Copy = NEWID()

		--Get an 'original' id.
		SELECT @MaterialCoreItemID_Original = MaterialCoreItemID
		FROM #temp_pMaterialCoreItem_Original
		WHERE TableRow = @RowCounter

		--Update material 'copy' temp table.
		UPDATE #temp_pMaterialCoreItem_Copy
		SET MaterialCoreItemID = @MaterialCoreItemID_Copy
		WHERE MaterialCoreItemID = @MaterialCoreItemID_Original

		/*Update color chip 'copy' temp table.*/  --#01
		UPDATE #temp_pMaterialCoreColorItem_Copy
		SET MaterialCoreItemID = @MaterialCoreItemID_Copy
		WHERE MaterialCoreItemID = @MaterialCoreItemID_Original

		--Up counter.
		SET @RowCounter = @RowCounter + 1
	END

--#01
/********************************************************************/
/*COLORS:  Generate new ID and update 'copy' temp tables with it.	*/
/********************************************************************/
--Get and set counters.
SELECT @TotalCount = COUNT(*) FROM #temp_pMaterialCoreColor_Original
SET @RowCounter = 1

--Loop to update 'copy' temp tables.
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		--Clear variable.
		SET @MaterialCoreColorID_Original = NULL

		--Make new id.
		SET @MaterialCoreColorID_Copy = NEWID()

		--Get an 'original' id.
		SELECT @MaterialCoreColorID_Original = MaterialCoreColorID
		FROM #temp_pMaterialCoreColor_Original
		WHERE TableRow = @RowCounter

		--Update color 'copy' temp table.
		UPDATE #temp_pMaterialCoreColor_Copy
		SET MaterialCoreColorID = @MaterialCoreColorID_Copy
		WHERE MaterialCoreColorID = @MaterialCoreColorID_Original

		--Update color chip 'copy' temp table.
		UPDATE #temp_pMaterialCoreColorItem_Copy
		SET MaterialCoreColorID = @MaterialCoreColorID_Copy
		WHERE MaterialCoreColorID = @MaterialCoreColorID_Original

		--Up counter.
		SET @RowCounter = @RowCounter + 1
	END


/********************************************************/
/*COLOR CHIPS:  Generate new IDs for 'copy' temp table.	*/
/********************************************************/
--Update color chip 'copy' temp table.
UPDATE #temp_pMaterialCoreColorItem_Copy
SET MaterialCoreColorItemID = NEWID()


/************************************************/
/*Insert 'copy' records into the real tables.	*/
/************************************************/
--Material Group Header.
--INSERT INTO pMaterialCore
--	(MaterialCoreID, MaterialCoreName,MaterialCoreDescription, CUser, CDate,
--	MUser, MDate, Active, Sort)
--SELECT
--	MaterialCoreID, MaterialCoreName,MaterialCoreDescription, CUser, CDate,
--	MUser, MDate, Active, Sort
--FROM #temp_pMaterialCore_Copy

--Material Group Materials.
INSERT INTO pMaterialCoreItem
	(MaterialCoreItemID, MaterialCoreID, MaterialID, UOM, Qty, MaterialPrice,
	Ext, MaterialSize, Placement, Artwork, License, Colorway, CUser, CDate,
	MUser, MDate, MaterialCoreItemCopyID)
SELECT
	MaterialCoreItemID, MaterialCoreID, MaterialID, UOM, Qty, MaterialPrice,
	Ext, MaterialSize, Placement, Artwork, License, Colorway, CUser, CDate,
	MUser, MDate, MaterialCoreItemCopyID 
FROM #temp_pMaterialCoreItem_Copy

/*Material Group Colors.*/  --#01
INSERT INTO pMaterialCoreColor
	(MaterialCoreColorID, MaterialCoreID, ColorPaletteID, ColorCode, ColorName,
	Active, Sort, CDate, CUser, MDate, MUser)
SELECT
	MaterialCoreColorID, MaterialCoreID, ColorPaletteID, ColorCode, ColorName,
	Active, Sort, CDate, CUser, MDate, MUser
FROM #temp_pMaterialCoreColor_Copy

/*Material Group Color Chips.*/   --#01
INSERT INTO pMaterialCoreColorItem
	(MaterialCoreColorItemID, MaterialCoreColorItemMasterID, MaterialCoreColorID,
	MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialColorID, CDate, CUser,
	MDate, MUser, MaterialCoreColorItemCopyID)
SELECT
	MaterialCoreColorItemID, MaterialCoreColorItemMasterID, MaterialCoreColorID,
	MaterialCoreItemID, MaterialCoreID, MaterialID, MaterialColorID, CDate, CUser,
	MDate, MUser, MaterialCoreColorItemCopyID 
FROM #temp_pMaterialCoreColorItem_Copy


--/************/
--/*Testing.	*/
--/************/
--SELECT * FROM #temp_pMaterialCore_Original
--SELECT * FROM #temp_pMaterialCore_Copy
--SELECT * FROM #temp_pMaterialCoreItem_Original
--SELECT * FROM #temp_pMaterialCoreItem_Copy
--SELECT * FROM #temp_pMaterialCoreColor_Original
--SELECT * FROM #temp_pMaterialCoreColor_Copy
--SELECT * FROM #temp_pMaterialCoreColorItem_Original
--SELECT * FROM #temp_pMaterialCoreColorItem_Copy


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_pMaterialCore_Original
DROP TABLE #temp_pMaterialCore_Copy
DROP TABLE #temp_pMaterialCoreItem_Original
DROP TABLE #temp_pMaterialCoreItem_Copy
DROP TABLE #temp_pMaterialCoreColor_Original  --#01
DROP TABLE #temp_pMaterialCoreColor_Copy	--#01
DROP TABLE #temp_pMaterialCoreColorItem_Original	--#01
DROP TABLE #temp_pMaterialCoreColorItem_Copy  --#01








GO