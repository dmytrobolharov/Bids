/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasTemplateUnLink_UPDATE]    Script Date: 07/02/2013 15:48:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_MeasTemplateUnLink_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasTemplateUnLink_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_MeasTemplateUnLink_UPDATE]    Script Date: 07/02/2013 15:48:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_MeasTemplateUnLink_UPDATE]
(@Amlmeaspomid uniqueidentifier,
@AmlmeasHdrid uniqueidentifier,
 @Linked int)
AS 

Begin
	IF @Linked = 0
		BEGIN
			UPDATE pSampleRequestamlmeaspom SET IsLinked=0 WHERE SampleRequestAmlmeaspomid = @Amlmeaspomid	
			and SampleRequestAmlmeasHdrid=@AmlmeasHdrid	
		end
end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05985', GetDate())
GO