IF OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateItem_SELECT]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateItem_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@SampleRequestSubmitGroupID UNIQUEIDENTIFIER
)
AS 
BEGIN
	SELECT * 
	FROM pSampleRequestGCCWorkflow WITH(NOLOCK)
	WHERE SampleRequestSubmitID =  @SampleRequestSubmitID 
		AND SampleRequestSubmitVendorID = @SampleRequestSubmitGroupID
	ORDER BY CDate
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '6.1.0000', '09582', GetDate())
GO