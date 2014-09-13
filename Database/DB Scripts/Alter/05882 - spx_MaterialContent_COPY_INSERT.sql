/****** Object:  StoredProcedure [dbo].[spx_MaterialContent_COPY_INSERT]    Script Date: 06/18/2013 12:12:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContent_COPY_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialContent_COPY_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialContent_COPY_INSERT]    Script Date: 06/18/2013 12:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_MaterialContent_COPY_INSERT]
	@MasterMaterialID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO dbo.pMaterialContent( MaterialContentId, MaterialID ,  MaterialContentCode, MaterialContentPerc, MaterialContentName, MUser, MDate  ) 
	SELECT NEWID(), @MaterialID, MaterialContentCode, MaterialContentPerc, MaterialContentName, MUser, MDate
	FROM pMaterialContent
	WHERE MaterialId = @MasterMaterialID
	
	-- add season years
	SELECT IDENTITY(INT, 1, 1) as ROW, * 
	INTO #tmpMaterialSeasonYear FROM tmpMaterialSeasonYear
	WHERE MaterialID = @MasterMaterialID
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM #tmpMaterialSeasonYear);
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @SeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM #tmpMaterialSeasonYear WHERE ROW = @ROW),
				@MaterialSeasonYearID UNIQUEIDENTIFIER = NEWID();
				
		exec spx_MaterialSeasonYear_INSERT 
			@MaterialSeasonYearID = @MaterialSeasonYearID,
			@MaterialID = @MaterialID,
			@SeasonYearID = @SeasonYearID,
			@CUser = @CUser, 
			@CDate = @CDate
			
		exec spx_MaterialSeasonYear_Logic_INSERT 
			@MaterialSeasonYearID = @MaterialSeasonYearID,
			@CUser = @CUser, 
			@CDate = @CDate
			
		SET @ROW = @ROW + 1
	END
	DROP TABLE #tmpMaterialSeasonYear
	
	-- add colors
	INSERT INTO pMaterialColor (MaterialColorID, MaterialID,  ColorFolderID, ColorPaletteID, ColorCode, ColorName, ColorSource, 
		Hex, R, G, B, C, M,Y,K, H, S, L, LAB_L, LAB_A, LAB_B, CDate, CUser, MDate, MUser, MaterialColorVersion, ColorVersion)  
	SELECT  NEWID(), @MaterialID, cp.ColorFolderID, cp.ColorPaletteID, cp.ColorCode, cp.ColorName, cp.ColorSource, 
		Hex, R, G, B, C, M, Y, K, H, S, L ,LAB_L, LAB_A, LAB_B, @CDate, @CUser, @CDate, @CUser, 1, 0
	FROM tmpMaterialColor tmc
	INNER JOIN pColorPalette cp ON tmc.ColorPaletteID = cp.ColorPaletteID
	WHERE tmc.MaterialID = @MasterMaterialID
	

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05882', GetDate())
GO
