IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageItem_COPY]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleImageItem_COPY]
GO


CREATE PROCEDURE [dbo].[spx_StyleImageItem_COPY](
	@StyleImageItemID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@ImageID uniqueidentifier,
	@ImageVersion int,
	@CreatedBy nvarchar(100),
	@CreatedDate datetime,
	@CopyStyleID uniqueidentifier,
	@CopyStyleSet INT,
	@SessionItemTempID UNIQUEIDENTIFIER
)
AS


CREATE TABLE [#tempStyleDesign] ( 
	RecID						INT IDENTITY(1,1)  NOT NULL,
	StyleDesignDetailID		UNIQUEIDENTIFIER NULL,
	StyleDesignMasterID		UNIQUEIDENTIFIER NULL,
	StyleID               	UNIQUEIDENTIFIER NULL,
	CUser                 	NVARCHAR(200) NULL,
	CDate                 	DATETIME NULL,
	StyleLinkID				UNIQUEIDENTIFIER,
	StyleNonApparel			INT
)

DECLARE 
	@RowStyleLoop 			INT,
	@RowStyleCount 			INT,
	@tmpStyleID				UNIQUEIDENTIFIER,
	@tmpStyleVariation		INT,
	@StyleDesignMasterID UNIQUEIDENTIFIER,
	@StyleDevelopmentId	UNIQUEIDENTIFIER,
	@tmpStyleDesignDetailID UNIQUEIDENTIFIER, 
	@StyleNonApparel INT,
	@StyleLinkID UNIQUEIDENTIFIER,
	@StyleImageItemLinkID UNIQUEIDENTIFIER,
	@StyleImageItemMasterID UNIQUEIDENTIFIER

	SET @StyleDesignMasterID = NEWID()

	SELECT @tmpStyleVariation = a.Variation, @StyleDevelopmentId = a.StyleDevelopmentId 
	FROM pStyleDevelopmentItem a WITH (NOLOCK) 
		INNER JOIN dbo.pStyleHeader b WITH (NOLOCK) ON  a.StyleID = b.StyleID
		INNER JOIN dbo.pStyleType c WITH(NOLOCK) ON c.StyleTypeID = b.StyleType
	WHERE a.StyleId = @StyleID


	INSERT INTO #tempStyleDesign( StyleDesignMasterID, StyleID, StyleDesignDetailID,
		StyleLinkID, StyleNonApparel)
	SELECT @StyleDesignMasterID, a.StyleID, NEWID(), 
		b.StyleLinkID, c.StyleNonApparel
	FROM pStyleDevelopmentItem a WITH (NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID
		INNER JOIN dbo.pStyleType c WITH(NOLOCK) ON b.StyleType = c.StyleTypeID
	WHERE a.StyleDevelopmentID = @StyleDevelopmentId AND a.Variation = @tmpStyleVariation


SET @StyleImageItemMasterID = NEWID()
SET @RowStyleLoop = 1
SELECT @RowStyleCount = COUNT(*) FROM #tempStyleDesign

WHILE @RowStyleLoop <= @RowStyleCount 
BEGIN

	SELECT @tmpStyleID = StyleID, @tmpStyleDesignDetailID = StyleDesignDetailID, 
		@StyleNonApparel = StyleNonApparel, @StyleLinkID = StyleLinkID
	FROM #tempStyleDesign WHERE RecID = @RowStyleLoop


	--** APPAREL AND LINKED STYLE
	IF @StyleNonApparel = 0 AND @StyleLinkID IS NOT NULL 
	BEGIN
		SELECT TOP 1 @StyleImageItemLinkID = a.StyleImageItemLinkID 
		FROM dbo.pStyleImageItem a
			INNER JOIN dbo.pStyleHeader b ON a.StyleID =  b.StyleID 
		WHERE b.StyleLinkID = @StyleLinkID AND a.SessionItemTempID = @SessionItemTempID
		
		IF @StyleImageItemLinkID IS NULL
			SET @StyleImageItemLinkID =  NEWID()
	END 

	INSERT INTO dbo.pStyleImageItem
	(StyleImageItemMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate ,
		SessionItemTempID,StyleImageItemLinkID	)
	VALUES (@StyleImageItemMasterID,@WorkflowID , @tmpStyleID,@StyleSet, @ImageID, @ImageVersion,@CreatedBy,@CreatedDate, @CreatedBy,@CreatedDate,
		@SessionItemTempID, @StyleImageItemLinkID )
		
	SET @RowStyleLoop = @RowStyleLoop + 1

END 

DROP TABLE #tempStyleDesign	

/*
DECLARE @StyleMasterID nvarchar(50)
DECLARE @StyleImageItemMasterID nvarchar(50)
DECLARE @TableRows int
DECLARE @RowCounter int

CREATE TABLE #tempTable
(
	TableRow int identity(1, 1),
	StyleID nvarchar(50)
)

SELECT @StyleMasterID = StyleMasterID
FROM pStyleHeader WITH (NOLOCK)
WHERE StyleID = @StyleID

INSERT INTO #tempTable (StyleID)
SELECT StyleID
FROM pStyleHeader WITH (NOLOCK)
WHERE StyleMasterID = @StyleMasterID

SELECT @TableRows = COUNT(*)
FROM #tempTable

SET @RowCounter = 1
SET @StyleImageItemMasterID = newid()

WHILE (@RowCounter <= @TableRows)
	BEGIN
		SELECT @StyleID = StyleID
		FROM #tempTable
		WHERE TableRow = @RowCounter

		INSERT INTO dbo.pStyleImageItem
		(StyleImageItemMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort)
		SELECT @StyleImageItemMasterID, @WorkflowID AS WorkflowID, @StyleID AS StyleID, @StyleSet AS StyleSet, @ImageID AS ImageID, 
			@ImageVersion AS ImageVersion, @CreatedBy AS CUser, 
			@CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, Sort
		FROM dbo.pStyleImageItem WITH (NOLOCK)
		WHERE (StyleID = @CopyStyleID) AND (StyleSet = @CopyStyleSet) AND (StyleImageItemID = @StyleImageItemID)

		SET @RowCounter = @RowCounter + 1
	END

DROP TABLE #tempTable


*/
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01106', GetDate())
GO