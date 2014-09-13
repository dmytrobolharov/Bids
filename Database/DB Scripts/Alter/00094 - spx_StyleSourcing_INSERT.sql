IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcing_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcing_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcing_INSERT] (
@StyleSourcingID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME ,
@SeasonYearID UNIQUEIDENTIFIER,
@TradePartnerVendorID UNIQUEIDENTIFIER
)
AS


IF ( SELECT COUNT(*) FROM pStyleSourcing a
	INNER JOIN pStyleSeasonYear b ON a.StyleSeasonYearID =  b.StyleSeasonYearID
	WHERE b.StyleID = @StyleID 
	AND b.SeasonYearID = @SeasonYearID 
	AND a.TradePartnerVendorID = @TradePartnerVendorID ) = 0 
BEGIN

	DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER 

	SELECT  @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear 
	WHERE StyleID = @StyleID 
	AND SeasonYearID = @SeasonYearID

	INSERT INTO pStyleSourcing  (StyleSourcingID , StyleID , CDate, CUser, MDate, MUser, StyleSeasonYearID ) 
	VALUES (@StyleSourcingID , @StyleID , @CDate, @CUser, @CDate, @CUser, @StyleSeasonYearID ) 
	
	SELECT 0 as iRes
END 
ELSE
	SELECT 1 as iRes




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '094', GetDate())

GO
