IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleModelImagesUpdate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE spx_StyleModelImagesUpdate_SELECT
GO

CREATE PROCEDURE spx_StyleModelImagesUpdate_SELECT
(
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT = 1
	, @CADDB NVARCHAR(50)
	, @Catalog NVARCHAR(50)
)
AS

BEGIN

	CREATE TABLE #ModelTmp 
	(
		ROWID INT IDENTITY(1, 1)
		, ModelID UNIQUEIDENTIFIER
		, ModelCode INT
	)

	INSERT INTO #ModelTmp (ModelID, ModelCode)
	SELECT ID, Model_Code
	FROM pBodyPatternSheetModel
	WHERE StyleID = @StyleID and IsLinked = 1


	DECLARE @TOTAL INT = (SELECT COUNT(*) FROM #ModelTmp)
	DECLARE @CUR INT = 1
	
	DECLARE @ModelID UNIQUEIDENTIFIER
	DECLARE @ModelCode INT

	WHILE @CUR <= @TOTAL 
	BEGIN
		SELECT @ModelCode = ModelCode, @ModelID = ModelID
		FROM #ModelTmp WHERE ROWID = @CUR
		
		EXECUTE spx_Body_Model_Piece_INSERT @ModelID, @StyleID, @StyleSet, @CADDB, @Catalog, @ModelCode
			
		SET @CUR = @CUR + 1
	END 	


	SELECT bpsp.ModelId, bpsp.ID, bpsp.Piece_Image_SN
	FROM pBodyPatternSheetPiece bpsp
		INNER JOIN #ModelTmp bpsm ON bpsp.ModelID = bpsm.ModelID

	DROP TABLE #ModelTmp

END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09162', GetDate())
GO
