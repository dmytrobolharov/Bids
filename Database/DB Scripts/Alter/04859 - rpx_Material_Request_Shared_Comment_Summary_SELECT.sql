IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_Request_Shared_Comment_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_SELECT]
	@TradePartnerID VARCHAR(MAX)
AS
BEGIN
	SET @TradePartnerID = REPLACE(@TradePartnerID, ' ', '')

	SELECT
		mat.MaterialNo
		, mat.MaterialName
		, ct.ComponentDescription AS MaterialType
		, mat.MaterialType AS MaterialTypeID
		, mat.B AS MaterialContent
		, dbo.fnx_GetStreamingImagePath(mat.MaterialImageID, mat.MaterialImageVersion) AS MaterialImage
		, mtp.TradepartnerId
		, SUBSTRING(ISNULL('/' + tpm.AgentName, '') + ISNULL('/' + tpm.VendorName, '') + ISNULL('/' + tpm.FactoryName, ''), 2, 1000) AS TradeParnterName
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
		LEFT JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.RelationshipLevelID = mtp.TradePartnerRelationshipLevelID
		INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID
		INNER JOIN pMaterialRequestWorkflow mrw ON mrw.MaterialRequestWorkflowID = mrsw.MaterialRequestWorkflowID
	WHERE
		mrsc.MaterialRequestSubmitCommentType = 'S' AND
		mtp.TradePartnerRelationshipLevelID IN (
			SELECT
				TradePartnerRelationshipLevelID
			FROM
				vwx_TradePartnerRelationshipLevels_SEL tpl
			WHERE
				tpl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
				OR tpl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
				OR tpl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 
		)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04859', GetDate())
GO
