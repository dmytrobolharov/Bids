IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MeasurementIsUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MeasurementIsUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MeasurementIsUsed_SELECT] (
	@WorkFlowId uniqueidentifier,
	@WorkFlowItemId uniqueidentifier,
	@StyleId uniqueidentifier,
	@StyleSet int
)
AS

DECLARE @IsUsed int = 0
DECLARE @Meascnt int = 0
DECLARE @MeashdrId uniqueidentifier

If @WorkFlowId = '40000000-0000-0000-0000-000000000050' 
BEGIN	

	SELECT @Meascnt = COUNT(AMLMeasHdrId) FROM pAMLMeasHdr WHERE WorkFlowID = @WorkFlowId AND WorkFlowItemID = @WorkFlowItemId
	IF @Meascnt <= 1 
	BEGIN
		SELECT @MeashdrId = AMLMeasHdrId FROM pAMLMeasHdr WHERE WorkFlowID = @WorkFlowId AND WorkFlowItemID = @WorkFlowItemId
		SELECT @IsUsed = COUNT(*) FROM pStyleBOMDimensionItem 
		WHERE StyleID = @StyleId AND StyleSet = @StyleSet AND Amlmeashdrid = @MeashdrId			
		
		-- Sample Request
		SELECT @IsUsed = (@IsUsed + COUNT(*)) FROM
		(
			SELECT SampleRequestWorkflowID FROM pSampleRequestWorkflow WHERE SampleRequestWorkflowID IN (SELECT SampleRequestWorkflowID FROM pMSEvalHeader WHERE WorkFlowItemID=@WorkFlowItemId AND AMLMeasHdrId=@MeashdrId)
			union
			SELECT SampleRequestWorkflowID FROM pSampleRequestWorkflowBOM WHERE SampleRequestWorkflowID IN (SELECT SampleRequestWorkflowID FROM pMSEvalHeader WHERE WorkFlowItemID=@WorkFlowItemId AND AMLMeasHdrId=@MeashdrId)
		) t
	END

END

SELECT @IsUsed AS IsUsed

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07182', GetDate())
GO
