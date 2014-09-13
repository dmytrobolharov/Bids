/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowStatus_SELECT]    Script Date: 07/02/2014 13:24:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowStatus_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowStatus_SELECT]    Script Date: 07/02/2014 13:24:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowStatus_SELECT](
@MaterialId	 UNIQUEIDENTIFIER,
@PrefLanguage NVARCHAR (50) = NULL,
@TeamID UNIQUEIDENTIFIER = NULL
) AS 

DECLARE @MaterialTypeID INT
SELECT @MaterialTypeID = MaterialType FROM pMaterial WHERE MaterialID = @MaterialId

IF @TeamID IS NULL
BEGIN
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
		<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + 
		CAST (pMaterialTradePartner.MaterialTradePartnerId AS nVARCHAR(40)) 
			+ '&MRSWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS nVARCHAR(40)) 
			+ '&MTPCID=' + CAST(pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) 
			+ '&MRWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS nVARCHAR(40)) +
			+ '&TB=' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(40)) +
		''',''' +  
		Replace(CAST (pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) , '-', '') +
		''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
		+
		CASE 
			WHEN pMaterialRequestSubmitItemStatus.ApprovedType = 1 THEN
			CASE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
				WHEN CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107) THEN
					CASE UPPER(@PrefLanguage)
							WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'FR-CA'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'KO-KR'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PL-PL'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'SV-SE'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 101)
							ELSE CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 103)
					END
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')	
			END	
			--ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
			--ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)	
			WHEN pMaterialRequestSubmitItemStatus.StatusID = 4 THEN
			CASE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
				WHEN CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107) THEN
					CASE UPPER(@PrefLanguage)
							WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'FR-CA'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'KO-KR'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PL-PL'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'SV-SE'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 101)
							ELSE CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 103)
					END
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')	
			END	
			ELSE
			CASE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE')
				WHEN CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107) THEN
					CASE UPPER(@PrefLanguage)
							WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'FR-CA'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 104)
							WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'KO-KR'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'PL-PL'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 104)
							WHEN  'SV-SE'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 104)
							WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 101)
							ELSE CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 103)
					END
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE')	
			END	
		END 
		
		
		+ '&nbsp;<b>(' 
		+  CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(5)) + ')</b></a></TD></TR></TABLE>' AS Link
	FROM  pMaterialTradePartnerColor INNER JOIN
	  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
	  pMaterialRequestSubmitWorkflow ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID INNER JOIN
	  pMaterialRequestSubmitItemStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitItemStatus.StatusID
	WHERE pMaterialTradePartner.MaterialId = @MaterialId
	UNION ALL
	SELECT NULL AS MaterialTradePartnerColorId, NULL AS MaterialTradePartnerId, NULL AS MaterialRequestSubmitWorkflowId, NULL AS MaterialRequestWorkflowID, 
	NULL AS StatusID, NULL AS [Status], NULL  AS Submit, NULL AS DueDate, NULL AS EndDate , NULL AS ApprovedType, '<div align=''center''>-------</div>'AS Link
END
ELSE
BEGIN
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
		+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; '
		+ 
		CASE WHEN ISNULL(access.PermissionRoleId, 0) > 0 THEN
			'<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + 
			CAST (pMaterialTradePartner.MaterialTradePartnerId AS nVARCHAR(40)) 
				+ '&MRSWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS nVARCHAR(40)) 
				+ '&MTPCID=' + CAST(pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) 
				+ '&MRWID=' + CAST(pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID AS nVARCHAR(40)) +
				+ '&TB=' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(40)) +
			''',''' +  
			Replace(CAST (pMaterialTradePartnerColor.MaterialTradePartnerColorID AS nVARCHAR(40)) , '-', '') +
			''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'
		ELSE
			''
		END
		+
		CASE 
			WHEN pMaterialRequestSubmitItemStatus.ApprovedType = 1 THEN
			CASE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
				WHEN CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107) THEN
					CASE UPPER(@PrefLanguage)
							WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'FR-CA'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'KO-KR'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PL-PL'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'SV-SE'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 101)
							ELSE CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 103)
					END
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')	
			END	
			--ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
			--ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)	
			WHEN pMaterialRequestSubmitItemStatus.StatusID = 4 THEN
			CASE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')
				WHEN CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107) THEN
					CASE UPPER(@PrefLanguage)
							WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'FR-CA'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 111)
							WHEN  'KO-KR'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PL-PL'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'SV-SE'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.EndDate) AS nvarchar(4) )
							WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 105)
							WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 104)
							WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 101)
							ELSE CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.EndDate , 103)
					END
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.EndDate , 107),'NODATE')	
			END	
			ELSE
			CASE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE')
				WHEN CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107) THEN
					CASE UPPER(@PrefLanguage)
							WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'FR-CA'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 104)
							WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 111)
							WHEN  'KO-KR'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'PL-PL'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 104)
							WHEN  'SV-SE'  THEN cast( YEAR(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( MONTH(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) ) + '-' +cast( DAY(pMaterialRequestSubmitWorkflow.DueDate) AS nvarchar(4) )
							WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 105)
							WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 104)
							WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 101)
							ELSE CONVERT ( NVARCHAR(50), pMaterialRequestSubmitWorkflow.DueDate , 103)
					END
				ELSE ISNULL(CONVERT(VARCHAR(12), pMaterialRequestSubmitWorkflow.DueDate , 107),'NODATE')	
			END	
		END 
		
		
		+ '&nbsp;<b>(' 
		+  CAST(pMaterialRequestSubmitWorkflow.Submit AS nVARCHAR(5)) + ')</b>' 
		+ 
		CASE WHEN ISNULL(access.PermissionRoleId, 0) > 0 THEN
			'</a>'
		ELSE
			''
		END
		+ '</TD></TR></TABLE>' AS Link
	FROM  pMaterialTradePartnerColor INNER JOIN
	  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
	  pMaterialRequestSubmitWorkflow ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID INNER JOIN
	  pMaterialRequestSubmitItemStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitItemStatus.StatusID INNER JOIN
	  pMaterialRequestWorkflow ON pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID LEFT JOIN 
	  fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 24, @MaterialTypeID) access ON access.WorkflowId = pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID
	WHERE pMaterialTradePartner.MaterialId = @MaterialId
	UNION ALL
	SELECT NULL AS MaterialTradePartnerColorId, NULL AS MaterialTradePartnerId, NULL AS MaterialRequestSubmitWorkflowId, NULL AS MaterialRequestWorkflowID, 
	NULL AS StatusID, NULL AS [Status], NULL  AS Submit, NULL AS DueDate, NULL AS EndDate , NULL AS ApprovedType, '<div align=''center''>-------</div>'AS Link
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08182', GetDate())
GO
