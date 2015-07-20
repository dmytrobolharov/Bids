

ALTER PROCEDURE [dbo].[spx_MaterialTradePartnerColors_Submit_SELECT](@MaterialTradePartnerID UNIQUEIDENTIFIER, @MaterialRequestWorkflowID NVARCHAR(50))  
AS   
SELECT c.MaterialTradePartnerColorID, ISNULL(d.ColorName, d.ColorCode) + ' / ' + ISNULL(pMaterialSize.MaterialSize, '*NA') AS MaterialColor
FROM  pMaterialRequestSubmitWorkflow AS a INNER JOIN
      pMaterialRequestWorkflow AS b ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID INNER JOIN
      pMaterialTradePartnerColor AS c ON c.MaterialTradePartnerColorID = a.MaterialTradePartnerColorID INNER JOIN
      pColorPalette AS d ON d.ColorPaletteID = c.ColorPaletteID INNER JOIN
      pMaterialSize ON c.MaterialSizeID = pMaterialSize.MaterialSizeID
WHERE c.MaterialTradePartnerID = @MaterialTradePartnerID
AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
ORDER BY d.ColorName 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '954', GetDate())
GO