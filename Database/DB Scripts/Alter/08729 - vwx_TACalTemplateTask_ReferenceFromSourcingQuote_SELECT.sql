/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]    Script Date: 08/11/2014 15:09:18 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]'))
DROP VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]
GO

/****** Object:  View [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]    Script Date: 08/11/2014 15:09:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT]
AS
	SELECT crt.TACalRefTaskId, 'Quotation' as RefType, sqi.StyleQuoteItemID, tw.WorkflowId, ct.SeasonYearId,
	sqi.StyleQuoteItemNo, sh.StyleID, sh.StyleNo, sh.[Description], sh.StyleType, sh.StyleCategory, sh.DivisionID, 
	div.Custom AS DivisionName, sh.SizeClass, sh.SizeRange, 
	shi.SourcingHeaderID, shi.SourcingType, shi.SourcingName,
	sqi.ActualStart, sqi.ActualEnd, crt.TaskRevisedlStart, crt.TaskRevisedEnd,
	crt.TACalTemplateTaskId, sqi.WorkAssignedTo, sqi.StyleQuoteItemStatusId AS WorkStatus, sqis.Custom AS WorkStatusName, 
	tpm.AgentID, tpm.AgentName, tpm.VendorID, tpm.VendorName, tpm.FactoryID, tpm.FactoryName
	from pTACalReferenceTask crt
	INNER JOIN pTACalReference cr ON crt.TACalReferenceId = cr.TACalReferenceId
	INNER JOIN pStyleQuoteItem sqi ON sqi.StyleQuoteItemID = cr.ReferenceId
	INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId 
	INNER JOIN pSourcingHeader shi ON sqi.SourcingHeaderID = shi.SourcingHeaderID
	INNER JOIN pStyleHeader sh ON sh.StyleID = sqi.StyleID 
	INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
	INNER JOIN pTACalTemplateTask ctt ON ctt.TACalTemplateTaskId = crt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = ctt.TaskWorkflowId
	INNER JOIN iCustom1 div ON div.CustomID = sh.DivisionID
	INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID 
	INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.TradePartnerID = stp.TradePartnerID AND tpm.RelationshipLevelID = stp.TradePartnerLevelID
	INNER JOIN dbo.sPermissionFolderType AS pf ON pf.PermissionFolderTypeId = cr.TACalReferenceTypeId AND LOWER(pf.PermissionFolderTypeName) = LOWER('Sourcing Folder')


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08729', GetDate())
GO
