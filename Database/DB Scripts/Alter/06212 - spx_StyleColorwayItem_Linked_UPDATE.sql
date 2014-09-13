IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayItem_Linked_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayItem_Linked_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleColorwayItem_Linked_UPDATE](
	@MaterialColorID uniqueidentifier,
	@StyleMaterialID uniqueidentifier = NULL,
	@StyleColorItemID uniqueidentifier = NULL,	
	@StyleID uniqueidentifier = NULL,
	@StyleSet int = 1,
	@SeasonYearID uniqueidentifier = NULL,
	@AllColor int = 0,
	@MUser nvarchar(200),
	@MDate datetime, 
	@AllSize INT = 0,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@ChangeManagementEnabled INT,
	@NoApplicableColor INT = 0
) 
AS

--************************
--*Declare variables.	
--************************
DECLARE @StyleMaterialID_Param UNIQUEIDENTIFIER			--Keep a copy of the original parameter value.
DECLARE @StyleColorItemID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.
DECLARE @StyleID_Param UNIQUEIDENTIFIER					--Keep a copy of the original parameter value.
DECLARE @StyleSet_Param INT								--Keep a copy of the original parameter value.
DECLARE @StyleLinkID UNIQUEIDENTIFIER
DECLARE @MainMaterial INT
DECLARE @StyleMaterialLinkID UNIQUEIDENTIFIER			--To find the the same Material in the other Styles.
DECLARE @ColorPaletteID UNIQUEIDENTIFIER				--To find the the same Colorway in the other Styles.

DECLARE @TotalCount INT
DECLARE @RowCounter INT



--***
--** Define the Transaction Log ID
--*** 
DECLARE @ChangeTransID UNIQUEIDENTIFIER

SET @ChangeTransID = NULL
	
IF @ChangeManagementEnabled = 1 
BEGIN 

	--** TechPack exists ? 
	IF EXISTS ( SELECT  * FROM dbo.pStyleHeader a
			INNER JOIN dbo.pTechPack b ON a.TechPackId =  b.TechPackID
			WHERE a.StyleID = @StyleID
	)
	BEGIN 
		SET @ChangeTransID = NEWID()
		INSERT INTO pChangeTransaction(
			ChangeTransID
			,ChangeTransPageName
			,ChangeTransTableID
			,ChangeTransTablePKID
			,ChangeTransUserID
			,ChangeTransDate)  
		VALUES(
			@ChangeTransID
			,@ChangeTransPageName,
			'00000001-C1CC-DF11-AF06-005056C00008'
			,@StyleID
			,@ChangeTransUserID
			,@MDate) 	
	END
END 



--***
--** Get Main ColorPaletteID from pStyleColorway 
--***
SELECT @ColorPaletteID = a.ColorPaletteID 
FROM pStyleColorway a WITH (NOLOCK) 
	INNER JOIN pStyleColorwayItem b WITH (NOLOCK) ON a.StyleColorID =  b.StyleColorID 
WHERE b.StyleColorItemID  = @StyleColorItemID


--************************************************
--*Save a copy of the original parameter values.	
--************************************************
SET @StyleMaterialID_Param = @StyleMaterialID
SET @StyleColorItemID_Param = @StyleColorItemID
SET @StyleID_Param = @StyleID
SET @StyleSet_Param = @StyleSet


--***********************
--*Create temp table.	
--************************
CREATE TABLE dbo.#temp_Linked(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
	,StyleSet INT
	,StyleMaterialID UNIQUEIDENTIFIER
	,StyleMaterialLinkID UNIQUEIDENTIFIER
	,StyleColorItemID UNIQUEIDENTIFIER
)  ON [PRIMARY]



--****************************************************
--*Check to see if the Style is Multi-Cloth linked.	
--****************************************************
--*Get the 'MainMaterial' value for checking later on.
SELECT @MainMaterial = MainMaterial
FROM pStyleMaterials WITH (NOLOCK) 
WHERE StyleMaterialID = @StyleMaterialID_Param


--*Get the 'StyleLinkID' of the calling Style.
SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader WITH (NOLOCK) 
WHERE StyleID = @StyleID

