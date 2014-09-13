IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_LinePlanColor_Linked_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_Linked_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorway_LinePlanColor_Linked_INSERT](
@ColorPaletteID UNIQUEIDENTIFIER, 
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@SeasonYearID UNIQUEIDENTIFIER,
@AllSizeClasses INT,
@CUser NVARCHAR(200), 
@CDate DATETIME,
@ChangeTransUserID UNIQUEIDENTIFIER,
@ChangeTransID UNIQUEIDENTIFIER
)
AS


--***********************
--*Declare variables.	
--************************
DECLARE @StyleID_Param UNIQUEIDENTIFIER			--Keep a copy of the original parameter value.
DECLARE @StyleSet_Param INT						--Keep a copy of the original parameter value.
DECLARE @StyleLinkID UNIQUEIDENTIFIER
DECLARE @TotalCount INT
DECLARE @RowCounter INT


--************************************************
--**Save a copy of the original parameter values.	
--************************************************
SET @StyleID_Param = @StyleID
SET @StyleSet_Param = @StyleSet


--***********************
--**Create temp table. 
--***********************
CREATE TABLE #temp_Linked (
TableRow int NOT NULL IDENTITY (1, 1),
StyleID UNIQUEIDENTIFIER, 
StyleLinkID UNIQUEIDENTIFIER,
StyleSet INT
)  

--****************************************************
--**Check to see if the Style is Multi-Cloth linked.	
--***************************************************
--Get the 'StyleLinkID' of the calling Style.

SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader WITH (NOLOCK) 
WHERE StyleID = @StyleID_Param

IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000')	--Style is not Multi-Cloth linked.
BEGIN
	INSERT INTO #temp_Linked( StyleID, StyleLinkID, StyleSet)
	VALUES( @StyleID, NULL,  @StyleSet ) 
END 
ELSE
BEGIN
	--*Get all the Styles that are Multi-Cloth linked to this 'StyleLinkID'.
	INSERT INTO #temp_Linked(StyleID, StyleLinkID, StyleSet)
	SELECT StyleID, StyleLinkID, @StyleSet_Param AS StyleSet
	FROM pStyleHeader WITH (NOLOCK)
	WHERE StyleLinkID = @StyleLinkID
END 

--********************************************************************
--*Loop through the records to update all Multi-Cloth linked Styles.	
--********************************************************************
--Get and set the counts for the Multi-Cloth linked Styles.
SELECT @TotalCount = COUNT(*) FROM #temp_Linked
SET @RowCounter = 1


--*Get the 'StyleID' for each of the Multi-Cloth linked Styles to add the Colorway to.*/
WHILE(@RowCounter <= @TotalCount)
BEGIN
	--**Clear variables.
	SET @StyleID = NULL
	SET @StyleSet = NULL

	--*Get the 'StyleID' for the insert.
	SELECT @StyleID = StyleID ,@StyleSet = StyleSet
	FROM #temp_Linked
	WHERE TableRow = @RowCounter

	--*Execute the original procedure for another Style.
	EXEC dbo.spx_StyleColorway_LinePlanColor_INSERT
	@ColorPaletteID,@StyleID,@StyleSet,@SeasonYearID,@AllSizeClasses,@CUser,@CDate,
	@ChangeTransID, @ChangeTransUserID

	--Up row counter.
	SET @RowCounter = @RowCounter + 1
END


--********************
--*Drop temp tables.	
--*******************
DROP TABLE #temp_Linked



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '694', GetDate())
GO
