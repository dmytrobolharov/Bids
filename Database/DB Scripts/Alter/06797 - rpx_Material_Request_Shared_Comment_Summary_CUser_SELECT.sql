IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_Request_Shared_Comment_Summary_CUser_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_CUser_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_CUser_SELECT]
(
	@TradePartnerID nVARCHAR(MAX)
)
AS
BEGIN

	SELECT DISTINCT mrsc.CTeamID, mrsc.CUser
	FROM
		pMaterialRequestSubmitComment mrsc
		INNER JOIN pMaterialRequestSubmit mrs ON mrs.MaterialRequestSubmitID = mrsc.MaterialRequestSubmitID
		INNER JOIN pMaterialTradePartnerColor mtpc ON mrs.MaterialTradePartnerColorID = mtpc.MaterialTradePartnerColorID
		INNER JOIN pMaterialTradePartner mtp ON mrs.MaterialTradePartnerID = mtp.MaterialTradePartnerID
	WHERE
		mrsc.MaterialRequestSubmitCommentType = 'S'
		AND mtp.TradePartnerRelationshipLevelID IN (
			SELECT
				TradePartnerRelationshipLevelID
			FROM
				vwx_TradePartnerRelationshipLevels_SEL tpl
			WHERE
				tpl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
				OR tpl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
				OR tpl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 
		)
	ORDER BY mrsc.CUser
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06797', GetDate())
GO