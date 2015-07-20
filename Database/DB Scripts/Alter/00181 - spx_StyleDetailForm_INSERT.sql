
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_INSERT]
(@StyleDetailFormID uniqueidentifier,
@WorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@ImageID uniqueidentifier,
@ImageVersion int,
@CreatedBy nvarchar(100),
@CreatedDate datetime)
AS 

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDetailFormID]	uniqueidentifier NULL,
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

DECLARE @RowStyleLoop 			int
DECLARE @RowStyleCount 			int
DECLARE @tmpStyleID				uniqueidentifier
DECLARE @StyleDetailFormMasterID uniqueidentifier
DECLARE @tmpStyleDetailFormID	uniqueidentifier
DECLARE @tmpStyleVariation		int

SET @StyleDetailFormMasterID = newid()

DECLARE @StyleDevelopmentId uniqueidentifier
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

BEGIN
	INSERT INTO #tempStyleDevelopmentItem
		(StyleDetailFormID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation)
	SELECT @StyleDetailFormID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem WITH (NOLOCK) 
	WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
END

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

DECLARE @Change  INT
SET @Change   = 0 

WHILE @RowStyleLoop <= @RowStyleCount 
BEGIN

	SELECT @tmpStyleDetailFormID = StyleDetailFormID, @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

		IF @StyleId = @tmpStyleId
			BEGIN
				INSERT INTO pStyleDetailForm
				(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked)
				VALUES (@StyleDetailFormID, @StyleDetailFormMasterID, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1)

				SET  @Change = 1
			END
		ELSE
			BEGIN
				INSERT INTO pStyleDetailForm
				(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked)
				VALUES (newid(), @StyleDetailFormMasterID, @WorkflowID, @tmpStyleID, @StyleSet, @ImageID, @ImageVersion, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1)

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