IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_INSERT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@SampleRequestSubmitGroupID UNIQUEIDENTIFIER,
	@TemplateID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER,
	@Submit INT = null
)
AS 

IF @Submit = null
	BEGIN
		SET @Submit = 1
	END

INSERT INTO pSampleRequestGCCWorkflow (
	SampleRequestGCCWorkflowID, SampleRequestSubmitID, SampleRequestSubmitVendorID ,
	Custom1, Custom2,
	Custom3, Custom4,
	Custom5, Custom6,
	Submit) 

SELECT NEWID() AS SampleRequestGCCWorkflowID, @SampleRequestSubmitID, @SampleRequestSubmitGroupID,
	TemplateDetailCustom1, TemplateDetailCustom2,
	TemplateDetailCustom3, TemplateDetailCustom4,
	TemplateDetailCustom5, TemplateDetailCustom6, @Submit
FROM pSampleGCCTemplateItem
WHERE TemplateDetailGridID = @TemplateID



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02975'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02975', GetDate())

END

GO

