IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreColorItem_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCoreColorItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreColorItem_UPDATE] (
	@MaterialCoreItemID UNIQUEIDENTIFIER,
	@MaterialCoreColorID UNIQUEIDENTIFIER,
	@ColorPaletteId uniqueidentifier,
	@ModifiedBy varchar(200),
	@ModifiedDate datetime
)
AS 

DECLARE 
	@TmpColorPaletteID UNIQUEIDENTIFIER,
	@TmpMaterialID UNIQUEIDENTIFIER,
	@TmpMaterialColorID UNIQUEIDENTIFIER,
	@TmpMaterialCoreID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200),
	@ColorName NVARCHAR(200)


BEGIN
	SELECT 
		@TmpMaterialID = a.MaterialID,
		@TmpMaterialColorID = a.MaterialColorID,
		@TmpMaterialCoreID = a.MaterialCoreID,
		@ColorCode = c.ColorCode,
		@ColorName = c.ColorName
	FROM pMaterialCoreColorItem a WITH (NOLOCK)
		INNER JOIN pMaterialCoreColor c ON a.MaterialCoreColorID =  c.MaterialCoreColorID 
		INNER JOIN dbo.pColorPalette b ON c.ColorPaletteID = b.ColorPaletteID
	WHERE a.MaterialCoreColorID = @MaterialCoreColorID 
		AND a.MaterialCoreItemID = @MaterialCoreItemID 
END


DECLARE @TmpStyleMaterialID UNIQUEIDENTIFIER
DECLARE @TmpStyleID UNIQUEIDENTIFIER

BEGIN
	SELECT @TmpStyleMaterialID = StyleMaterialID, @TmpStyleID = StyleID 
	FROM pStyleMaterials  WITH (NOLOCK) WHERE StyleMaterialLinkID = @MaterialCoreItemID 
END

--Update Material group colors
BEGIN
	UPDATE pMaterialCoreColorItem
	   SET MaterialColorID = @ColorPaletteId
		  ,MUser = @ModifiedBy
		  ,MDate = @ModifiedDate
	 WHERE MaterialCoreItemID = @MaterialCoreItemID
		AND MaterialCoreColorID = @MaterialCoreColorID
END

--Update Style Material Color Item
BEGIN

	UPDATE pStyleColorwayItem 
		SET MaterialColorID = @ColorPaletteId   
		  ,MUser = @ModifiedBy
		  ,MDate = @ModifiedDate
	WHERE MaterialID = @TmpMaterialID 
		AND MaterialColorID = @TmpMaterialColorID 
		AND StyleMaterialID = @TmpStyleMaterialID 	  		

END

--BEGIN

--	UPDATE pStyleSourcingItem 
--		SET MaterialColorID = @ColorPaletteId   
--		  ,MUser = @ModifiedBy
--		  ,MDate = @ModifiedDate
--	WHERE MaterialID = @TmpMaterialID 
--		AND MaterialColorID = @TmpMaterialColorID 
--		AND StyleMaterialID = @TmpStyleMaterialID 	

--END



--This will be done by request in the "Where used" option
/*
--***
-- UPDATE Colorwayitems for materialgroupItem not in a Multi-cloth style
-- When color selection changed
--***
IF @TmpMaterialColorID <> @ColorPaletteId
BEGIN 


	DECLARE 
		@pMaterialCoreItemID NVARCHAR(70),
		@pStyleMaterialID NVARCHAR(70),
		@pMUser NVARCHAR(250),
		@pMDate NVARCHAR(100),
		@ServiceDate DATETIME,
		@ServiceQueueSql1 NVARCHAR(4000)
		
	SET @ServiceDate = getdate()


	DECLARE 
		@ROWID INT,
		@TOTAL INT,
		@StyleMaterialID UNIQUEIDENTIFIER 


	CREATE TABLE #sm(
		ROWID INT IDENTITY ( 1,1), 
		StyleMaterialID UNIQUEIDENTIFIER
	)


	INSERT INTO  #sm (StyleMaterialID) 
	SELECT DISTINCT b.StyleMaterialID
	FROM dbo.pStyleMaterials a
		INNER JOIN pStyleColorwayItem b ON a.StyleMaterialID = b.StyleMaterialID
		INNER JOIN pStyleColorway c ON c.StyleColorID =  b.StyleColorID 
		INNER JOIN pColorPalette d ON d.ColorPaletteID = c.ColorPaletteID 
	WHERE MaterialCoreItemID IS NOT NULL 
		AND d.ColorCode = @ColorCode  
		AND d.ColorName = @ColorName
		AND MaterialCoreItemID = @MaterialCoreItemID


	SELECT @TOTAL  = COUNT(*) FROM #sm
	SET @ROWID = 1 

	WHILE @ROWID <= @TOTAL 
	BEGIN 

		SELECT @StyleMaterialID = StyleMaterialID FROM #sm WHERE ROWID = @ROWID

		SET @pStyleMaterialID = ' @StyleMaterialID = ''' +  CAST (@StyleMaterialID AS NVARCHAR(50)) + ''' '
		SET @pMaterialCoreItemID = ' @MaterialCoreItemID = ''' +  CAST (@MaterialCoreItemID AS NVARCHAR(50)) + ''' '

		IF @ModifiedBy IS NULL
			SET @pMUser = ' @MUser = NULL '
		ELSE
			SET @pMUser = ' @MUser = ''' +  @ModifiedBy  + ''' '

		IF @ModifiedDate IS NULL
			SET @pMDate = ' @MDate = NULL '
		ELSE
			SET @pMDate = ' @MDate = ''' +  CONVERT( NVARCHAR(40) , @ModifiedDate  , 20 ) + ''' '
		
		SET @ServiceQueueSql1 = 'dbo.spx_StyleMaterialCoreItem_Logic_UPDATE ' + 
		@pStyleMaterialID + ',' + 
		@pMaterialCoreItemID + ',' + 
		@pMUser + ',' + 
		@pMDate
		
		EXECUTE spx_ServiceQueue_INSERT @ServiceQueueSql = @ServiceQueueSql1, 
			@ServiceQueuePriority = 1, @ServiceQueueDate = @ServiceDate		
				
		SET @ROWID = @ROWID + 1 
		
	END 

END

*/
