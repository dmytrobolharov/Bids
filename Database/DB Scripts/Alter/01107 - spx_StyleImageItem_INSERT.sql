IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageItem_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleImageItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleImageItem_INSERT](
	@StyleImageItemID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion INT,
	@CreatedBy NVARCHAR(100),
	@CreatedDate DATETIME,
	@SessionItemTempID UNIQUEIDENTIFIER
)
AS 

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleImageItemID UNIQUEIDENTIFIER NULL,
	StyleDevelopmentItemID UNIQUEIDENTIFIER NULL,
	StyleDevelopmentID	UNIQUEIDENTIFIER NULL,
	StyleID UNIQUEIDENTIFIER NULL,
	SizeRange NVARCHAR(50) NULL,
	Variation INT NULL,
	StyleNonApparel INT,
	StyleLinkID UNIQUEIDENTIFIER
)

DECLARE @RowStyleLoop 			INT
DECLARE @RowStyleCount 			INT
DECLARE @tmpStyleID				UNIQUEIDENTIFIER
DECLARE @StyleImageItemMasterID UNIQUEIDENTIFIER
DECLARE @tmpStyleImageItemID	UNIQUEIDENTIFIER
DECLARE @tmpStyleVariation		INT

DECLARE @StyleNonApparel INT,
		@StyleLinkID UNIQUEIDENTIFIER,
		@StyleImageItemLinkID UNIQUEIDENTIFIER

SET @StyleImageItemMasterID = NEWID()

DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

BEGIN
	INSERT INTO #tempStyleDevelopmentItem
		(StyleImageItemID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation,
		StyleNonApparel, StyleLinkID )
	SELECT @StyleImageItemID, a.StyleDevelopmentItemID, a.StyleDevelopmentID, a.StyleID, a.SizeRange, a.Variation, 
		c.StyleNonApparel, b.StyleLinkID 
	FROM pStyleDevelopmentItem a WITH (NOLOCK) 
		INNER JOIN dbo.pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID
		INNER JOIN pStyleType c  WITH (NOLOCK) ON b.StyleType = c.StyleTypeID
	WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
END

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

DECLARE @Change  INT
SET @Change   = 0 

WHILE @RowStyleLoop <= @RowStyleCount 
BEGIN

	SELECT @tmpStyleImageItemID = StyleImageItemID, @tmpStyleID = StyleID,
	@StyleNonApparel = StyleNonApparel, @StyleLinkID = StyleLinkID 
	FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop
	
	SET @StyleImageItemLinkID = NULL 
	
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
		

	IF @StyleId = @tmpStyleId
	BEGIN
		INSERT INTO pStyleImageItem
		(StyleImageItemID, StyleImageItemMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, 
			CUser, CDate, MUser, MDate, StyleImageLinked, SessionItemTempID, StyleImageItemLinkID )
		VALUES (@StyleImageItemID, @StyleImageItemMasterID, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion, 
			@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @SessionItemTempID, @StyleImageItemLinkID)

		SET  @Change = 1
	END
	ELSE
	BEGIN
		INSERT INTO pStyleImageItem
		(StyleImageItemID, StyleImageItemMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, 
			CUser, CDate, MUser, MDate, StyleImageLinked,  SessionItemTempID, StyleImageItemLinkID )
		VALUES (NEWID(), @StyleImageItemMasterID, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion, 
			@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1,  @SessionItemTempID, @StyleImageItemLinkID )

		SET  @Change = 1

	END	

	SET @RowStyleLoop = @RowStyleLoop + 1
	
END


IF @Change = 1 
BEGIN 

	UPDATE pStyleWorkflow
	SET MUser  = @CreatedBy , MDate = @CreatedDate 
	WHERE StyleID = @StyleID AND StyleSet = @StyleSet
	AND  WorkflowID = @WorkflowID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01107', GetDate())
