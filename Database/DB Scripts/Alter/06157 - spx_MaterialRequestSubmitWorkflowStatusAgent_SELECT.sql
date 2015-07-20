IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowStatusAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowStatusAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowStatusAgent_SELECT](
	@TradePartnerId UNIQUEIDENTIFIER 
) AS 

SELECT pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialTradePartnerColor.MaterialTradePartnerColorID,  
   pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID, pMaterialTradePartner.MaterialTradePartnerId,
  pMaterialRequestSubmitItemStatus.StatusID, pMaterialRequestSubmitItemStatus.Status, pMaterialRequestSubmitWorkflow.Submit, 
  pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate, pMaterialRequestSubmitItemStatus.ApprovedType,
	'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
	<IMG src=''' + 
	CASE 
		WHEN pMaterialRequestSubmitItemStatus.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
		WHEN pMaterialRequestSubmitItemStatus.StatusID = 4  THEN '../System/Icons/icon_ball_red.gif'
		WHEN pMaterialRequestSubmitWorkflow.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
		ELSE '../System/Icons/icon_ball_yellow.gif'
	END
	+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
	<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' 
	+ CAST (pMaterialTradePartner.MaterialTradePartnerId AS VARCHAR(40)) 
	+ '&MRSWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) 
	+ '&MTPCID=' + CAST(pMaterialTradePartnerColor.MaterialTradePartnerColorID AS VARCHAR(40)) 
	+ '&MRWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS VARCHAR(40))
	+ '&TB=' + CAST(pMaterialRequestSubmitWorkflow.Submit AS VARCHAR(5))
	+ ''',''' +  
	Replace(CAST (pMaterialTradePartnerColor.MaterialTradePartnerColorID AS VARCHAR(40)) , '-', '') +
	''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
	+
	CASE 
		WHEN pMaterialRequestSubmitItemStatus.ApprovedType = 1 Or pMaterialRequestSubmitItemStatus.StatusID = 4 THEN ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
		ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)
	END 
	+ '&nbsp;<b>(' 
	+  CAST(pMaterialRequestSubmitWorkflow.Submit AS VARCHAR(5)) + ')</b></a></TD></TR></TABLE>' AS Link
FROM  pMaterialTradePartnerColor INNER JOIN
  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
  pMaterialRequestSubmitWorkflow ON 
  pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID INNER JOIN
  pMaterialRequestSubmitItemStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitItemStatus.StatusID
  LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pMaterialTradePartner.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE pMaterialTradePartner.TradePartnerId = @TradePartnerId OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
UNION ALL
SELECT NULL AS MaterialTradePartnerColorId, NULL AS MaterialTradePartnerId, NULL AS MaterialRequestSubmitWorkflowId, NULL AS MaterialRequestWorkflowID, 
NULL AS StatusID, NULL AS [Status], NULL  AS Submit, NULL AS DueDate, NULL AS EndDate , NULL AS ApprovedType, '<div align=''center''>-------</div>'AS Link

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06157', GetDate())
GO
