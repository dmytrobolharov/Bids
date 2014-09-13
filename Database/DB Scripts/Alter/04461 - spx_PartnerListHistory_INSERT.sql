IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PartnerListHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PartnerListHistory_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_PartnerListHistory_INSERT]
(@TradePartnerID uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pPartnerListHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND TradePartnerID = @TradePartnerID) = 0
	BEGIN
		INSERT INTO pPartnerListHistory  (TradePartnerID, TeamID, CDate) VALUES ( @TradePartnerID, @TeamID, @CreatedDate)
	END
Else
	BEGIN
		UPDATE pPartnerListHistory SET  CDate = @CreatedDate WHERE TradePartnerID = @TradePartnerID AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pPartnerListHistory WHERE TeamID = @TeamID AND  TradePartnerID NOT IN (SELECT TOP 9 TradePartnerID From pPartnerListHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04461', GetDate())
GO
