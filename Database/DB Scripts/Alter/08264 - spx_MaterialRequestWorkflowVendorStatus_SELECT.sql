IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflowVendorStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflowVendorStatus_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflowVendorStatus_SELECT](
	@MaterialTradePartnerId UNIQUEIDENTIFIER,
	@SharedOnly INT = 1,
	@TeamID UNIQUEIDENTIFIER = NULL,
	@TradePartnerID UNIQUEIDENTIFIER = NULL
) AS 
BEGIN

	DECLARE @MaterialTypeID INT
	SELECT @MaterialTypeID = mat.MaterialType FROM pMaterialTradePartner mtp 
	INNER JOIN pMaterial mat ON mat.MaterialID = mtp.MaterialId 
	WHERE mtp.MaterialTradePartnerId = @MaterialTradePartnerId

	IF @TeamID IS NULL AND @TradePartnerID IS NOT NULL
	BEGIN
		
		SELECT pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialTradePartnerColor.MaterialTradePartnerColorID,  
		   pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID, pMaterialTradePartner.MaterialTradePartnerId,
		  pMaterialRequestSubmitStatus.StatusID, pMaterialRequestSubmitStatus.Status, pMaterialRequestSubmitWorkflow.Submit, 
		  pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate, pMaterialRequestSubmitStatus.ApprovedType,
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon 
			+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
			<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + CAST (pMaterialTradePartner.MaterialTradePartnerId AS nVARCHAR(40)) 
			+ '&MRSWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS nVARCHAR(40)) 
			+ '&MTPCID=' + CAST(pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) 
			+ '&MRWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS nVARCHAR(40)) 
			+ '&TB=' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(5)) 
			+ ''',''' +  
			Replace(CAST (pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) , '-', '') +
			''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
			+
			CASE 
				WHEN pMaterialRequestSubmitStatus.ApprovedType = 1 Or pMaterialRequestSubmitStatus.StatusID = 4 THEN ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)
			END 
			+ '&nbsp;<b>(' 
			+  CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(5)) + ')</b></a></TD></TR></TABLE>' AS Link
		FROM pMaterialTradePartnerColor
		INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId
		INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
		LEFT JOIN pMaterialRequestSubmitWorkflowShare ON pMaterialRequestSubmitWorkflowShare.TradePartnerID = @TradePartnerID
			AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflowShare.MaterialRequestSubmitWorkflowID
		INNER JOIN pMaterialRequestSubmitStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitStatus.StatusID
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerId = @MaterialTradePartnerId
			AND CASE WHEN pMaterialRequestSubmitWorkflowShare.MaterialRequestSubmitWorkflowID IS NULL THEN 0 ELSE @SharedOnly END = @SharedOnly
		UNION ALL
		SELECT NULL AS MaterialTradePartnerColorId, NULL AS MaterialTradePartnerId, NULL AS MaterialRequestSubmitWorkflowId, NULL AS MaterialRequestWorkflowID, 
		NULL AS StatusID, NULL AS [Status], NULL  AS Submit, NULL AS DueDate, NULL AS EndDate , NULL AS ApprovedType, '<div align=''center''>-------</div>'AS Link
	END
	ELSE
	BEGIN
		SELECT pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialTradePartnerColor.MaterialTradePartnerColorID,  
		   pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID, pMaterialTradePartner.MaterialTradePartnerId,
		  pMaterialRequestSubmitStatus.StatusID, pMaterialRequestSubmitStatus.Status, pMaterialRequestSubmitWorkflow.Submit, 
		  pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate, pMaterialRequestSubmitStatus.ApprovedType,
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon 
			+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; ' +
			CASE 
			WHEN ISNULL(access.PermissionRoleId, 0) > 0 THEN
				'<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + CAST (pMaterialTradePartner.MaterialTradePartnerId AS nVARCHAR(40)) 
				+ '&MRSWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS nVARCHAR(40)) 
				+ '&MTPCID=' + CAST(pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) 
				+ '&MRWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS nVARCHAR(40)) 
				+ '&TB=' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(5)) 
				+ ''',''' +  
				Replace(CAST (pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) , '-', '') +
				''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'
			ELSE 
				''
			END
			+
			CASE 
				WHEN pMaterialRequestSubmitStatus.ApprovedType = 1 Or pMaterialRequestSubmitStatus.StatusID = 4 THEN ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)
			END 
			+ '&nbsp;<b>(' 
			+  CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(5)) + ')</b>' + 
			CASE 
			WHEN ISNULL(access.PermissionRoleId, 0) > 0 THEN
				'</a>' 
			ELSE
				''
			END
			+ '</TD></TR></TABLE>' AS Link
		FROM pMaterialTradePartnerColor
		INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId
		INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
		LEFT JOIN pMaterialRequestSubmitWorkflowShare ON pMaterialRequestSubmitWorkflow.TradePartnerID = pMaterialRequestSubmitWorkflowShare.TradePartnerID
			AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflowShare.MaterialRequestSubmitWorkflowID
		INNER JOIN pMaterialRequestSubmitStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitStatus.StatusID
		INNER JOIN pMaterialRequestWorkflow ON pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
		INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 24, @MaterialTypeID) access ON access.WorkflowId = pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID 
		WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerId = @MaterialTradePartnerId
			AND CASE WHEN pMaterialRequestSubmitWorkflowShare.MaterialRequestSubmitWorkflowID IS NULL THEN 0 ELSE @SharedOnly END = @SharedOnly
		UNION ALL
		SELECT NULL AS MaterialTradePartnerColorId, NULL AS MaterialTradePartnerId, NULL AS MaterialRequestSubmitWorkflowId, NULL AS MaterialRequestWorkflowID, 
		NULL AS StatusID, NULL AS [Status], NULL  AS Submit, NULL AS DueDate, NULL AS EndDate , NULL AS ApprovedType, '<div align=''center''>-------</div>'AS Link
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08264', GetDate())
GO
