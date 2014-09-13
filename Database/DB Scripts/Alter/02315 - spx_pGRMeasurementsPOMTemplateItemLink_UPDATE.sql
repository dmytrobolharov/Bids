IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemLink_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLink_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowTemplateItem_INSERT]    Script Date: 12/15/2011 17:15:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLink_UPDATE]
(@POMTempItemID uniqueidentifier, @Linked int)
AS 

declare @POMTempGroupID nvarchar(50)
declare @POMAlternatesID nvarchar(50)


select @POMTempGroupID=POMTempGroupID, @POMAlternatesID=POMAlternatesID from pGRMeasurementsPOMTemplateItem where POMTempItemID=@POMTempItemID


Begin
	IF @Linked = 1
		BEGIN
			--UPDATE dbo.pGRMeasurementsPOMTemplateItem SET IsLinked=1 WHERE POMTempItemID = @POMTempItemID			
			update pGRMeasurementsPOMTemplateItem set active=1, IsLinked=1, POMCode=a.POMCode, POMDesc=a.POMDesc, AlternatesCode=a.AlternatesCode, AlternatesDesc=a.AlternatesDesc,
			AlternatesSort=a.AlternateSort,AlternatesId=a.AlternatesId, POMID=a.Pomid,
			ImageId=a.ImageId, How2MeasName=a.How2MeasName, How2MeasText=a.How2MeasText
			from pGRMeasurementsPOMTemplateItem p INNER JOIN pGRMeasurementsPOMAlternates a ON p.POMAlternatesID = a.POMAlternatesId
			where POMTempGroupID=@POMTempGroupID and p.POMAlternatesID=@POMAlternatesID
		end
end

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02315'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02315', GetDate())
END	
GO 
