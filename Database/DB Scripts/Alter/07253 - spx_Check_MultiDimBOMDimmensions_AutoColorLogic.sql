/****** Object:  StoredProcedure [dbo].[spx_Check_MultiDimBOMDimmensions_AutoColorLogic]    Script Date: 03/18/2014 12:55:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Check_MultiDimBOMDimmensions_AutoColorLogic]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Check_MultiDimBOMDimmensions_AutoColorLogic]
GO

/****** Object:  StoredProcedure [dbo].[spx_Check_MultiDimBOMDimmensions_AutoColorLogic]    Script Date: 03/18/2014 12:55:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_Check_MultiDimBOMDimmensions_AutoColorLogic](
	
	@StyleID					UNIQUEIDENTIFIER, 
	@StyleSet					INT, 
	@SeasonYearID				UNIQUEIDENTIFIER,
	@StyleBOMDimensionId		NVARCHAR(50), 
	@StyleBOMDimensionItemId	NVARCHAR(50),		
	@WorkflowID					NVARCHAR(50), 
	@WorkflowItemID				NVARCHAR(50), 	
	@MUser						NVARCHAR(200),
	@MDate						DATETIME,
	@BOMStyleMaterialID			NVARCHAR(300),
	@IsAutoColorBOM				INT OUT
)

AS 
BEGIN
	--Step 1-Declaration and selection of variables for Dimensions and dimmension items	
	
	DECLARE @ItemDim1TypeId				NVARCHAR(50)
	DECLARE @ItemDim2TypeId				NVARCHAR(50)
	DECLARE @ItemDim3TypeId				NVARCHAR(50)
	DECLARE @ItemDim1TypeName			NVARCHAR(50)
	DECLARE @ItemDim2TypeName			NVARCHAR(50)
	DECLARE @ItemDim3TypeName			NVARCHAR(50)	
	DECLARE @ItemDim1Id					NVARCHAR(50) 
	DECLARE @ItemDim2Id					NVARCHAR(50) 
	DECLARE @ItemDim3Id					NVARCHAR(50) 		
	
	SELECT  		
        @ItemDim1TypeId=ItemDim1TypeId,				
		@ItemDim2TypeId=ItemDim2TypeId,			
		@ItemDim3TypeId=ItemDim3TypeId,				
        @ItemDim1TypeName=ItemDim1TypeName, 
        @ItemDim2TypeName =ItemDim2TypeName, 
        @ItemDim3TypeName =ItemDim3TypeName
    FROM 
		pStyleBOMDimension
	WHERE 
		WorkflowId =@WorkflowID
		AND WorkflowItemId =@WorkflowItemID  
		AND StyleId =@StyleID
		AND styleset =@StyleSet	
		AND StyleBOMDimensionID=@StyleBOMDimensionId
			
		
	SELECT 
		@ItemDim1Id=ItemDim1Id,			 
		@ItemDim2Id=ItemDim2Id,				
		@ItemDim3Id=ItemDim3Id	
	FROM
		 pStyleBOMDimensionItems 
	WHERE 
		StyleBOMDimensionItemID=@StyleBOMDimensionItemId	
	
	--Step 2-Check for total count of dimension items.	
	
	DECLARE @TotalCnt INT
	SELECT 
		@TotalCnt = Count(StyleBOMDimensionItemID) 
	FROM 
		pStyleBOMDimensionItem  
	WHERE 
		StyleBOMDimensionId = @StyleBOMDimensionId
	
	--Step 3-Assignment of required color columns
	
	DECLARE 
	@ItemDimId nVARCHAR(50),
	@ItemDimName nVARCHAR(50)
	
	IF @TotalCnt > 0  
	BEGIN
	   IF UPPER(@ItemDim1TypeName)='COLOR'  
	   BEGIN	   
			SELECT 
				@ItemDimId = 'ItemDim1Id', 
				@ItemDimName = 'ItemDim1Name'					
	   END
	   ELSE IF UPPER(@ItemDim2TypeName)='COLOR'  
	   BEGIN	   
			SELECT 
				@ItemDimId = 'ItemDim2Id', 
				@ItemDimName = 'ItemDim2Name'		
	   END   
	   ELSE IF UPPER(@ItemDim3TypeName)='COLOR'  
	   BEGIN
			SELECT 
				@ItemDimId = 'ItemDim3Id', 
				@ItemDimName = 'ItemDim3Name'
	   END
	END
	
	--Step 4-Creation/Insersion of stylecolor table
	
	CREATE TABLE #sc
	(
		ROW_ID					INT IDENTITY(1,1),
		StyleColorID			UNIQUEIDENTIFIER,
		ColorPaletteID			UNIQUEIDENTIFIER,
		ColorName				NVARCHAR(200),
		ColorCode				NVARCHAR(200)
	)
	
	
	IF @TotalCnt > 0  
	BEGIN
		DECLARE @SqlQuery nVARCHAR(MAX)
		SET @SqlQuery=' INSERT INTO #sc (StyleColorID,ColorName,ColorCode,ColorPaletteID)'  
		SET @SqlQuery+=' SELECT DISTINCT'  				
		SET @SqlQuery+=' A.'+@ItemDimId+' AS StyleColorId,'  
		SET @SqlQuery+=' A.'+@ItemDimName+' AS ColorName,' 			
		SET @SqlQuery+=' B.ColorCode AS ColorCode,'
		SET @SqlQuery+=' B.ColorPaletteID '	 
		SET @SqlQuery+=' FROM pStyleBOMDimensionItems  A LEFT OUTER JOIN pStyleColorway C ON A.' + @ItemDimId + ' = C.StyleColorID '	 		  						
		SET @SqlQuery+=' LEFT OUTER JOIN pColorPalette B ON C.ColorPaletteID=B.ColorPaletteID  '			
		SET @SqlQuery+=' WHERE'	 		  			
		SET @SqlQuery+=' StyleBOMDimensionId = '''+@StyleBOMDimensionId+''' '	 		  				 						
		SET @SqlQuery+=' AND '+@ItemDimId+' IS NOT NULL'
		EXEC(@SqlQuery)
	END		

	SET @SqlQuery=NULL	
	
	--Step 5-Creation/Insersion of selected bom material details
	
	CREATE TABLE #mat 
	(
		ROW_ID					INT IDENTITY(1,1),
		StyleMaterialID			UNIQUEIDENTIFIER,
		MaterialID				UNIQUEIDENTIFIER,
		MainMaterial			INT
	)
	
	INSERT INTO #mat
	( 
		StyleMaterialID,
		MaterialID,
		MainMaterial 
	) 
	SELECT 
		SB.StyleMaterialID,
		SB.MaterialID,
		SB.MainMaterial  
	FROM 
		pStyleBOM SB
	WHERE 
		SB.StyleID = @StyleID
		AND SB.StyleMaterialID =@BOMStyleMaterialID
		AND SB.StyleSet =  @StyleSet	

	--Step 5-Iteration through style colors and material colors		
	
	CREATE TABLE #MatchMaterialColors
	(	
		MaterialColorID nVARCHAR(50),	
		IsAutoColorBOM INT
		
	)
	
	DECLARE @TOTAL_M					INT
	DECLARE @ROW_M						INT
	DECLARE @TOTAL_C					INT
	DECLARE @ROW_C						INT
	DECLARE @StyleMaterialID			UNIQUEIDENTIFIER
	DECLARE @MaterialID					UNIQUEIDENTIFIER
	DECLARE @MainMaterial				INT 
	DECLARE @MaterialColorID			UNIQUEIDENTIFIER=NULL
	DECLARE @StyleColorID				UNIQUEIDENTIFIER
	DECLARE @ColorPaletteID				UNIQUEIDENTIFIER
	DECLARE @ColorName					NVARCHAR(200)
	DECLARE @ColorCode					NVARCHAR(200)

	SELECT @TOTAL_M = COUNT(*) FROM #mat
	SET @ROW_M = 1 

	WHILE @ROW_M <= @TOTAL_M
	BEGIN	
			
		SELECT 
			@StyleMaterialID = StyleMaterialID,
			@MaterialID = MaterialID,
			@MainMaterial  = MainMaterial 
		FROM #mat 
		WHERE 
			ROW_ID = @ROW_M	
		
		SELECT @TOTAL_C = COUNT(*) 
		FROM #sc
		SET @ROW_C = 1 	
		
		WHILE @ROW_C <= @TOTAL_C 
		BEGIN		
			SELECT 
				@StyleColorID = StyleColorID,
				@ColorPaletteID = ColorPaletteID,
				@ColorName = ColorName,
				@ColorCode = ColorCode 
			FROM 
				#sc 
			WHERE 
				ROW_ID = @ROW_C						
			
			SET @MaterialColorID = NULL 
			
			SELECT 
				@MaterialColorID = MaterialColorID 
			FROM 
				pStyleBOMItem 
			WHERE 
				StyleMaterialID = @StyleMaterialID 		
				AND StyleSet = @StyleSet
				AND StyleBOMDimensionID=@StyleBOMDimensionId
				AND StyleBOMDimensionItemID=@StyleBOMDimensionItemId
				AND MaterialColorId = @StyleColorID /*Comment #07 - As @StyleMaterialID is unique so remove StyleColorID condition because that column not available in pStyleBOM table*/
						
			IF @MaterialColorID IS NULL 
			BEGIN 										
				IF @TotalCnt > 0  
				BEGIN
					IF (UPPER(@ItemDim1TypeName)='COLOR')  OR (UPPER(@ItemDim2TypeName)='COLOR')	OR (UPPER(@ItemDim3TypeName)='COLOR')			
					BEGIN													
						IF(@MainMaterial=1)
						BEGIN
							--Step 6-If material is main material match material id,color code,colorpalette,season from pmaterialcolor,pMaterialColorSeasonYear
					
							SELECT 
								@MaterialColorID =A.MaterialColorID
							FROM 
								pMaterialColor A
								INNER JOIN pColorPalette B ON A.ColorPaletteID = B.ColorPaletteID 
								INNER JOIN pMaterialColorSeasonYear C ON C.MaterialColorID = A.MaterialColorID
							WHERE 
								A.MaterialID = @MaterialID
								AND B.ColorCode = @ColorCode 
								AND B.ColorPaletteID =@ColorPaletteID 
								AND C.SeasonYearID = @SeasonYearID														
						END	
						ELSE
						BEGIN
							--Step 7-If material is other material match material id,season from pMaterialColorSeasonYear table
							SELECT 
								@MaterialColorID = A.MaterialColorID
							FROM 
								pMaterialColor A
								INNER JOIN pColorPalette B ON A.ColorPaletteID = B.ColorPaletteID 
								INNER JOIN pMaterialColorSeasonYear C ON C.MaterialColorID = A.MaterialColorID
							WHERE 
								C.MaterialID = @MaterialID 
								AND C.SeasonYearID = @SeasonYearID
						END

						IF NOT(@MaterialColorID IS NULL OR len(@MaterialColorID)=0)
						BEGIN		
							--Step 8-If matching color found in material color 					
							SET @IsAutoColorBOM=1	
							INSERT INTO #MatchMaterialColors
							SELECT @MaterialColorID,@IsAutoColorBOM														
						END	
						ELSE
						BEGIN	
							--Step 9-If matching color found in material color 
							SET @IsAutoColorBOM=0								
						END					
					END	
				END
			END
			
			SET @ROW_C = @ROW_C + 1
		END
		SET @ROW_M= @ROW_M + 1 
	END 
	
	--Step 10-Realease temporory tables and variables here	
	
	IF((SELECT COUNT(MaterialColorID) FROM #MatchMaterialColors)>0)
	BEGIN
			SET @IsAutoColorBOM=1			
	END	
	ELSE
	BEGIN
			SET @IsAutoColorBOM=0			
	END			
		
	SET @SqlQuery =NULL	
	IF OBJECT_ID('tempdb..#sc') IS NOT NULL
	BEGIN
		DROP TABLE #sc
	END
	
	IF OBJECT_ID('tempdb..#mat') IS NOT NULL
	BEGIN
		DROP TABLE #mat
	END
	
	IF OBJECT_ID('tempdb..#MatchMaterialColors') IS NOT NULL
	BEGIN
		DROP TABLE #MatchMaterialColors
	END
	
END	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07253', GetDate())
GO
