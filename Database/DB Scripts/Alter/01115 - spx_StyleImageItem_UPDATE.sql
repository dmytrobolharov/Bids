IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageItem_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleImageItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleImageItem_UPDATE](
	@ImageID NVARCHAR(50),
	@ImageVersion NVARCHAR(50),
	@ModifiedBy NVARCHAR(50),
	@ModifiedDate NVARCHAR(50),
	@StyleImageItemID UNIQUEIDENTIFIER,
	@SessionItemTempID	UNIQUEIDENTIFIER = NULL
)
AS 

/*
Comments:

#01 - Ryan Cabanas - 6/5/08

When an image was linked and you changed the version of that image on one Size Class, the image version on the other
Size Class wasn't getting updated.  We solved this by modifying the WHERE condition to the following:

	WHERE (StyleImageItemMasterID = @StyleImageItemMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet)

It used to be this:

	WHERE (StyleImageItemID = @StyleImageItemID)

This solved the problem.



*/




CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						INT IDENTITY(1,1)  NOT NULL,
	[StyleImageItemMasterID]	UNIQUEIDENTIFIER NULL,
	[StyleDevelopmentItemID]	UNIQUEIDENTIFIER NULL,
	[StyleDevelopmentID]    	UNIQUEIDENTIFIER NULL,
	[StyleID]               	UNIQUEIDENTIFIER NULL,
	[SizeRange]             	NVARCHAR(50) NULL,
	[Variation]             	INT NULL,
	[CUser]                 	NVARCHAR(200) NULL,
	[CDate]                 	DATETIME NULL,
	[MUser]                 	NVARCHAR(200) NULL,
	[MDate]                 	DATETIME NULL,
	StyleNonApparel INT,
	StyleLinkID UNIQUEIDENTIFIER
)

DECLARE 
	@WorkflowId				UNIQUEIDENTIFIER,
	@StyleId				UNIQUEIDENTIFIER,
	@StyleSet				INT,
	@RowStyleLoop 			INT,
	@RowStyleCount 			INT,
	@tmpStyleID				UNIQUEIDENTIFIER,
	@StyleImageItemMasterID UNIQUEIDENTIFIER,
	@tmpStyleImageItemID	UNIQUEIDENTIFIER,
	@tmpStyleVariation		INT

DECLARE 
	@StyleNonApparel INT,
	@StyleLinkID UNIQUEIDENTIFIER,
	@StyleImageItemLinkID UNIQUEIDENTIFIER


SELECT @WorkflowId = WorkflowId, @StyleId = StyleId, @StyleSet = StyleSet, @StyleImageItemMasterID = StyleImageItemMasterID FROM pStyleImageItem WITH (NOLOCK) WHERE StyleImageItemID = @StyleImageItemID

--SELECT @StyleImageItemMasterID

IF @StyleImageItemMasterID IS NULL
BEGIN
	SET @StyleImageItemMasterID = NEWID()	
	UPDATE  pStyleImageItem
	SET  StyleImageItemMasterID = @StyleImageItemMasterID 
	WHERE (StyleImageItemID = @StyleImageItemID)
--SELECT @StyleImageItemMasterID
END

DECLARE @StyleImageLinked INT
SELECT @StyleImageLinked = StyleImageLinked FROM pStyleImageItem WITH (NOLOCK) WHERE (StyleImageItemID = @StyleImageItemID)

IF @StyleImageLinked = 0
	BEGIN
			UPDATE  pStyleImageItem
			SET  StyleImageItemMasterID = @StyleImageItemMasterID, ImageID = @ImageID, ImageVersion = @ImageVersion, MUser = @ModifiedBy, MDate = @ModifiedDate
			WHERE     (StyleImageItemID = @StyleImageItemID)
	END
ELSE
	BEGIN
	DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER
	SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId 
	FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

	BEGIN
		INSERT INTO #tempStyleDevelopmentItem (
			StyleImageItemMasterID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, 
			SizeRange, Variation, StyleNonApparel, StyleLinkID )
		SELECT @StyleImageItemMasterID, a.StyleDevelopmentItemID, a.StyleDevelopmentID, a.StyleID, 
			a.SizeRange, a.Variation, c.StyleNonApparel, b.StyleLinkID 
		FROM pStyleDevelopmentItem a WITH(NOLOCK) 
			INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID
			INNER JOIN dbo.pStyleType c WITH(NOLOCK) ON  c.StyleTypeID =  b.StyleType
		WHERE a.StyleDevelopmentID = @StyleDevelopmentId AND a.Variation = @tmpStyleVariation
	END

	SELECT * FROM #tempStyleDevelopmentItem

	SET @RowStyleLoop = 1
	SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

	WHILE @RowStyleLoop <= @RowStyleCount 
	BEGIN

		SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

		IF NOT EXISTS (SELECT COUNT(*) FROM pStyleImageItem WITH (NOLOCK) WHERE StyleImageItemMasterID = @StyleImageItemMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet)
		BEGIN
		
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
		
			INSERT INTO pStyleImageItem (
				StyleImageItemID, StyleImageItemMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, 
				CUser, CDate, MUser, MDate, SessionItemTempID, StyleImageItemLinkID )
			VALUES (NEWID(), @StyleImageItemMasterID, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion, 
				@ModifiedBy, @ModifiedDate, @ModifiedBy, @ModifiedDate, @SessionItemTempID, @StyleImageItemLinkID )
			--SELECT 'INSERT'
		END
		ELSE
		BEGIN
			UPDATE  pStyleImageItem
			SET  StyleImageItemMasterID = @StyleImageItemMasterID, ImageID = @ImageID, ImageVersion = @ImageVersion, MUser = @ModifiedBy, MDate = @ModifiedDate
			WHERE (StyleImageItemMasterID = @StyleImageItemMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet)	--#01
			--SELECT 'UPDATE'
		END	

		SET @RowStyleLoop = @RowStyleLoop + 1
		
	END
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01115', GetDate())
GO



