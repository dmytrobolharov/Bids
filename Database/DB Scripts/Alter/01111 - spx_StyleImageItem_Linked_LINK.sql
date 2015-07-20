IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageItem_Linked_LINK]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleImageItem_Linked_LINK]
GO

CREATE PROCEDURE [dbo].[spx_StyleImageItem_Linked_LINK](
	@StyleImageItemID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@CopyStyleID nvarchar(50),
	@CopyStyleSet nvarchar(50),
	@WorkflowID nvarchar(50)
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
DECLARE @SessionItemTempID UNIQUEIDENTIFIER 

SET @SessionItemTempID = NEWID()


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
		EXEC spx_StyleImageItem_LINK
		@StyleImageItemID = @StyleImageItemID,
		@StyleID = @StyleID_Param,
		@StyleSet = @StyleSet_Param,
		@CopyStyleID = @CopyStyleID,
		@CopyStyleSet = @CopyStyleSet,
		@WorkflowID = @WorkflowID,
		@SessionItemTempID = NULL
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

SELECT * FROM #temp_Linked

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
		EXEC spx_StyleImageItem_LINK
		@StyleImageItemID = @StyleImageItemID,
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@CopyStyleID = @CopyStyleID,
		@CopyStyleSet = @CopyStyleSet,
		@WorkflowID = @WorkflowID,
		@SessionItemTempID = @SessionItemTempID


		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_Linked

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01111', GetDate())
