IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerRelationship_ADD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerRelationship_ADD]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerRelationship_ADD] 
(   
	@TradePartnerMasterID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime
)
AS



BEGIN

INSERT INTO uTradePartnerRelationship (TradePartnerMasterID, TradePartnerID, CUser, CDate) 
VALUES  (@TradePartnerMasterID, @TradePartnerID, @CUser, @CDate)

                      
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03355'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03355', GetDate())

END

GO
