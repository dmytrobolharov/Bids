IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailForm_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDetailForm_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_UPDATE]
(@ImageID nvarchar(50),
@ImageVersion nvarchar(50),
@ModifiedBy nvarchar(50),
@ModifiedDate nvarchar(50),
@StyleDetailFormID uniqueidentifier,
@SessionItemTempID	UNIQUEIDENTIFIER = NULL)
AS 

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDetailFormMasterID]	uniqueidentifier NULL,
	[StyleDevelopmentItemID]	uniqueidentifier NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
	[StyleID]               	uniqueidentifier NULL,
	[SizeRange]             	nvarchar(50) NULL,
	[Variation]             	int NULL,
	[CUser]                 	nvarchar(200) NULL,
	[CDate]                 	datetime NULL,
	[MUser]                 	nvarchar(200) NULL,
	[MDate]                 	datetime NULL,
	StyleNonApparel             int NULL,
	StyleLinkID                 uniqueidentifier NULL
)

DECLARE @WorkflowId				uniqueidentifier
DECLARE @WorkFlowItemId				uniqueidentifier
DECLARE @StyleId				uniqueidentifier
DECLARE @StyleSet				int
DECLARE @RowStyleLoop 			int
DECLARE @RowStyleCount 			int
DECLARE @tmpStyleID				uniqueidentifier
DECLARE @StyleDetailFormMasterID uniqueidentifier
DECLARE @tmpStyleDetailFormID	uniqueidentifier
DECLARE @tmpStyleVariation		int

DECLARE @StyleNonApparel INT
DECLARE	@StyleLinkID UNIQUEIDENTIFIER
DECLARE	@StyleDetailFormLinkID UNIQUEIDENTIFIER

SELECT @WorkflowId = WorkflowId, @WorkFlowItemId = WorkFlowItemId, @StyleId = StyleId, @StyleSet = StyleSet, @StyleDetailFormMasterID = StyleDetailFormMasterID FROM pStyleDetailForm WITH (NOLOCK) WHERE StyleDetailFormID = @StyleDetailFormID

--SELECT @StyleDetailFormMasterID

IF @StyleDetailFormMasterID IS NULL
BEGIN
	SET @StyleDetailFormMasterID = newid()	
	UPDATE  pStyleDetailForm
	SET  StyleDetailFormMasterID = @StyleDetailFormMasterID 
	WHERE (StyleDetailFormID = @StyleDetailFormID)
--SELECT @StyleDetailFormMasterID
END

DECLARE @StyleImageLinked int
SELECT @StyleImageLinked = StyleImageLinked FROM pStyleDetailForm WITH (NOLOCK) WHERE (StyleDetailFormID = @StyleDetailFormID)

IF @StyleImageLinked = 0
	BEGIN
			UPDATE  pStyleDetailForm
			SET  StyleDetailFormMasterID = @StyleDetailFormMasterID, ImageID = @ImageID, ImageVersion = @ImageVersion, MUser = @ModifiedBy, MDate = @ModifiedDate
			WHERE     (StyleDetailFormID = @StyleDetailFormID)
	END
ELSE
	BEGIN
	DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER
	SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId 
	FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

	BEGIN
		INSERT INTO #tempStyleDevelopmentItem (
			StyleDetailFormMasterID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, 
			SizeRange, Variation, StyleNonApparel, StyleLinkID )
		SELECT @StyleDetailFormMasterID, a.StyleDevelopmentItemID, a.StyleDevelopmentID, a.StyleID, 
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

		IF (SELECT COUNT(*) FROM pStyleDetailForm WITH (NOLOCK) WHERE StyleDetailFormMasterID = @StyleDetailFormMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet AND WorkflowId = @WorkflowId AND @WorkFlowItemId = WorkFlowItemId) = 0
		BEGIN
		
			SET @StyleDetailFormLinkID = NULL 
			
			--** APPAREL AND LINKED STYLE
			IF @StyleNonApparel = 0 AND @StyleLinkID IS NOT NULL 
			BEGIN
				SELECT TOP 1 @StyleDetailFormLinkID = a.StyleImageItemLinkID 
				FROM dbo.pStyleImageItem a
					INNER JOIN dbo.pStyleHeader b ON a.StyleID =  b.StyleID 
				WHERE b.StyleLinkID = @StyleLinkID AND a.SessionItemTempID = @SessionItemTempID
				
				IF @StyleDetailFormLinkID IS NULL
					SET @StyleDetailFormLinkID =  NEWID()
			END 

			INSERT INTO pStyleDetailForm (
				 StyleDetailFormID, StyleDetailFormMasterID, WorkFlowItemId, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion,
				 CUser, CDate, MUser, MDate, StyleDetailFormLinkID, SessionItemTempID)
			VALUES (newid(), @StyleDetailFormMasterID, @WorkFlowItemId, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion,
				 @ModifiedBy, @ModifiedDate, @ModifiedBy, @ModifiedDate, @StyleDetailFormLinkID, @SessionItemTempID)
			--SELECT 'INSERT'
		END
		ELSE
		BEGIN
			UPDATE  pStyleDetailForm
			SET  StyleDetailFormMasterID = @StyleDetailFormMasterID, ImageID = @ImageID, ImageVersion = @ImageVersion, MUser = @ModifiedBy, MDate = @ModifiedDate
			WHERE (StyleDetailFormMasterID = @StyleDetailFormMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet)	--#01
			--SELECT 'UPDATE'
		END	

		SET @RowStyleLoop = @RowStyleLoop + 1
		
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01214', GetDate())
GO