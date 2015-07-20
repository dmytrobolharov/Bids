/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Critical_UPDATE]    Script Date: 07/02/2013 15:41:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Critical_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Critical_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Critical_UPDATE]    Script Date: 07/02/2013 15:41:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Critical_UPDATE]
(@Amlmeaspomid uniqueidentifier, 
 @AMLMeasHdrId uniqueidentifier, 
 @Critical int
 )
AS 
	
BEGIN
	UPDATE pSampleRequestamlmeaspom SET Critical = @Critical
	WHERE SampleRequestAMLMeasHdrId = @AMLMeasHdrId	and SampleRequestAmlmeaspomid=@Amlmeaspomid		
end



GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05960', GetDate())
GO