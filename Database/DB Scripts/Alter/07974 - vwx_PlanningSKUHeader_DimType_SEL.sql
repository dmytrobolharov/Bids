IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningSKUHeader_DimType_SEL]'))
DROP VIEW [dbo].[vwx_PlanningSKUHeader_DimType_SEL]
GO


CREATE VIEW [dbo].[vwx_PlanningSKUHeader_DimType_SEL]
AS

SELECT psh.DimTypeID
	, psh.PlanningSKUHeaderID
	, sbdt.DimTypeName
FROM dbo.pPlanningSKUHeaderDimType AS psh
INNER JOIN dbo.pStyleBOMDimType AS sbdt ON psh.DimTypeID = sbdt.DimTypeID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07974', GetDate())
GO
