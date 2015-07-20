
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialSummary_Linked_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialSummary_Linked_UPDATE]
GO


/*
** Comment #02 
** Artemio Gomez - 3/25/2010 :  Remove Primary Key/Index in Temp table, It is causing problems
***
*/
CREATE PROCEDURE dbo.spx_StyleMaterialSummary_Linked_UPDATE
(
	@StyleMaterialID uniqueidentifier
	,@StyleID uniqueidentifier
	,@StyleSet int
	,@MUser nvarchar(200)
	,@MDate datetime
	,@SQLString varchar(8000)
)

AS


--Daniel Pak 04-14-10
--Comment #1
--Force selected BoM update and disable main material update
--because it will update from original request
BEGIN
	EXEC spx_StyleMaterialSummary_UPDATE
		 @StyleMaterialID
		,@StyleID
		,@StyleSet
		,@MUser
		,@MDate
		,@SqlString		
END



/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleMaterialID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.
DECLARE @StyleID_Param UNIQUEIDENTIFIER				--Keep a copy of the original parameter value.
DECLARE @StyleSet_Param INT							--Keep a copy of the original parameter value.

DECLARE @StyleLinkID UNIQUEIDENTIFIER

DECLARE @MainMaterial_Previous INT

DECLARE @StyleMaterialLinkID UNIQUEIDENTIFIER			--To find the the same Material in the other Styles.

DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************************************/
/*Save a copy of the original parameter values.	*/
/************************************************/
SET @StyleMaterialID_Param = @StyleMaterialID
SET @StyleID_Param = @StyleID
SET @StyleSet_Param = @StyleSet


/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE #temp_Linked
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
	,StyleSet INT
	,StyleMaterialID UNIQUEIDENTIFIER
	)  ON [PRIMARY]


/* Comment #02 
ALTER TABLE #temp_Linked ADD CONSTRAINT
	PK_#temp_Linked PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
*/


/****************************************************/
/*Check to see if the Style is Multi-Cloth linked.	*/
/****************************************************/
/*Get the 'MainMaterial' value for checking later on.*/
SELECT @MainMaterial_Previous = MainMaterial
FROM pStyleMaterials
WHERE StyleMaterialID = @StyleMaterialID_Param


/*Get the 'StyleLinkID' of the calling Style.*/
SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader
WHERE StyleID = @StyleID


/********************************************************************/
/*See if there are other Multi-Cloth linked Styles with this one.	*/
/********************************************************************/
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000' OR @MainMaterial_Previous = 1)	--Style is not Multi-Cloth linked, or this is a Main Material.
	BEGIN
		/*Execute original procedure with original parameters.*/
		-- Daniel Pak 04-17-10
		--See Comment # 1
		--		EXEC spx_StyleMaterialSummary_UPDATE
		--			@StyleMaterialID_Param
		--			,@StyleID_Param
		--			,@StyleSet_Param
		--			,@MUser
		--			,@MDate
		--			,@SqlString
			
		SELECT 1	
			
	END
	
	
	
ELSE	--Style is Multi-Cloth linked and this is not a Main Material.
	BEGIN
		/*Clear variables.*/
		SET @StyleMaterialLinkID = NULL


		/*Get the 'StyleMaterialLinkID' value of the calling Style.*/
		SELECT @StyleMaterialLinkID = StyleMaterialLinkID
		FROM pStyleMaterials
		WHERE StyleMaterialID = @StyleMaterialID_Param


		/*Get all the Styles that are Multi-Cloth linked to this 'StyleLinkID'.*/
		INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet)
		SELECT
			StyleID
			,StyleLinkID
			,@StyleSet
		FROM pStyleHeader
		WHERE StyleLinkID = @StyleLinkID


		/*Get and set the counts for the Multi-Cloth linked Styles.*/
		SELECT @TotalCount = COUNT(*) FROM #temp_Linked
		SET @RowCounter = 1


		/*Get the 'StyleMaterialID' of the Material for each of the Multi-Cloth linked Styles.*/
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				/*Clear variables.*/
				SET @StyleID = NULL
				SET @StyleSet = NULL
				SET @StyleMaterialID = NULL


				/*Get 'StyleID'.*/
				SELECT @StyleID = StyleID
					,@StyleSet = StyleSet
				FROM #temp_Linked
				WHERE TableRow = @RowCounter


				/*Get the 'StyleMaterialID'.*/
				SELECT @StyleMaterialID = StyleMaterialID
				FROM pStyleMaterials
				WHERE StyleID = @StyleID
					AND StyleSet = @StyleSet
					AND StyleMaterialLinkID = @StyleMaterialLinkID


				/*Update the temp table with the 'StyleMaterialID'.*/
				UPDATE #temp_Linked
				SET StyleMaterialID = @StyleMaterialID
				WHERE TableRow = @RowCounter


				/*Up row counter.*/
				SET @RowCounter = @RowCounter + 1
			END
	END


/********************************************************************/
/*Loop through the records to update all Multi-Cloth linked Styles.	*/
/********************************************************************/
/*Get and set the counts for the Multi-Cloth linked Styles.*/
SELECT @TotalCount = COUNT(*) FROM #temp_Linked
SET @RowCounter = 1


/*Get the 'StyleID' for each of the Multi-Cloth linked Styles.*/
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		/*Clear variables.*/
		SET @StyleMaterialID = NULL
		SET @StyleID = NULL
		SET @StyleSet = NULL


		/*Get the 'StyleID' for the update.*/
		SELECT @StyleMaterialID = StyleMaterialID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
		FROM #temp_Linked
		WHERE TableRow = @RowCounter

		/*
			Replace SQL string with STYLEMATERIALID from temp table 
			Daniel Pak 2/13/2010
		*/
		DECLARE @TmpSQLString varchar(8000)
		SET @TmpSQLString = REPLACE(@SQLString, CAST(@StyleMaterialID_Param AS VARCHAR(40)), CAST(@StyleMaterialID AS VARCHAR(40)))	

		SELECT @TmpSQLString 

		/*Execute the original procedure for another Style.*/
		EXEC spx_StyleMaterialSummary_UPDATE
			@StyleMaterialID
			,@StyleID
			,@StyleSet
			,@MUser
			,@MDate
			,@TmpSQLString

		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


--SELECT * FROM #temp_Linked


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_Linked
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '041', GetDate())
GO
