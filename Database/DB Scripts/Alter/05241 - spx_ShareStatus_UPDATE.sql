/****** Object:  StoredProcedure [dbo].[spx_ShareStatus_UPDATE]    Script Date: 03/06/2013 11:59:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ShareStatus_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_ShareStatus_UPDATE]    Script Date: 03/06/2013 11:59:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_ShareStatus_UPDATE]
(
	@QuoteItemID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@IsADD bit,
	@MUser nvarchar(200),
	@MDate datetime
)
AS 

BEGIN

IF @IsADD = 1
	BEGIN 
		IF (SELECT COUNT(*) FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID AND TradePartnerId = @TradePartnerID) = 0
		INSERT INTO pStyleQuoteItemShare(StyleQouteItemID, TradePartnerId, MUser, MDate) VALUES(@QuoteItemID, @TradePartnerID, @MUser, @MDate)
	END
ELSE
	BEGIN
		DELETE FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID AND TradePartnerId = @TradePartnerID
	END
END

--update share status of quote and commitment
Declare 
@SharedCount integer,
@IsShared integer

SELECT @SharedCount=COUNT(*) FROM pStyleQuoteItemShare WHERE StyleQouteItemID = @QuoteItemID

IF @SharedCount = 0 begin
			SET @IsShared = 0
			end
		else begin
			SET @IsShared = 1
			end
		
			
			
UPDATE pStyleQuoteItem SET StyleQuoteItemShare = @IsShared
UPDATE pSourcingCommitmentItem SET StyleQuoteItemShare = @IsShared





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05241', GetDate())
GO
