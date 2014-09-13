-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_StyleDetailForm_Linked_INSERT]
(
	@StyleDetailFormID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@ImageID uniqueidentifier,
	@ImageVersion int,
	@CreatedBy nvarchar(100),
	@CreatedDate datetime
)

AS 


/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleDetailFormID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.
DECLARE @StyleID_Param UNIQUEIDENTIFIER					--Keep a copy of the original parameter value.
DECLARE @StyleSet_Param INT								--Keep a copy of the original parameter value.


DECLARE @StyleLinkID UNIQUEIDENTIFIER

DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************************************/
/*Save a copy of the original parameter values.	*/
/************************************************/
SET @StyleDetailFormID_Param = @StyleDetailFormID
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
	,StyleDetailFormID UNIQUEIDENTIFIER
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
		EXEC spx_StyleDetailForm_INSERT
			@StyleDetailFormID_Param
			,@WorkflowID
			,@StyleID_Param
			,@StyleSet_Param
			,@ImageID
			,@ImageVersion
			,@CreatedBy
			,@CreatedDate
	END
ELSE	--Style is Multi-Cloth linked.
	BEGIN
		/*Put a copy of the original Style in the temp table first.*/
		INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet
			,StyleDetailFormID)
		SELECT
			@StyleID_Param AS StyleID
			,@StyleLinkID
			,@StyleSet_Param AS StyleSet
			,@StyleDetailFormID_Param AS StyleDetailFormID


		/*Get the other Styles that are Multi-Cloth linked to this one.*/
		INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet
			,StyleDetailFormID)
		SELECT
			StyleID
			,StyleLinkID
			,@StyleSet_Param AS StyleSet
			,NEWID() AS StyleDetailFormID
		FROM pStyleHeader
		WHERE StyleLinkID = @StyleLinkID
			AND StyleID <> @StyleID_Param
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
		SET @StyleID = NULL
		SET @StyleSet = NULL


		/*Get the 'StyleID' for the insert.*/
		SELECT @StyleDetailFormID = StyleDetailFormID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		/*Execute the original procedure for another Style.*/
		EXEC spx_StyleDetailForm_INSERT
			@StyleDetailFormID
			,@WorkflowID
			,@StyleID
			,@StyleSet
			,@ImageID
			,@ImageVersion
			,@CreatedBy
			,@CreatedDate


		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_Linked


