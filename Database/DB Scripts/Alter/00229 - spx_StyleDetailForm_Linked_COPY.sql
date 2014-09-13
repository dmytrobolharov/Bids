
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_Linked_COPY]
(
	@StyleDetailFormID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@Comments nvarchar(2000),
	@StyleSet int,
	@ImageID uniqueidentifier,
	@ImageVersion int,
	@CreatedBy nvarchar(100),
	@CreatedDate datetime,
	@CopyStyleID uniqueidentifier,
	@CopyStyleSet int
)

AS 


/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleID_Param UNIQUEIDENTIFIER			--Keep a copy of the original parameter value.
DECLARE @StyleSet_Param INT						--Keep a copy of the original parameter value.

DECLARE @StyleLinkID UNIQUEIDENTIFIER

DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************************************/
/*Save a copy of the original parameter values.	*/
/************************************************/
SET @StyleID_Param = @StyleID
SET @StyleSet_Param = @StyleSet


/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE dbo.#temp_Linked
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
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
/*Get the 'StyleLinkID' of the calling Style.*/
SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader
WHERE StyleID = @StyleID_Param


/********************************************************************/
/*See if there are other Multi-Cloth linked Styles with this one.	*/
/********************************************************************/
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000')	--Style is not Multi-Cloth linked.
	BEGIN
		/*Execute original procedure with original parameters.*/
		EXEC spx_StyleDetailForm_COPY
			@StyleDetailFormID
			,@WorkflowID
			,@StyleID_Param
			,@Comments
			,@StyleSet_Param
			,@ImageID
			,@ImageVersion
			,@CreatedBy
			,@CreatedDate
			,@CopyStyleID
			,@CopyStyleSet
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
			,@StyleSet_Param AS StyleSet
		FROM pStyleHeader
		WHERE StyleLinkID = @StyleLinkID
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
		SET @StyleID = NULL
		SET @StyleSet = NULL


		/*Get the 'StyleID' for the insert.*/
		SELECT @StyleID = StyleID
			,@StyleSet = StyleSet
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		/*Execute the original procedure for another Style.*/
		EXEC spx_StyleDetailForm_COPY
			@StyleDetailFormID
			,@WorkflowID
			,@StyleID
			,@Comments
			,@StyleSet
			,@ImageID
			,@ImageVersion
			,@CreatedBy
			,@CreatedDate
			,@CopyStyleID
			,@CopyStyleSet


		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_Linked

