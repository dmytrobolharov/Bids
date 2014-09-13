IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemSort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemSort_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowTemplateItem_INSERT]    Script Date: 12/15/2011 17:15:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemSort_UPDATE]
(@POMTempItemID uniqueidentifier, 
@POMSort nvarchar(5))
AS 

declare @POMTempGroupID nvarchar(50)
declare @POMAlternatesID nvarchar(50)

select @POMTempGroupID=POMTempGroupID, @POMAlternatesID=COALESCE(POMAlternatesID,'00000000-0000-0000-0000-000000000000') from pGRMeasurementsPOMTemplateItem where POMTempItemID=@POMTempItemID

if @POMAlternatesID	<> '00000000-0000-0000-0000-000000000000'
	Begin	
		UPDATE dbo.pGRMeasurementsPOMTemplateItem SET Sort = @POMSort, POMSort = @POMSort
		WHERE POMTempGroupID=@POMTempGroupID and POMAlternatesID=@POMAlternatesID			
	end
else
	BEGIN 
		UPDATE dbo.pGRMeasurementsPOMTemplateItem SET Sort = @POMSort, POMSort = @POMSort
		WHERE POMTempItemID=@POMTempItemID		
	END



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02320'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02320', GetDate())
END	
GO 
