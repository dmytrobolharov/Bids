IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_MeasTemplateUnLink_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_MeasTemplateUnLink_UPDATE]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_Style_MeasTemplateUnLink_UPDATE]
(@Amlmeaspomid uniqueidentifier,
@AmlmeasHdrid uniqueidentifier,
 @Linked int)
AS 

Begin
	IF @Linked = 0
		BEGIN
			UPDATE pamlmeaspom SET IsLinked=0 WHERE Amlmeaspomid = @Amlmeaspomid	
			and AmlmeasHdrid=@AmlmeasHdrid	
		end
end
Go
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02170'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02170', GetDate())
END	
GO
