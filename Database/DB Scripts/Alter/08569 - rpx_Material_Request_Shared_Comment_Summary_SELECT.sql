IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_Request_Shared_Comment_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_SELECT]
	@TradePartnerID nVARCHAR(MAX)
	, @CUser nVARCHAR(MAX)
	, @WorkflowID nVARCHAR(MAX)
AS
BEGIN

	DECLARE @tmpCUser TABLE (TeamID UNIQUEIDENTIFIER)
	INSERT INTO @tmpCUser
	SELECT CAST(value AS UNIQUEIDENTIFIER) FROM dbo.fnx_Split(@CUser, ',')

	DECLARE @tmpTradePartnerID TABLE (TradePartnerRelationshipLevelID UNIQUEIDENTIFIER)
	INSERT INTO @tmpTradePartnerID
	SELECT DISTINCT(tpl.TradePartnerRelationshipLevelID) FROM dbo.fnx_Split(@TradePartnerID, ',')
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tpl ON CAST(value AS UNIQUEIDENTIFIER) IN (tpl.AgentID, tpl.VendorID, tpl.FactoryID)

	DECLARE @tmpWorkflowID TABLE (WorkflowID nVARCHAR(10))
	INSERT INTO @tmpWorkflowID
	SELECT value FROM dbo.fnx_Split(@WorkflowID, ',')

	SELECT
		mat.MaterialNo
		, mat.MaterialName
		, ct.ComponentDescription AS MaterialType
		, mat.MaterialType AS MaterialTypeID
		, mat.B AS MaterialContent
		, dbo.fnx_GetStreamingImagePath(mat.MaterialImageID, mat.MaterialImageVersion) AS MaterialImage
		, mtp.TradepartnerId
		, tpm.TradePartnerFullName AS TradeParnterName
		, mtpc.ColorName
		, mrw.MaterialRequestWorkflow
		, mrs.Submit
		, mrsc.CUser
		, mrsc.CDate
		, mrsc.MaterialRequestSubmitComment
		, CASE WHEN EXISTS (SELECT * FROM Users u WHERE u.TeamID = mrsc.CTeamID) THEN 0 ELSE 1 END AS IsSrmOn
		, mat.MaterialID
		, mrw.MaterialRequestWorkflowID
		, mrs.MaterialTradePartnerID
		, mrs.MaterialTradePartnerColorID
	FROM
		pMaterialRequestSubmitComment mrsc
		INNER JOIN pMaterialRequestSubmit mrs ON mrs.MaterialRequestSubmitID = mrsc.MaterialRequestSubmitID
		INNER JOIN pMaterialTradePartnerColor mtpc ON mrs.MaterialTradePartnerColorID = mtpc.MaterialTradePartnerColorID
		INNER JOIN pMaterialTradePartner mtp ON mrs.MaterialTradePartnerID = mtp.MaterialTradePartnerID
		INNER JOIN pMaterial mat ON mtpc.MaterialID = mat.MaterialID
		INNER JOIN pComponentType ct ON mat.MaterialType = ct.ComponentTypeID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON tpm.TradePartnerRelationshipLevelID = mtp.TradePartnerRelationshipLevelID
		INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID
		INNER JOIN pMaterialRequestWorkflow mrw ON mrw.MaterialRequestWorkflowID = mrsw.MaterialRequestWorkflowID
		INNER JOIN @tmpCUser tcu ON mrsc.CTeamID = tcu.TeamID
		INNER JOIN @tmpTradePartnerID ttp ON mtp.TradePartnerRelationshipLevelID = ttp.TradePartnerRelationshipLevelID
		INNER JOIN @tmpWorkflowID tw ON mrw.MaterialRequestWorkflowID = tw.WorkflowID
	WHERE
		mrsc.MaterialRequestSubmitCommentType = 'S'
	ORDER BY mrsc.CDate DESC
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08569', GetDate())
GO