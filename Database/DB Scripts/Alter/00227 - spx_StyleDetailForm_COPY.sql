
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_COPY]
(@StyleDetailFormID uniqueidentifier,
@WorkflowID uniqueidentifier,
@StyleID uniqueidentifier,
@Comments nvarchar(2000),
@StyleSet int,
@ImageID uniqueidentifier,
@ImageVersion int,
@CreatedBy nvarchar(100),
@CreatedDate datetime,
@CopyStyleID uniqueidentifier,
@CopyStyleSet int)
AS 

DECLARE @StyleMasterID nvarchar(50)
DECLARE @StyleDetailFormMasterID nvarchar(50)
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
SET @StyleDetailFormMasterID = newid()

WHILE (@RowCounter <= @TableRows)
	BEGIN
		SELECT @StyleID = StyleID
		FROM #tempTable
		WHERE TableRow = @RowCounter

		INSERT INTO dbo.pStyleDetailForm
		(StyleDetailFormMasterID, WorkflowID, StyleID, Comments, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort)
		SELECT @StyleDetailFormMasterID, @WorkflowID AS WorkflowID, @StyleID AS StyleID, @Comments AS Comments, @StyleSet AS StyleSet, @ImageID AS ImageID, @ImageVersion AS ImageVersion, 
		@CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, Sort
		FROM dbo.pStyleDetailForm WITH (NOLOCK)
		WHERE (StyleID = @CopyStyleID) AND (StyleSet = @CopyStyleSet) AND (StyleDetailFormID = StyleDetailFormID)

		SET @RowCounter = @RowCounter + 1
	END

DROP TABLE #tempTable

