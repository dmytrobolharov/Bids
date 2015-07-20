IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_Request_Shared_Comment_Summary_CUser_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_CUser_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_Request_Shared_Comment_Summary_CUser_SELECT]
(
	@TradePartnerID NVARCHAR(MAX)
)
AS
BEGIN

	DECLARE @tmpTradePartnerID TABLE (TradePartnerID UNIQUEIDENTIFIER)
	INSERT INTO @tmpTradePartnerID
	SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@TradePartnerID, ',')

	SELECT DISTINCT mrsc.CTeamID, mrsc.CUser
	FROM
		pMaterialRequestSubmitComment mrsc
		INNER JOIN pMaterialRequestSubmit mrs ON mrs.MaterialRequestSubmitID = mrsc.MaterialRequestSubmitID
		INNER JOIN pMaterialTradePartnerColor mtpc ON mrs.MaterialTradePartnerColorID = mtpc.MaterialTradePartnerColorID
		INNER JOIN pMaterialTradePartner mtp ON mrs.MaterialTradePartnerID = mtp.MaterialTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN @tmpTradePartnerID ttt ON ttt.TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
	WHERE
		mrsc.MaterialRequestSubmitCommentType = 'S'
	ORDER BY mrsc.CUser
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09108', GetDate())
GO
