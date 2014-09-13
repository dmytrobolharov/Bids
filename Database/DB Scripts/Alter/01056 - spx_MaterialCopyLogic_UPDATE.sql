
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCopyLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCopyLogic_UPDATE]
GO

CREATE PROCEDURE dbo.spx_MaterialCopyLogic_UPDATE(
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialCopyFromID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@TeamID UNIQUEIDENTIFIER
)
AS 


--** Buberry logic 
--EXECUTE spx_Material_MaterialCode_UPDATE 
--@MaterialID = @MaterialID,
--@MaterialCodeLength = 10 
--@MaterialCodeLogic = 'CHAR'



--*** Copy SeasonYear/colors information 
CREATE TABLE #srcSY(
	ROWID INT IDENTITY (1,1),
	SeasonYearID  UNIQUEIDENTIFIER,
	MaterialSeason NVARCHAR(200),
	MaterialYear NVARCHAR(200)
)

INSERT INTO #srcSY ( SeasonYearID, MaterialSeason, MaterialYear )
SELECT a.SeasonYearID, b.Season, b.Year
FROM dbo.pMaterialSeasonYear a WITH(NOLOCK)
	INNER JOIN dbo.pSeasonYear b WITH(NOLOCK) ON a.SeasonYearID = b.SeasonYearID
WHERE a.MaterialID = @MaterialCopyFromID 


DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialSeason NVARCHAR(200),
	@MaterialYear NVARCHAR(200)
	
SET @ROWID =  1 	
SELECT @TOTAL = COUNT(*) FROM #srcSY 

WHILE @ROWID <= @TOTAL
BEGIN 

	SELECT @SeasonYearID  = SeasonYearID, @MaterialSeason  = MaterialSeason, @MaterialYear = MaterialYear
	FROM #srcSY WHERE ROWID = @ROWID	

	IF EXISTS ( SELECT * FROM dbo.pMaterialSeasonYear WITH(NOLOCK)
		WHERE SeasonYearID = @SeasonYearID AND MaterialID = @MaterialID
	)
	BEGIN
	
		INSERT INTO pMaterialColorSeasonYear  (MaterialColorSeasonYearID , MaterialColorID, MaterialID, SeasonYearID, MaterialSeason, 
			MaterialYear, CUser, CDate, Muser, MDate )
		SELECT NEWID(), b.MaterialColorID, @MaterialID, @SeasonYearID, @MaterialSeason,
			@MaterialYear, @MUser, @MDate, @MUser, @MDate 
		FROM  (
			SELECT b.ColorPaletteID 
			FROM  dbo.pMaterialColorSeasonYear a
				INNER JOIN dbo.pMaterialColor b ON a.MaterialColorID = b.MaterialColorID
			WHERE a.MaterialID = @MaterialCopyFromID
			AND a.SeasonYearID = @SeasonYearID
		) AS foo 
			INNER JOIN dbo.pMaterialColor b  ON foo.ColorPaletteID =  b.ColorPaletteID 
		WHERE b.MaterialID = @MaterialID 
	
	END 
	SET @ROWID = @ROWID + 1
END 


DROP TABLE #srcSY

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01056', GetDate())
GO