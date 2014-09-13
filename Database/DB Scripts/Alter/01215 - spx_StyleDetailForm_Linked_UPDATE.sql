IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailForm_Linked_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDetailForm_Linked_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_Linked_UPDATE](
	@ImageID nvarchar(50),
	@ImageVersion nvarchar(50),
	@ModifiedBy nvarchar(50),
	@ModifiedDate nvarchar(50),
	@StyleDetailFormID uniqueidentifier
)

AS 

DECLARE @SessionItemTempID UNIQUEIDENTIFIER 
SET @SessionItemTempID = NEWID()


/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleDetailFormID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.

DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @StyleSet INT
DECLARE @StyleLinkID UNIQUEIDENTIFIER

DECLARE @ImageVersion_Previous INT

DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************************************/
/*Save a copy of the original parameter values.	*/
/************************************************/
SET @StyleDetailFormID_Param = @StyleDetailFormID


/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE dbo.#temp_Linked
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
	,StyleSet INT
	,StyleImageItemID UNIQUEIDENTIFIER
	)  ON [PRIMARY]



/****************************************************/
/*Check to see if the Style is Multi-Cloth linked.	*/
/****************************************************/
/*Get the 'StyleID' and 'StyleSet' of the calling Style.*/
SELECT @StyleID = StyleID
	,@StyleSet = StyleSet
FROM pStyleImageItem
WHERE StyleImageItemID = @StyleDetailFormID_Param


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
		EXEC spx_StyleDetailForm_UPDATE
			@ImageID = @ImageID,
			@ImageVersion = @ImageVersion,
			@ModifiedBy = @ModifiedBy,
			@ModifiedDate = @ModifiedDate,
			@StyleDetailFormID = @StyleDetailFormID_Param,
			@SessionItemTempID = NULL
			
	END
ELSE	--Style is Multi-Cloth linked.
	BEGIN
		/*Clear variables.*/
		SET @ImageVersion_Previous = NULL


		/*Get the old 'ImageVersion' value of the calling Style.*/
		SELECT @ImageVersion_Previous = ImageVersion
		FROM pStyleImageItem
		WHERE StyleImageItemID = @StyleDetailFormID_Param


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


		/*Get the 'StyleImageItemID' of the Image for each of the Multi-Cloth linked Styles.*/
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				/*Clear variables.*/
				SET @StyleID = NULL
				SET @StyleSet = NULL
				SET @StyleDetailFormID = NULL


				/*Get 'StyleID'.*/
				SELECT @StyleID = StyleID
					,@StyleSet = StyleSet
				FROM #temp_Linked
				WHERE TableRow = @RowCounter


				/*Get the 'StyleImageItemID'.*/
				SELECT @StyleDetailFormID = StyleImageItemID
				FROM pStyleImageItem
				WHERE StyleID = @StyleID
					AND StyleSet = @StyleSet
					AND ImageID = @ImageID
					AND ImageVersion = @ImageVersion_Previous


				/*Update the temp table with the 'StyleImageItemID'.*/
				UPDATE #temp_Linked
				SET StyleImageItemID = @StyleDetailFormID
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
		SET @StyleDetailFormID = NULL


		/*Get the 'StyleID' for the delete.*/
		SELECT @StyleDetailFormID = StyleImageItemID
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		/*Execute the original procedure for another Style.*/
		EXEC spx_StyleDetailForm_UPDATE
			@ImageID = @ImageID,
			@ImageVersion = @ImageVersion,
			@ModifiedBy = @ModifiedBy,
			@ModifiedDate = @ModifiedDate,
			@StyleDetailFormID = @StyleDetailFormID,
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
VALUES ('DB_Version', '4.0.0000', '01215', GetDate())
GO