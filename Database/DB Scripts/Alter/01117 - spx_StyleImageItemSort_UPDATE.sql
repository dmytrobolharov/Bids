IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageItemSort_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleImageItemSort_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleImageItemSort_UPDATE](
	@StyleImageItemID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@TeamID  UNIQUEIDENTIFIER, 
	@Sort NVARCHAR(10)
)
AS 


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


IF @StyleImageItemMasterID IS NULL
BEGIN
	SET @StyleImageItemMasterID = NEWID()	
	UPDATE  pStyleImageItem
	SET  StyleImageItemMasterID = @StyleImageItemMasterID 
	WHERE (StyleImageItemID = @StyleImageItemID)
END

DECLARE @StyleImageLinked INT

SELECT @StyleImageLinked = StyleImageLinked 
FROM pStyleImageItem WITH (NOLOCK) WHERE StyleImageItemID = @StyleImageItemID

IF @StyleImageLinked = 0
	BEGIN
			UPDATE  pStyleImageItem
			SET  StyleImageItemMasterID = @StyleImageItemMasterID,	
			MUser = @MUser, MDate = @MDate,
			Sort = @Sort
			WHERE StyleImageItemID = @StyleImageItemID
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
	
	SET @RowStyleLoop = 1
	SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

	WHILE @RowStyleLoop <= @RowStyleCount 
	BEGIN

		SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

		UPDATE  pStyleImageItem
		SET  StyleImageItemMasterID = @StyleImageItemMasterID, 
			MUser = @MUser, MDate = @MDate, Sort = @Sort
		WHERE (StyleImageItemMasterID = @StyleImageItemMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet)	

		SET @RowStyleLoop = @RowStyleLoop + 1
		
	END
END

go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01117', GetDate())
GO


