
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_UPDATE]
(@ImageID nvarchar(50),
@ImageVersion nvarchar(50),
@ModifiedBy nvarchar(50),
@ModifiedDate nvarchar(50),
@StyleDetailFormID uniqueidentifier)
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
)

DECLARE @WorkflowId				uniqueidentifier
DECLARE @StyleId				uniqueidentifier
DECLARE @StyleSet				int
DECLARE @RowStyleLoop 			int
DECLARE @RowStyleCount 			int
DECLARE @tmpStyleID				uniqueidentifier
DECLARE @StyleDetailFormMasterID uniqueidentifier
DECLARE @tmpStyleDetailFormID	uniqueidentifier
DECLARE @tmpStyleVariation		int

SELECT @WorkflowId = WorkflowId, @StyleId = StyleId, @StyleSet = StyleSet, @StyleDetailFormMasterID = StyleDetailFormMasterID FROM pStyleDetailForm WITH (NOLOCK) WHERE StyleDetailFormID = @StyleDetailFormID

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
	DECLARE @StyleDevelopmentId uniqueidentifier
	SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

	BEGIN
		INSERT INTO #tempStyleDevelopmentItem
			(StyleDetailFormMasterID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation)
		SELECT @StyleDetailFormMasterID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem WITH (NOLOCK) 
		WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
	END

	SELECT * FROM #tempStyleDevelopmentItem

	SET @RowStyleLoop = 1
	SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

	WHILE @RowStyleLoop <= @RowStyleCount 

	BEGIN

		SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

			IF (SELECT COUNT(*) FROM pStyleDetailForm WITH (NOLOCK) WHERE StyleDetailFormMasterID = @StyleDetailFormMasterID AND StyleId = @tmpStyleId AND StyleSet = @StyleSet) = 0
				BEGIN
					INSERT INTO pStyleDetailForm
					(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate)
					VALUES (newid(), @StyleDetailFormMasterID, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion, @ModifiedBy, @ModifiedDate, @ModifiedBy, @ModifiedDate)
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