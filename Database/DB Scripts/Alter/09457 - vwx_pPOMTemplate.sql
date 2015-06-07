IF OBJECT_ID(N'[dbo].[vwx_pPOMTemplate]') IS NOT NULL
 DROP VIEW [dbo].[vwx_pPOMTemplate]
GO

CREATE VIEW [dbo].[vwx_pPOMTemplate]
AS
SELECT POMTempID, POMTempGroupID, POMTempVersion, POMType, POMTypeDescription, SpecSketchID, SpecSketchVersion, 
       SizeClass, SizeRange, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, Size0, Size1, 
	   Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, 
	   Size17, Size18, Size19, CUser, CDate, MDate, MUser, Sort, 
       CASE WHEN POMTempActive = 0 THEN 'No' WHEN POMTempActive = 1 THEN 'Yes' END AS 'POMTempActive'
FROM pPOMTemplate


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09457', GetDate())
GO
