IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialSize_SEL]'))
DROP VIEW [dbo].[vwx_MaterialSize_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialSize_SEL]
AS
SELECT     '00000000-0000-0000-0000-000000000000' AS MaterialSizeID, '*NA' AS MaterialSize, '00000000-0000-0000-0000-000000000000' AS MaterialID, NULL AS Sort
UNION
SELECT     TOP (100) PERCENT CAST(MaterialSizeID AS VARCHAR(40)) AS MaterialSizeID, CAST(MaterialSize AS NVARCHAR(200)) AS MaterialSize, 
                      CAST(MaterialID AS VARCHAR(200)) AS MaterialID, Sort
FROM         dbo.pMaterialSize
ORDER BY Sort, MaterialSizeID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03852', GetDate())
GO
