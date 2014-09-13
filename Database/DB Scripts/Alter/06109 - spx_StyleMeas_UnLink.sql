IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_UnLink]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_UnLink]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeas_UnLink]
(
	@WorkFlowItemId UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @NewWorkFlowItemId UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	DELETE FROM pWorkFlowItemLinked WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID AND StyleSet = @StyleSet
	IF @NewWorkFlowItemId IS NOT NULL
		BEGIN
			DECLARE @OldAMLMeasHdrID UNIQUEIDENTIFIER = (SELECT AMLMeasHdrId FROM pAMLMeasHdr WHERE WorkFlowItemId = @WorkFlowItemId)
			DECLARE @NewAMLMeasHdrID UNIQUEIDENTIFIER = (SELECT AMLMeasHdrId FROM pAMLMeasHdr WHERE WorkFlowItemId = @NewWorkFlowItemId)
		
			UPDATE pMSEvalSampMeas SET AMLMeasPomid = namp.AMLMeasPOMId
			FROM pMSEvalSampMeas msm 
			INNER JOIN pAMLMeasPOM amp ON msm.AMLMeasPomid = amp.AMLMeasPOMId
			INNER JOIN pAMLMeasPOM namp ON amp.POM_Row = namp.POM_Row AND namp.AMLMeasHdrId = @NewAMLMeasHdrID
		
			UPDATE pMSEvalHeader SET WorkFlowItemId = @NewWorkFlowItemId, AMLMeasHdrId = @NewAMLMeasHdrID
			WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID AND StyleSet = @StyleSet
			
			UPDATE pMSEvalHeader SET EvalSizeId = naml.AMLMeasLblId
			FROM pMSEvalHeader mseh
			INNER JOIN pAMLMeasLbl aml ON mseh.EvalSizeId = aml.AMLMeasLblId AND aml.AMLMeasHdrId = @OldAMLMeasHdrID
			INNER JOIN pAMLMeasLbl naml ON aml.SizeCol = naml.SizeCol AND naml.AMLMeasHdrId = @NewAMLMeasHdrID
			
			UPDATE pMSEvalSampMeas SET AMLMeasHdrId = @NewAMLMeasHdrID WHERE AMLMeasHdrId = @OldAMLMeasHdrID
			UPDATE pMSEvalSampLbl SET AMLMeasHdrId = @NewAMLMeasHdrID WHERE AMLMeasHdrId = @OldAMLMeasHdrID
			UPDATE pMSEvalPom SET AMLMeasHdrId = @NewAMLMeasHdrID WHERE AMLMeasHdrId = @OldAMLMeasHdrID
			UPDATE pQAHeader SET WorkFlowItemId = @NewWorkFlowItemId WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID AND StyleSet = @StyleSet
			UPDATE pSampleRequestBOMTrade SET WorkFlowItemId = @NewWorkFlowItemId WHERE WorkFlowItemID = @WorkFlowItemId AND StyleID = @StyleID
		END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06109', GetDate())
GO
