
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_LINK]
(@StyleDetailFormID uniqueidentifier,
@StyleID uniqueidentifier,
@Comments nvarchar(2000),
@StyleSet int,
@CopyStyleID nvarchar(50),
@CopyStyleSet nvarchar(50),
@WorkflowID nvarchar(50))
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

		INSERT INTO pStyleDetailForm
		(StyleDetailFormMasterID, WorkflowID, StyleID, Comments, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort)
		SELECT @StyleDetailFormMasterID, @WorkflowID AS WorkflowID, @StyleID AS StyleID, @Comments as Comments, @StyleSet AS StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort
		FROM  pStyleDetailForm WITH (NOLOCK)
		WHERE     (StyleID = @CopyStyleID) AND (StyleSet = @CopyStyleSet) AND (StyleDetailFormID = @StyleDetailFormID)

		SET @RowCounter = @RowCounter + 1
	END

DROP TABLE #tempTable


