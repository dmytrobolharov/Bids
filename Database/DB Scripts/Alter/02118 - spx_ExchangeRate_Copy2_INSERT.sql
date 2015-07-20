/****** Object:  StoredProcedure [dbo].[spx_ExchangeRate_Copy2_INSERT]    Script Date: 10/10/2011 18:44:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ExchangeRate_Copy2_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ExchangeRate_Copy2_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ExchangeRate_Copy2_INSERT]
	(@NewExchangeRateID  uniqueidentifier,
	 @OldExchangeRateID  uniqueidentifier,
	 @CUser nvarchar(200),
	 @CDate datetime)
AS
BEGIN



INSERT INTO sExchangeRateItem (ExchangeRateID, CountryCode, Rate, CurrencyType, CUser, CDate, MUser, MDate, Sort, [Type], BaseCurrency)
		SELECT @NewExchangeRateID, CountryCode, Rate, CurrencyType, @CUser, @CDate, @CUser, @CDate, Sort, [Type], BaseCurrency
		FROM sExchangeRateItem
		WHERE ExchangeRateID = @OldExchangeRateID

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02118'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02118', GetDate())
	END
GO