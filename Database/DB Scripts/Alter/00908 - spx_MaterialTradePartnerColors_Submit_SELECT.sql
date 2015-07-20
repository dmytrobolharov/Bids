IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColors_Submit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColors_Submit_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerColors_Submit_SELECT](@MaterialTradePartnerID UNIQUEIDENTIFIER, @MaterialRequestWorkflowID NVARCHAR(50))  
AS   
SELECT DISTINCT c.MaterialTradePartnerColorID , d.ColorName AS MaterialColor
FROM pMaterialRequestSubmitWorkflow a
      INNER JOIN pMaterialRequestWorkflow b ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID 
      INNER JOIN dbo.pMaterialTradePartnerColor c ON c.MaterialTradePartnerColorID = a.MaterialTradePartnerColorID
      INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = c.ColorPaletteID
WHERE c.MaterialTradePartnerID = @MaterialTradePartnerID
AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
ORDER BY d.ColorName 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '908', GetDate())

GO



