IF OBJECT_ID(N'[dbo].[vwx_GRMeasurementsPOMTemplate_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_GRMeasurementsPOMTemplate_SELECT]
GO

CREATE VIEW [dbo].[vwx_GRMeasurementsPOMTemplate_SELECT]
AS
SELECT t.POMTempID, t.POMTempGroupID, t.POMTempVersion, t.POMType, t.POMTypeDescription, 
       t.SpecSketchID, t.SpecSketchVersion, t.SizeClassId, t.SizeRangeId, t.ClassRangeId, 
	   t.SizeClass, t.SizeRange, t.ClassRange, t.SampleSize, 
	   STUFF((SELECT DISTINCT ', ' + d.Custom
			  FROM pGRMPOMTemplateDivisions td 
			  LEFT JOIN iCustom1 d ON d.CustomID = td.DivisionID
			  WHERE td.GRMPOMTemplateID = t.POMTempID
			  FOR XML PATH('')), 1, 1, '') AS Divisions,
	   t.CUser, t.CDate, t.MDate, t.MUser, t.Sort, t.Active, t.Linked
FROM pGRMeasurementsPOMTemplate t

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09262', GetDate())

GO
