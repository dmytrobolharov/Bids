/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_AddBOMMaterial_EXECUTE_QUEUE]    Script Date: 12/18/2012 14:25:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_AddBOMMaterial_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_AddBOMMaterial_EXECUTE_QUEUE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_AddBOMMaterial_EXECUTE_QUEUE]    Script Date: 12/18/2012 14:25:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_AddBOMMaterial_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS

DECLARE 
	@error INT,
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MainMaterial INT
	
	
SET @error = 0 

BEGIN TRAN 

	BEGIN TRY 

		DECLARE 
			@MUser NVARCHAR(200),
			@NewStyleMaterialID UNIQUEIDENTIFIER,
			@StyleBOMDimensionID UNIQUEIDENTIFIER,
			@WorkflowItemID UNIQUEIDENTIFIER,
			@WorkflowID UNIQUEIDENTIFIER,
			@StyleID UNIQUEIDENTIFIER,
			@MaterialID UNIQUEIDENTIFIER,
			@ROWID INT,
			@TOTAL INT,
			@TeamID  UNIQUEIDENTIFIER
		

		SELECT @MUser = ISNULL(b.UserName,'') + ' '  +  ISNULL(b.LastName,''),
			@TeamID = b.TeamID
		FROM dbo.pBatchQueueJob a
			INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID = b.TeamID
		WHERE BatchQueueJobID = @BatchQueueJobID

		CREATE TABLE #bqsm(
			ROWID INT IDENTITY(1,1),
			StyleMaterialID UNIQUEIDENTIFIER,
			StyleBOMDimensionID UNIQUEIDENTIFIER
		)


		INSERT INTO #bqsm(StyleMaterialID, StyleBOMDimensionID)
		SELECT StyleMaterialID, StyleBOMDimensionID
		FROM dbo.pBatchQueueStyleMaterialTmp WITH(NOLOCK)
		WHERE BatchQueueJobID = @BatchQueueJobID


		SELECT @TOTAL = COUNT(*) FROM #bqsm 
		SET @ROWID = 1 

		WHILE @ROWID <=  @TOTAL
		BEGIN

		
			SELECT @NewStyleMaterialID = StyleMaterialID,
				@StyleBOMDimensionID = StyleBOMDimensionID
			FROM #bqsm
			WHERE ROWID =  @ROWID
			
			SELECT @MaterialID = MaterialID
			FROM pBatchQueueStyleMaterialTmp WITH(NOLOCK)
			WHERE StyleMaterialID = @NewStyleMaterialID
			
			SELECT @WorkflowItemID = wi.WorkFlowItemID, @WorkflowID = wi.WorkflowID,
			@StyleID = wi.StyleID
			FROM pStyleBOMDimension bomdim
			INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = bomdim.WorkFlowItemID
			WHERE bomdim.StyleBOMDimensionID = @StyleBOMDimensionID
			
			EXEC spx_StyleBOMTemp_INSERT
				@MainMaterial =  0, 
				@StyleID = @StyleID, 
				@StyleMaterialID  = @NewStyleMaterialID, 
				@StyleSet = 1, 
				@MaterialID = @MaterialID, 
				@CreatedBy = @MUser, 
				@CreatedDate = @MDate,
				@TradePartnerVendorID = NULL,
				@StyleBOMDimensionID = @StyleBOMDimensionID,
				@WorkflowID = @WorkflowID,
				@WorkflowItemID = @WorkflowItemID
			
			-- Values from batch table	
			UPDATE pStyleBOMTemp  
			SET
				Qty =  b.Qty,
				MaterialSizeID = b.MaterialSizeID,
				Artwork = ISNULL(b.Artwork,0),
				Colorway =  ISNULL(b.Colorway,0),
				Placement = b.Placement
			FROM pStyleBOMTemp a	
				INNER JOIN pBatchQueueStyleMaterialTmp b ON a.StyleMaterialID = b.StyleMaterialID 
			WHERE b.StyleMaterialID = @NewStyleMaterialID
			

			EXECUTE spx_StyleBOMPending_INSERT
				@StyleMaterialID = @NewStyleMaterialID,    
				@StyleID = @StyleID, 
				@StyleSet = 1, 
				@CreatedDate = @MDate, 
				@CreatedBy = @MUser,
				@WorkflowItemID = @WorkflowItemID,
				@WorkflowID = @WorkflowID,
				@StyleBOMDimensionID = @StyleBOMDimensionID,
				@NewStyleMaterialID = @NewStyleMaterialID OUTPUT
				
			UPDATE #bqsm SET StyleMaterialID = @NewStyleMaterialID
			WHERE ROWID = @ROWID

			SET @ROWID = @ROWID + 1 
		END 
		
		--** UpdateColorways
		
		DECLARE 
			@ColorRowID INT ,
			@ColorTotal INT ,
			@MaterialColorID UNIQUEIDENTIFIER,
			@ColorName  NVARCHAR(200),
			@ColorCode  NVARCHAR(200),
			@DimColor VARCHAR(2) = '',
			@CurrentDimensionType UNIQUEIDENTIFIER,
			@tmpStyleBomDimensionID UNIQUEIDENTIFIER,
			@StyleColorID UNIQUEIDENTIFIER

			
		CREATE TABLE #bq_color(
			ROWID INT IDENTITY(1,1),
			ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
			ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
			MaterialColorID UNIQUEIDENTIFIER
		)

		INSERT INTO #bq_color(ColorCode, ColorName, MaterialColorID)
		SELECT ColorCode, ColorName, MaterialColorID
		FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
		WHERE BatchQueueJobID = @BatchQueueJobID
			AND MaterialColorID IS NOT NULL 


		SELECT @TOTAL = COUNT(*) FROM #bqsm 
		SELECT @ColorTotal  =  COUNT(*) FROM #bq_color
		SET @ROWID = 1
		

		WHILE @ROWID <= @TOTAL
		BEGIN 
			SELECT @NewStyleMaterialID = StyleMaterialID, 
					@tmpStyleBomDimensionID = StyleBOMDimensionID
			FROM #bqsm WHERE ROWID = @ROWID
			
			SET @ColorRowID = 1 
			
			WHILE @ColorRowID <= @ColorTotal 
			BEGIN
			
				SELECT @MaterialColorID = MaterialColorID, @ColorCode = ColorCode,
					@ColorName = ColorName 
				FROM #bq_color WHERE ROWID = @ColorRowID
				
				-- Checking, which of pStyleBOMItem item is the Colorway items
				
				SELECT @CurrentDimensionType = ItemDim1TypeId FROM pStyleBOMDimension
				WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID
				
				IF @CurrentDimensionType = 'E6FC79E6-19DA-E011-853F-001B21B1D4DF' -- Color
				BEGIN
					SET @DimColor = '1'
					SELECT @StyleColorID = ItemDim1ID FROM pStyleBOMDimensionItem
					WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID
					AND ItemDim1Name = @ColorName
				END
				ELSE
				BEGIN
					SELECT @CurrentDimensionType = ItemDim2TypeId FROM pStyleBOMDimension
					WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID
					IF @CurrentDimensionType = 'E6FC79E6-19DA-E011-853F-001B21B1D4DF'
					BEGIN
						SET @DimColor = '2'
						SELECT @StyleColorID = ItemDim2ID FROM pStyleBOMDimensionItem
						WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID
						AND ItemDim2Name = @ColorName
					END
					ELSE
					BEGIN
						SELECT @CurrentDimensionType = ItemDim3TypeId FROM pStyleBOMItem
						WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID
						IF @CurrentDimensionType = 'E6FC79E6-19DA-E011-853F-001B21B1D4DF'
						BEGIN
							SET @DimColor = '3'
							SELECT @StyleColorID = ItemDim3ID FROM pStyleBOMDimensionItem
							WHERE StyleBOMDimensionID = @tmpStyleBomDimensionID
							AND ItemDim3Name = @ColorName
						END
					END
				END
				
				EXEC spx_StyleBOMDimColorway_UPDATE 
				@MaterialColorID = @MaterialColorID, 
				@StyleMaterialID= @NewStyleMaterialID, 
				@StyleColorID = @StyleColorID, 
				@StyleID = @StyleID, 
				@Styleset = 1, 
				@StyleBOMDimensionId = @tmpStyleBomDimensionID, 
				@AllColor = 0, 
				@AllSize = 0, 
				@DimColor = @DimColor, 
				@DimSize = '', 
				@MUser = @MUser, 
				@MDate = @MDate
				
				SET @DimColor = ''
				SET @StyleColorID = NULL
				
				SET @ColorRowID = @ColorRowID  + 1 
				
			END  -- While Colors
			
			SET @ROWID = @ROWID + 1 
		END		


		DROP TABLE #bq_color
		DROP TABLE #bqsm


END TRY
BEGIN CATCH 
	set @error = 1 
END CATCH 

IF @error = 0
BEGIN
	COMMIT TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID

END
ELSE	
BEGIN
	ROLLBACK TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '30000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04663', GetDate())
GO