--********************************************************************
--*See if there are other Multi-Cloth linked Styles with this one.	
--********************************************************************
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000' OR @MainMaterial = 1)	--Style is not Multi-Cloth linked, or this is a Main Material.
BEGIN
	--*Execute original procedure with original parameters.
	EXEC spx_StyleColorwayItem_UPDATE
		@MaterialColorID = @MaterialColorID,
		@StyleMaterialID = @StyleMaterialID_Param,
		@StyleColorItemID = @StyleColorItemID_Param,
		@StyleID = @StyleID_Param,
		@StyleSet = @StyleSet_Param,
		@SeasonYearID = @SeasonYearID,
		@AllColor = @AllColor,
		@MUser = @MUser,
		@MDate = @MDate,
		@ChangeTransID = @ChangeTransID,
		@ChangeTransUserID = @ChangeTransUserID,
		@NoApplicableColor = @NoApplicableColor
END
ELSE	--Style is Multi-Cloth linked and this is not a Main Material.
BEGIN


	--****************************************************************
	--*Get the 'StyleMaterialID' information for the linked Styles.	*
	--****************************************************************
	--*Clear variables.
	SET @StyleMaterialLinkID = NULL


	--*Get the 'StyleMaterialLinkID' value of the calling Style.*
	SELECT @StyleMaterialLinkID = StyleMaterialLinkID
	FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleMaterialID = @StyleMaterialID_Param

	--*Get Main ColorPaletteID from pStyleColorway 
	--
	--SELECT @ColorPaletteID = ColorPaletteID FROM pStyleColorway WHERE StyleColorID IN 
	--		(SELECT StyleColorID FROM pStyleColorwayItem WHERE StyleColorItemID = @StyleColorItemID)
	
	--*Get all the Styles that are Multi-Cloth linked to this 'StyleLinkID'.
	INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet
			,StyleMaterialID 
			,StyleMaterialLinkID
			,StyleColorItemID)	
	SELECT	pStyleMaterials.StyleID
			,@StyleLinkID
			,@StyleSet
			,pStyleMaterials.StyleMaterialID 
			,@StyleMaterialLinkID 	   
			,pStyleColorwayItem.StyleColorItemID 
	FROM dbo.pStyleMaterials WITH (NOLOCK) 
		INNER JOIN dbo.pStyleColorwayItem WITH (NOLOCK) ON dbo.pStyleMaterials.StyleMaterialID = dbo.pStyleColorwayItem.StyleMaterialID 
		INNER JOIN dbo.pStyleColorway WITH (NOLOCK) ON dbo.pStyleColorwayItem.StyleColorID = dbo.pStyleColorway.StyleColorID	
	WHERE pStyleMaterials.StyleMaterialLinkID = @StyleMaterialLinkID AND pStylecolorway.ColorPaletteID = @ColorPaletteID 
			AND pStyleMaterials.StyleID IN (SELECT StyleID FROM pStyleHeader WHERE StyleLinkID = @StyleLinkID)

END


--********************************************************************
--**Loop through the records to update all Multi-Cloth linked Styles.	
--********************************************************************
--**Get and set the counts for the Multi-Cloth linked Styles.
SELECT @TotalCount = COUNT(*) FROM #temp_Linked
SET @RowCounter = 1


--**Get the 'StyleID' for each of the Multi-Cloth linked Styles.
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		--**Clear variables.
		SET @StyleMaterialID = NULL
		SET @StyleColorItemID = NULL
		SET @StyleID = NULL
		SET @StyleSet = NULL


		--**Get the 'StyleID' for the delete.
		SELECT @StyleMaterialID = StyleMaterialID
			,@StyleColorItemID = StyleColorItemID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		--**Execute the original procedure for another Style.
		EXEC spx_StyleColorwayItem_UPDATE
			@MaterialColorID = @MaterialColorID,
			@StyleMaterialID = @StyleMaterialID,
			@StyleColorItemID = @StyleColorItemID,
			@StyleID = @StyleID,
			@StyleSet = @StyleSet,
			@SeasonYearID = @SeasonYearID,
			@AllColor = @AllColor,
			@MUser = @MUser,
			@MDate = @MDate,
			@ChangeTransID = @ChangeTransID,
			@ChangeTransUserID = @ChangeTransUserID,
			@NoApplicableColor = @NoApplicableColor
			
		--**Up row counter.
		SET @RowCounter = @RowCounter + 1
	END


