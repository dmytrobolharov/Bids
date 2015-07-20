IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemUnLink_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemUnLink_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowTemplateItem_INSERT]    Script Date: 12/15/2011 17:15:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemUnLink_UPDATE]
(@POMTempItemID uniqueidentifier, @Linked int)
AS 

declare @POMTempGroupID nvarchar(50)
declare @POMAlternatesID nvarchar(50)


select @POMTempGroupID=POMTempGroupID, @POMAlternatesID=POMAlternatesID from pGRMeasurementsPOMTemplateItem where POMTempItemID=@POMTempItemID


Begin
	IF @Linked = 0
		BEGIN
			UPDATE dbo.pGRMeasurementsPOMTemplateItem SET IsLinked=0 WHERE 
			POMTempGroupID=@POMTempGroupID and POMAlternatesID=@POMAlternatesID
		end
end


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02316'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02316', GetDate())
END	
GO 
