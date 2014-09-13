SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateGrp_Update')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateGrp_Update
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateGrp_Update]
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
		


Begin

	UPDATE pGRMeasurementsPOMTemplateGroup SET [Relative]=@Relative, 
	Negative=@Negative, Metric=@Metric, POMType=@POMType, POMTypeDescription=@POMDesc
	where POMTempGroupID = @POMTempGroupID 	
	
	UPDATE pGRMeasurementsPOMTemplate
	SET  POMType=@POMType, POMTypeDescription=@POMDesc
	where POMTempGroupID = @POMTempGroupID 	

end

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02105'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02105', GetDate())
	END
GO