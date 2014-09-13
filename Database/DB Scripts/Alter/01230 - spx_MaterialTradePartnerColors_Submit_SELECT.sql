IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColors_Submit_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColors_Submit_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerColors_Submit_SELECT](
	@MaterialTradePartnerID UNIQUEIDENTIFIER, 
	@MaterialRequestWorkflowID NVARCHAR(50)
)  
AS   

SELECT c.MaterialTradePartnerColorID, 
	ISNULL(d.ColorName, d.ColorCode) + ' / ' + ISNULL(e.MaterialSize, '*NA') AS MaterialColor
FROM  pMaterialRequestSubmitWorkflow a WITH(NOLOCK)
	INNER JOIN pMaterialRequestWorkflow b WITH(NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID 
	INNER JOIN pMaterialTradePartnerColor c WITH(NOLOCK) ON c.MaterialTradePartnerColorID = a.MaterialTradePartnerColorID 
	INNER JOIN pColorPalette d WITH(NOLOCK) ON d.ColorPaletteID = c.ColorPaletteID 
	LEFT OUTER JOIN pMaterialSize e WITH(NOLOCK) ON e.MaterialSizeID = c.MaterialSizeID
WHERE c.MaterialTradePartnerID = @MaterialTradePartnerID
AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
ORDER BY d.ColorName 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01230', GetDate())
GO
