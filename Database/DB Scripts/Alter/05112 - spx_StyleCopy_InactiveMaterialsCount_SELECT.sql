IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCopy_InactiveMaterialsCount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCopy_InactiveMaterialsCount_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCopy_InactiveMaterialsCount_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
)
AS 

SELECT COUNT(*) FROM pStyleMaterials pSM INNER JOIN pMaterial pM ON 
pSM.MaterialID = pM.MaterialID AND (pM.MaterialName LIKE '%tbd%' OR pM.Active = '0')
AND pSM.StyleID = @StyleID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05112', GetDate())
GO
