IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_ShowOnQA_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_ShowOnQA_UPDATE]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleMeas_ShowOnQA_UPDATE]
(@Amlmeaspomid uniqueidentifier, 
 @AMLMeasHdrId uniqueidentifier, 
 @OnQA int
 )
AS 
	
BEGIN
	UPDATE pamlmeaspom SET Flag4QA = @OnQA
	WHERE AMLMeasHdrId = @AMLMeasHdrId	and Amlmeaspomid=@Amlmeaspomid		
end


Go
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02172'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02172', GetDate())
END	
GO
