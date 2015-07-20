/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_ShowOnQA_UPDATE]    Script Date: 07/02/2013 15:45:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_ShowOnQA_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_ShowOnQA_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_ShowOnQA_UPDATE]    Script Date: 07/02/2013 15:45:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_ShowOnQA_UPDATE]
(@Amlmeaspomid uniqueidentifier, 
 @AMLMeasHdrId uniqueidentifier, 
 @OnQA int
 )
AS 
	
BEGIN
	UPDATE pSampleRequestamlmeaspom SET Flag4QA = @OnQA
	WHERE SampleRequestAMLMeasHdrId = @AMLMeasHdrId	and SampleRequestAmlmeaspomid=@Amlmeaspomid		
end



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05973', GetDate())
GO