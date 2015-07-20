/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT]    Script Date: 01/09/2013 16:11:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT]    Script Date: 01/09/2013 16:11:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitColor_NewTradePartner_PIVOT](
@MaterialTradePartnerID uniqueidentifier
)
AS 


SELECT f.MaterialTradePartnerColorID, g.MaterialTradePartnerId, j.MaterialID, 
      i.TradePartnerID, j.MaterialNo, j.MaterialName, 
      e.ColorCode, 
      f.ColorNo, 
      e.ColorName, 
      f.VendorColorCode, f.VendorColorNo, f.VendorColorName, 
      i.TradePartnerName, c.MaterialRequestWorkflowID,  
	  CAST(a.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) AS MaterialRequestSubmitWorkflowID, 
      --c.GroupName, c.GroupID,
	Case  
		WHEN f.MaterialColorImageID IS NULL  THEN 
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + '../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(f.ColorFolderID AS VARCHAR(40)) + 
			'&CPID=' + CAST(f.ColorPaletteID AS VARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
		 ELSE  
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + '../System/Control/ImageStream.ashx?S=16&V=' + CAST(f.MaterialColorImageVersion AS VARCHAR(40)) + 
			'&IID=' + CAST(f.MaterialColorImageID AS VARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
	END AS ColorUrl, ISNULL(k.MaterialSize,'*NA') AS MaterialSize 


INTO #tmpMaterialRequestSubmitWorkflow
FROM pMaterialRequestSubmitWorkflow a
INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID = b.MaterialTradePartnerId 
INNER JOIN pMaterialRequestWorkflow c ON c.MaterialRequestWorkflowID = a.MaterialRequestWorkflowID
INNER JOIN pMaterialColor d ON d.MaterialColorID = a.MaterialColorID
INNER JOIN pColorPalette e ON e.ColorPaletteID = d.ColorPaletteID 
INNER JOIN pMaterialTradePartnerColor f ON f.MaterialTradePartnerColorID = a.MaterialTradePartnerColorID
INNER JOIN pMaterialTradePartner g ON g.MaterialTradePartnerId =  f.MaterialTradePartnerID
INNER JOIN uTradePartner i ON i.TradepartnerId = b.TradePartnerID 
INNER JOIN pMaterial j ON j.MaterialID = a.MaterialID
LEFT OUTER JOIN pMaterialSize k ON k.MaterialSizeID = f.MaterialSizeID
WHERE a.MaterialTradePartnerId = @MaterialTradePartnerId
ORDER BY i.TradePartnerName, e.ColorCode



EXECUTE spx_Crosstab 
'SELECT * FROM #tmpMaterialRequestSubmitWorkflow',
NULL,
NULL,
'MaterialRequestWorkflowID',
'MaterialRequestSubmitWorkflowID',
'MAX'



DROP TABLE #tmpMaterialRequestSubmitWorkflow

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04729', GetDate())
GO