--********************
--**Drop temp tables.	
--********************
DROP TABLE #temp_Linked



IF @AllSize = 1 
BEGIN

	DECLARE @StyleMaterialMasterID UNIQUEIDENTIFIER
	DECLARE @StyleDevelopmentID UNIQUEIDENTIFIER

	SELECT @StyleMaterialMasterID = a.StyleMaterialMasterID , @StyleDevelopmentID  = b.DevelopmentID 
	FROM pStyleMaterials a WITH (NOLOCK) 
		INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID 
	WHERE a.StyleMaterialID = @StyleMaterialID

	--Select @StyleMaterialMasterID as StyleMaterialMasterID , @StyleDevelopmentID  as StyleDevelopmentID  

	IF @StyleMaterialMasterID IS NOT NULL AND @StyleDevelopmentID  IS NOT NULL 
	BEGIN 

		CREATE TABLE #tmp(
			ROWID  INT IDENTITY(1,1),
			StyleID UNIQUEIDENTIFIER, 
			StyleMaterialID UNIQUEIDENTIFIER, 
			StyleColorItemID UNIQUEIDENTIFIER
		)

		INSERT INTO #tmp ( StyleID, StyleMaterialID, StyleColorItemID )
		SELECT d.StyleID, f.StyleMaterialID, e.StyleColorItemID 
		FROM pStyleDevelopmentItem a
			INNER JOIN pStyleSeasonYear b WITH (NOLOCK) ON a.StyleID = b.StyleID 
			INNER JOIN pStyleColorwaySeasonYear c WITH (NOLOCK) ON c.StyleSeasonYearID =  b.StyleSeasonYearID
			INNER JOIN pStyleColorway d WITH (NOLOCK) ON d.StyleColorID = c.StyleColorwayID 
			INNER JOIN pStyleColorwayItem e WITH (NOLOCK) ON e.StyleColorID = d.StyleColorID
			INNER JOIN pStyleMaterials f WITH (NOLOCK) ON f.StyleMaterialID =  e.StyleMaterialID 
		WHERE  a.StyleDevelopmentID = @StyleDevelopmentID 
			AND SeasonyearID = @SeasonyearID 
			AND d.ColorPaletteID = @ColorPaletteID
			AND f.MaterialLinked = 1
			AND f.StyleMaterialMasterID = @StyleMaterialMasterID
			AND f.StyleMaterialID <> @StyleMaterialID


		DECLARE @StyleID_SC UNIQUEIDENTIFIER 
		DECLARE @StyleMaterialID_SC UNIQUEIDENTIFIER 
		DECLARE @StyleColorItemID_SC UNIQUEIDENTIFIER 
		DECLARE @TOTAL INT
		DECLARE @ROWID INT

		SELECT @TOTAL  = COUNT(*) FROM #tmp 
		SET @ROWID = 1 	


		WHILE @ROWID <= @TOTAL 
		BEGIN
			SELECT @StyleID_SC = StyleID , @StyleMaterialID_SC = StyleMaterialID, @StyleColorItemID_SC = StyleColorItemID 
			FROM #tmp WHERE ROWID = @ROWID 

			exec spx_StyleColorwayItem_Linked_UPDATE 
			@MaterialColorID = @MaterialColorID,
			@StyleMaterialID = @StyleMaterialID_SC,
			@StyleColorItemID = @StyleColorItemID_SC,
			@StyleID = @StyleID_SC,
			@StyleSet = @StyleSet,
			@SeasonYearId = @SeasonYearId,
			@AllColor= @AllColor,
			@MUser = @MUser,
			@MDate = @MDate,
			@AllSize = 0,
			@ChangeTransUserID = @ChangeTransUserID

			SET @ROWID = @ROWID  + 1 
		END 

		DROP TABLE #tmp

	END 

	
	SELECT 0 AS iRes
	
END 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06212', GetDate())
GO
