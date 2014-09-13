/****** Object:  StoredProcedure [dbo].[spx_StyleCADModelFabricTypeSeparated_SELECT]    Script Date: 03/13/2012 13:54:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCADModelFabricTypeSeparated_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCADModelFabricTypeSeparated_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleCADModelFabricTypeSeparated_SELECT]    Script Date: 03/13/2012 13:54:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCADModelFabricTypeSeparated_SELECT]
	@StyleId UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ModelId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	CREATE TABLE #tmpFabricTypes (
		ROW INT IDENTITY(1, 1),
		FabricType NVARCHAR(200),
		ModelName NVARCHAR(200),
		ModelID UNIQUEIDENTIFIER
	)

	IF @ModelId IS NULL
	BEGIN
		-- get fabric types from all style models
		INSERT INTO #tmpFabricTypes(FabricType, ModelName, ModelID)
		SELECT DISTINCT p.Piece_Image_Name as FabricType, m.Model_Name as ModelName, p.ModelID
		FROM pBodyPatternSheetPiece p
			LEFT JOIN pBodyPatternSheetModel m ON p.ModelID = m.ID 	
		WHERE m.StyleID = @StyleId AND m.StyleSet = @StyleSet
			AND m.Active = 1 AND p.Active = 1
			AND p.Piece_Image_Name <> 'N/A'
		ORDER BY m.Model_Name
	END
	ELSE
	BEGIN
		-- get fabric types for one specific model
		INSERT INTO #tmpFabricTypes(FabricType, ModelName, ModelID)
		SELECT DISTINCT p.Piece_Image_Name as FabricType, m.Model_Name as ModelName, p.ModelID
		FROM pBodyPatternSheetPiece p
			LEFT JOIN pBodyPatternSheetModel m ON p.ModelID = m.ID 	
		WHERE m.StyleID = @StyleId AND m.StyleSet = @StyleSet
			AND m.Active = 1 AND p.Active = 1
			AND p.Piece_Image_Name <> 'N/A'
			AND m.ID = @ModelId
		ORDER BY m.Model_Name
	END
	
	DECLARE @ROW INT = 1,
			@TOTAL INT;			
	SELECT @TOTAL = COUNT(*) FROM #tmpFabricTypes
	
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @FabricType NVARCHAR(200),
				@Length INT,
				@Pos INT = 1,
				@SingularType NVARCHAR(1);
				
		SELECT @FabricType = FabricType, @Length = LEN(FabricType) FROM #tmpFabricTypes WHERE ROW = @ROW
		
		IF @Length > 1
		BEGIN
			WHILE @Pos <= @Length
			BEGIN
				SET @SingularType = SUBSTRING(@FabricType, @Pos, 1)
				
				-- insert separeted fabric type
				INSERT INTO #tmpFabricTypes(FabricType, ModelName, ModelID)
				SELECT @SingularType, ModelName, ModelID
				FROM #tmpFabricTypes WHERE ROW = @ROW
				
				SET @Pos = @Pos + 1
			END			
		END
		
		SET @ROW = @ROW + 1
	END
	
	-- remove all compound fabric types (they were previously separated)
	DELETE FROM #tmpFabricTypes WHERE LEN(FabricType) > 1
	
	SELECT DISTINCT FabricType, ModelID, ModelName FROM #tmpFabricTypes ORDER BY ModelName, FabricType
	
	DROP TABLE #tmpFabricTypes
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03220'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03220', GetDate())

END

GO 