IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleDetailForm_INSERT') 
DROP PROCEDURE spx_StyleDetailForm_INSERT
GO
Create PROCEDURE [dbo].[spx_StyleDetailForm_INSERT]
	(@StyleDetailFormID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@ImageID uniqueidentifier,
	@ImageVersion int,
	@CreatedBy nvarchar(100),
	@CreatedDate datetime,
	@SessionItemTempID UNIQUEIDENTIFIER
	)
AS 

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
	[StyleDetailFormID]	uniqueidentifier NULL,
	StyleDevelopmentItemID UNIQUEIDENTIFIER NULL,
	StyleDevelopmentID	UNIQUEIDENTIFIER NULL,
	StyleID UNIQUEIDENTIFIER NULL,
	SizeRange NVARCHAR(50) NULL,
	Variation INT NULL,
	StyleNonApparel INT,
	StyleLinkID UNIQUEIDENTIFIER
)

DECLARE @RowStyleLoop 			int
DECLARE @RowStyleCount 			int
DECLARE @tmpStyleID				uniqueidentifier
DECLARE @StyleDetailFormMasterID uniqueidentifier
DECLARE @tmpStyleDetailFormID	uniqueidentifier
DECLARE @tmpStyleVariation		int

DECLARE @StyleNonApparel INT
DECLARE @StyleLinkID UNIQUEIDENTIFIER
DECLARE @StyleDetailFormLinkID UNIQUEIDENTIFIER

SET @StyleDetailFormMasterID = newid()

DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleId = @StyleId

BEGIN
	INSERT INTO #tempStyleDevelopmentItem
		(StyleDetailFormID, StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation,
		StyleNonApparel, StyleLinkID )
	SELECT @StyleDetailFormID, a.StyleDevelopmentItemID, a.StyleDevelopmentID, a.StyleID, a.SizeRange, a.Variation, 
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

	SELECT @tmpStyleDetailFormID = StyleDetailFormID, @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

	SET @StyleDetailFormLinkID = NULL 
	
	--** APPAREL AND LINKED STYLE
	IF @StyleNonApparel = 0 AND @StyleLinkID IS NOT NULL 
	BEGIN
		SELECT TOP 1 @StyleDetailFormLinkID = a.StyleDetailFormLinkID 
		FROM pStyleDetailForm a
			INNER JOIN dbo.pStyleHeader b ON a.StyleID =  b.StyleID 
		WHERE b.StyleLinkID = @StyleLinkID AND a.SessionItemTempID = @SessionItemTempID
		
		IF @StyleDetailFormLinkID IS NULL
			SET @StyleDetailFormLinkID =  NEWID()
	END 


		IF @StyleId = @tmpStyleId
			BEGIN
				INSERT INTO pStyleDetailForm
				(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, WorkFlowItemId, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID)
				VALUES (@StyleDetailFormID, @StyleDetailFormMasterID, @WorkflowID, @WorkflowItemID, @tmpStyleID, @StyleSet,
						 @ImageID, @ImageVersion, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @SessionItemTempID, @StyleDetailFormLinkID)

				SET  @Change = 1
			END
		ELSE
			BEGIN
				INSERT INTO pStyleDetailForm
				(StyleDetailFormID, StyleDetailFormMasterID, WorkflowID, WorkFlowItemId, StyleID, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID)
				VALUES (newid(), @StyleDetailFormMasterID, @WorkflowID, @WorkflowItemID, @tmpStyleID, @StyleSet, @ImageID,
						 @ImageVersion, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1, @SessionItemTempID, @StyleDetailFormLinkID)

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
VALUES     ('DB_Version', '4.1.0000', '01699', GetDate())
GO