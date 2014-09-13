IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderSKUHeader_DimType_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderSKUHeader_DimType_SEL]
GO

CREATE VIEW [dbo].[vwx_LineFolderSKUHeader_DimType_SEL]
AS

SELECT lfsh.DimTypeID
	, lfsh.LineFolderSKUHeaderID
	, sbdt.DimTypeName
FROM dbo.pLineFolderSKUHeaderDimType AS lfsh
INNER JOIN dbo.pStyleBOMDimType AS sbdt ON lfsh.DimTypeID = sbdt.DimTypeID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08119', GetDate())
GO
