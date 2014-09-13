IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_TemplateDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_TemplateDelete]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleMeas_TemplateDelete]
(	@AMLMeasHdrId uniqueidentifier,
	@CUser nvarchar(200),	
	@CDate datetime	
)

AS 

Begin	
	Delete from pamlmeaslbl where AMLMeasHdrId=@AMLMeasHdrId 
	Delete from pamlmeaspom where AMLMeasHdrId=@AMLMeasHdrId 
	Delete from pamlmeasigc where AMLMeasHdrId=@AMLMeasHdrId 
End

Go
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02156'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02156', GetDate())
END	
GO
