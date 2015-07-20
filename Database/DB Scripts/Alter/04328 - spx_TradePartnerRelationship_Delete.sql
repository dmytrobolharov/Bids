IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerRelationship_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerRelationship_Delete]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_TradePartnerRelationship_Delete]
(
	@TradePartnerMasterID uniqueidentifier,
	@TradePartnerRelationshipID uniqueidentifier
)
AS 
BEGIN

	DELETE FROM uTradePartnerRelationship WHERE TradePartnerRelationshipID = @TradePartnerRelationshipID

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04328', GetDate())
GO
