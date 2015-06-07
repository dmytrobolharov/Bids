IF OBJECT_ID(N'[dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeasTemplate_SizeClasses_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@AMLMeasHdrID UNIQUEIDENTIFIER
AS
BEGIN
  
  SET NOCOUNT ON;

  SELECT DISTINCT tg.SizeClassId, sc.Custom AS SizeClass
  FROM pAMLMeasHdr mh
  INNER JOIN pGRMeasurementsPOMTemplate t ON t.POMTempID = mh.CompanyId 
  INNER JOIN pGRMeasurementsPOMTemplate tg ON tg.POMTempGroupID = t.POMTempGroupID
  LEFT JOIN pSizeClass sc ON sc.CustomID = tg.SizeClassId
  WHERE mh.AMLMeasHdrID = @AMLMeasHdrID AND
        NOT EXISTS(SELECT * FROM pStyleDevelopmentItem sdi
                   INNER JOIN pStyleHeader sh ON sh.DevelopmentID = sdi.StyleDevelopmentID
                   WHERE sdi.StyleID = mh.StyleID AND sh.SizeClassId = tg.SizeClassId)
  ORDER BY sc.Custom
    
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09988', GetUTCDate())
GO
