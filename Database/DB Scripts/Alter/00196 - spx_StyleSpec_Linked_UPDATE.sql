ALTER PROCEDURE [dbo].[spx_StyleSpec_Linked_UPDATE]
(
	@SpecID				uniqueidentifier,
	@POM				nvarchar(10),
	@PointMeasure		nvarchar(225),
	@TOL				numeric(18,4),
	@TOLN				numeric(18,4),
	@Spec				numeric(18,4),
	@Proto0				numeric(18,4),
	@Proto1				numeric(18,4),
	@Proto2				numeric(18,4),
	@Proto3				numeric(18,4),
	@Proto4				numeric(18,4),
	@Proto5				numeric(18,4),
	@Proto6				numeric(18,4),
	@Proto7				numeric(18,4),
	@Proto8				numeric(18,4),
	@Proto9				numeric(18,4),
	@Proto10			numeric(18,4),
	@Proto11			numeric(18,4),
	@Proto12			numeric(18,4),
	@Proto13			numeric(18,4),
	@Proto14			numeric(18,4),
	@Proto15			numeric(18,4),
	@Proto16			numeric(18,4),
	@Proto17			numeric(18,4),
	@Proto18			numeric(18,4),
	@Proto19			numeric(18,4),
	@ModifiedBy			nvarchar(200),
	@ModifiedDate		datetime
)

AS


/************************/
/*Declare variables.	*/
/************************/
DECLARE @SpecID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.

DECLARE @POM_Orig NVARCHAR(10)				--Store the original POM Code value.
DECLARE @PointMeasure_Orig NVARCHAR(225)	--Store the original POM Name.

DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleLinkID UNIQUEIDENTIFIER
DECLARE @StyleSet INT

DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************************************/
/*Save a copy of the original parameter values.	*/
/************************************************/
SET @SpecID_Param = @SpecID


/************************************************************************************/
/*Save a copy of the original POM Code and POM Name, in case those have changed.	*/
/************************************************************************************/
SELECT @POM_Orig = POM
	,@PointMeasure_Orig = PointMeasur
FROM pStyleSpec
WHERE SpecID = @SpecID_Param


/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE dbo.#temp_Linked
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
	,SpecID UNIQUEIDENTIFIER
	,StyleSet INT
	)  ON [PRIMARY]


ALTER TABLE dbo.#temp_Linked ADD CONSTRAINT
	PK_#temp_Linked PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


/****************************************************/
/*Check to see if the Style is Multi-Cloth linked.	*/
/****************************************************/
/*Get the 'StyleID' and 'StyleSet' of the calling Style.*/
SELECT @StyleID = StyleID
	,@StyleSet = StyleSet
FROM pStyleSpec
WHERE SpecID = @SpecID_Param


/*Get the 'StyleLinkID' of the calling Style.*/
SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader
WHERE StyleID = @StyleID


/********************************************************************/
/*See if there are other Multi-Cloth linked Styles with this one.	*/
/********************************************************************/
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000')	--Style is not Multi-Cloth linked.
	BEGIN
		/*Execute original procedure with original parameters.*/
		EXEC spx_StyleSpec_UPDATE
			@SpecID_Param
			,@POM
			,@PointMeasure
			,@TOL
			,@TOLN
			,@Spec
			,@Proto0
			,@Proto1
			,@Proto2
			,@Proto3
			,@Proto4
			,@Proto5
			,@Proto6
			,@Proto7
			,@Proto8
			,@Proto9
			,@Proto10
			,@Proto11
			,@Proto12
			,@Proto13
			,@Proto14
			,@Proto15
			,@Proto16
			,@Proto17
			,@Proto18
			,@Proto19
			,@ModifiedBy
			,@ModifiedDate
	END
ELSE	--Style is Multi-Cloth linked.
	BEGIN
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


		/*Get the 'SpecID' of the POM for each of the Multi-Cloth linked Styles.*/
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				/*Clear variables.*/
				SET @StyleID = NULL
				SET @SpecID = NULL
				SET @StyleSet = NULL


				/*Get 'StyleID'.*/
				SELECT @StyleID = StyleID
					,@StyleSet = StyleSet
				FROM #temp_Linked
				WHERE TableRow = @RowCounter


				/*Get the 'SpecID'.*/
				SELECT @SpecID = SpecID
				FROM pStyleSpec
				WHERE StyleID = @StyleID
					AND StyleSet = @StyleSet
					AND POM = @POM_Orig
					AND PointMeasur = @PointMeasure_Orig


				/*Update the temp table with the 'SpecID'.*/
				UPDATE #temp_Linked
				SET SpecID = @SpecID
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


/*Get the 'SpecID' of the POM for each of the Multi-Cloth linked Styles.*/
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		/*Clear variables.*/
		SET @SpecID = NULL


		/*Get the 'SpecID' for the update.*/
		SELECT @SpecID = SpecID
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		/*Execute the original procedure for another Style.*/
		EXEC spx_StyleSpec_UPDATE
			@SpecID
			,@POM
			,@PointMeasure
			,@TOL
			,@TOLN
			,@Spec
			,@Proto0
			,@Proto1
			,@Proto2
			,@Proto3
			,@Proto4
			,@Proto5
			,@Proto6
			,@Proto7
			,@Proto8
			,@Proto9
			,@Proto10
			,@Proto11
			,@Proto12
			,@Proto13
			,@Proto14
			,@Proto15
			,@Proto16
			,@Proto17
			,@Proto18
			,@Proto19
			,@ModifiedBy
			,@ModifiedDate


		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_Linked
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '196', GetDate())
GO