IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_DELETE] (
	@WorkFlowId uniqueidentifier,
	@WorkFlowItemId uniqueidentifier,
	@StyleId uniqueidentifier,
	@StyleSet int)
AS

Declare @MeashdrId UNIQUEIDENTIFIER
Declare @bomId UNIQUEIDENTIFIER
Declare @Meascnt int
Declare @bomcnt int

Declare @StyleSeasonYearID UNIQUEIDENTIFIER

BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
	
			IF @WorkFlowId = '80000000-0000-0000-0000-000000000008' 
			BEGIN
				DELETE FROM pConPageDetail WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet			
			END
			Else If @WorkFlowId = '40000000-0000-0000-0000-000000000050' 
			BEGIN	
				SELECT @Meascnt = COUNT(AMLMeasHdrId) 
				FROM pamlmeashdr 
				WHERE WorkFlowID = @WorkFlowId AND WorkFlowItemID = @WorkFlowItemId
				
				IF @Meascnt<=1 
				BEGIN
					SELECT @MeashdrId = AMLMeasHdrId 
					FROM pamlmeashdr 
					WHERE WorkFlowID = @WorkFlowId AND WorkFlowItemID = @WorkFlowItemId
										
					DELETE FROM pAMLMeasHdr WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pAMLMeaslbl WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pAMLMeaspom WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pAMLMeasigc WHERE AMLMeasHdrId = @MeashdrId
					DELETE FROM pStyleImageMeasurements WHERE MeasurementID = @WorkFlowItemId AND StyleId = @StyleId
				END			
			END
			Else If @WorkFlowId = '40000000-0000-0000-0000-000000000080' 
				BEGIN	
					SELECT @bomcnt = COUNT(StyleBOMDimensionId) 
					FROM pStyleBOMDimension 
					WHERE	WorkFlowID = @WorkFlowId AND 
							WorkFlowItemID = @WorkFlowItemId AND 
							StyleId = @StyleId AND 
							StyleSet = @StyleSet
							
					IF @bomcnt<=1 
						BEGIN
							Select @StyleSeasonYearID = StyleSeasonYearID FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkFlowItemId
							select @bomId = StyleBOMDimensionId from pStyleBOMDimension WHERE WorkFlowID = @WorkFlowId and 
							WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
							DELETE FROM pStyleBOMDimension WHERE StyleBOMDimensionId = @bomId
							
							/* delete colorways from Seasonal Colorway if we delete colors from DimBOM */
							DELETE FROM pStyleColorwaySeasonYear WHERE 
								StyleColorwayID IN (SELECT ItemDim1Id FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @bomId AND ItemDim1Id IS NOT NULL)
								AND StyleColorwayID NOT IN (SELECT COALESCE(ItemDim1Id,ItemDim2Id,ItemDim3Id) FROM pStyleBOMDimensionItem 
									INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
									WHERE StyleBOMDimensionID <> @bomId AND StyleSeasonYearID = @StyleSeasonYearID
								) AND StyleSeasonYearID = @StyleSeasonYearID
							DELETE FROM pStyleColorwaySeasonYear WHERE 
								StyleColorwayID IN (SELECT ItemDim2Id FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @bomId AND ItemDim2Id IS NOT NULL)
								AND StyleColorwayID NOT IN (SELECT COALESCE(ItemDim1Id,ItemDim2Id,ItemDim3Id) FROM pStyleBOMDimensionItem 
									INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
									WHERE StyleBOMDimensionID <> @bomId AND StyleSeasonYearID = @StyleSeasonYearID
								) AND StyleSeasonYearID = @StyleSeasonYearID
							DELETE FROM pStyleColorwaySeasonYear WHERE 
								StyleColorwayID IN (SELECT ItemDim3Id FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @bomId AND ItemDim3Id IS NOT NULL)
								AND StyleColorwayID NOT IN (SELECT COALESCE(ItemDim1Id,ItemDim2Id,ItemDim3Id) FROM pStyleBOMDimensionItem 
									INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
									WHERE StyleBOMDimensionID <> @bomId AND StyleSeasonYearID = @StyleSeasonYearID
								) AND StyleSeasonYearID = @StyleSeasonYearID
							
							DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionId = @bomId					
							DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionId = @bomId
							DELETE FROM pStyleBOM WHERE StyleBOMDimensionId=@bomId and 
							WorkFlowID = @WorkFlowId and WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
							DELETE FROM pStyleBOMTemp WHERE StyleBOMDimensionId = @bomId
							DELETE FROM pStyleBOMItem WHERE StyleBOMDimensionId = @bomId
						END					
				END
			Else IF @WorkFlowId = '40000000-0000-0000-0000-000000000090' 
				BEGIN		
					DELETE FROM pStyleSKUItems WHERE StyleSKUItemID IN (SELECT StyleSKUItemID FROM pStyleSKUItem WHERE WorkFlowItemID = @WorkFlowItemId)
					DELETE FROM pStyleSKUItem WHERE WorkFlowItemID = @WorkFlowItemId
				END
			Else IF @WorkFlowId = '40000000-0000-0000-0000-000000000018' 
				BEGIN		
					DELETE FROM pStyleComment WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
					DELETE FROM pStyleDetailForm WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
				END
			Else IF @WorkFlowId = '40000000-0000-0000-0000-000000000078'  -- BOL v.2
				BEGIN
					DELETE FROM pStyleNBOLExceptionEntries WHERE StyleNBOLItemID IN (SELECT StyleNBOLItemID FROM pStyleNBOLItems WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet)
					DELETE FROM pStyleNBOLException WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
					DELETE FROM pStyleNBOLHeader WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
					DELETE FROM pStyleNBOLItems WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
				END
			Else IF @WorkFlowId = '40000000-0000-0000-0000-000000000099'  -- 3D Files
				BEGIN
					DELETE FROM pStyle3DFiles WHERE WorkflowItemID = @WorkFlowItemId
				END				
			
			DELETE FROM pStyleComment WHERE WorkFlowItemId = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet
			DELETE FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkFlowItemId AND StyleId = @StyleId AND StyleSet = @StyleSet	

												
        COMMIT TRANSACTION;
        
        --If Successful
        SELECT 1;
        
    END TRY
    BEGIN CATCH  
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        
        --If Error
        SELECT 0;
        
    END CATCH;
END; -- End
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09664', GetDate())
GO