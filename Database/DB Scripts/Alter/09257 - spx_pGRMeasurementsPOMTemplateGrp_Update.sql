IF OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateGrp_Update]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateGrp_Update]
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateGrp_Update]
(
	@POMTempID  uniqueidentifier,
	@POMTempGroupId  uniqueidentifier,	
	@POMType nvarchar(100),
	@POMDesc nvarchar(200),
	@Relative int,
	@Negative int,
	@Metric int,
	@CUser nvarchar(200),
	@CDate datetime
)

AS 

BEGIN

	UPDATE pGRMeasurementsPOMTemplateGroup SET [Relative]=@Relative, 
	Negative=@Negative, Metric=@Metric, POMType=@POMType, POMTypeDescription=@POMDesc
	where POMTempGroupID = @POMTempGroupID 	
	
	UPDATE pGRMeasurementsPOMTemplate
	SET  POMType=@POMType, POMTypeDescription=@POMDesc
	where POMTempGroupID = @POMTempGroupID 	

    -- update POMType in pAMLMeasHdr and pSampleRequestAMLMeasHdr WI#29481
	UPDATE pAMLMeasHdr
	SET CompanyName = @POMType
	WHERE CompanyId IN (SELECT POMTempID FROM pGRMeasurementsPOMTemplate 
	                    WHERE POMTempGroupID = @POMTempGroupID)
	UPDATE pSampleRequestAMLMeasHdr
	SET CompanyName = @POMType
	WHERE CompanyId IN (SELECT POMTempID FROM pGRMeasurementsPOMTemplate 
	                    WHERE POMTempGroupID = @POMTempGroupID)

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09257', GetDate())
GO

