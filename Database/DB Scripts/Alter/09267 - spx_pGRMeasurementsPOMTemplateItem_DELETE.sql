IF OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItem_DELETE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItem_DELETE]
(@POMTempItemID UNIQUEIDENTIFIER)
AS 
  DECLARE @POMTempGroupID UNIQUEIDENTIFIER
  DECLARE @POMTempItemGroupID UNIQUEIDENTIFIER
BEGIN
  SELECT @POMTempGroupID = POMTempGroupID, @POMTempItemGroupID = POMTempItemGroupID
  FROM dbo.pGRMeasurementsPOMTemplateItem 
  WHERE POMTempItemID = @POMTempItemID

  IF @POMTempItemGroupID IS NOT NULL
    BEGIN
      -- delete only if all items in group is not linked
      IF NOT EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateItem i
	                INNER JOIN pAMLMeasPOM ui ON ui.GRPOMCompanyId = i.POMTempItemID
	                WHERE i.POMTempGroupID = @POMTempGroupID AND i.POMTempItemGroupID = @POMTempItemGroupID) AND
        NOT EXISTS(SELECT * FROM pGRMeasurementsPOMTemplateItem i
	                INNER JOIN pSampleRequestAMLMeasPOM ui ON ui.GRPOMCompanyId = i.POMTempItemID
	                WHERE i.POMTempGroupID = @POMTempGroupID AND i.POMTempItemGroupID = @POMTempItemGroupID)
	    DELETE FROM pGRMeasurementsPOMTemplateItem 
	    WHERE POMTempGroupID = @POMTempGroupID AND POMTempItemGroupID = @POMTempItemGroupID
    END 
  ELSE
    -- delete only if item is not linked
    IF NOT EXISTS(SELECT * FROM pAMLMeasPOM WHERE GRPOMCompanyId = @POMTempItemID) AND
	   NOT EXISTS(SELECT * FROM pSampleRequestAMLMeasPOM WHERE GRPOMCompanyId = @POMTempItemID)
	  DELETE FROM pGRMeasurementsPOMTemplateItem 
	  WHERE POMTempItemID = @POMTempItemID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09267', GetDate())

GO


