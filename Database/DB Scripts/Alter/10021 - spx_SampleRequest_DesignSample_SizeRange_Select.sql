IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_SizeRange_Select]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_SizeRange_Select]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_SizeRange_Select](
	@StyleID uniqueidentifier,
	@StyleSet int,
	@SampleRequestAmlMeaslblId uniqueidentifier
)
AS
BEGIN

  SELECT COUNT(*)
  FROM fnx_GetSizeRangeInfo((SELECT SizeRangeId FROM pStyleHeader WHERE StyleID = @StyleID))
  WHERE SizeName = (SELECT MeasLbl FROM pSampleRequestAMLMeasLbl WHERE SampleRequestAMLMeasLblId = @SampleRequestAmlMeaslblId)

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10021', GetUTCDate())
GO
