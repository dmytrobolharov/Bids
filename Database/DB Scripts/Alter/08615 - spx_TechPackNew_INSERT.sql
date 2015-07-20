IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackNew_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackNew_INSERT]
	@TechPackId [uniqueidentifier],
	@TechPackName [nvarchar](200),
	@TechPackStatus [int],
	@TechPackFinal [int],
	@StyleId [uniqueidentifier],
	@CreatedDate [datetime],
	@CreatedBy [nvarchar](200),
	@StyleSourcingID [uniqueidentifier] = NULL,
	@SeasonYearID [uniqueidentifier] = NULL
WITH EXECUTE AS CALLER
AS
IF EXISTS ( SELECT * FROM dbo.pTechPack WITH (NOLOCK) WHERE  TechPackID = @TechPackId)
	RETURN

  
DECLARE  
	@StyleSet int,  
	@StyleVersion int,  
	@TradePartnerVendorID UNIQUEIDENTIFIER,  
	@TradePartnerID UNIQUEIDENTIFIER,  
	@SystemServerStorageID UNIQUEIDENTIFIER,  
	@StyleSeasonYearID UNIQUEIDENTIFIER
	
--Final Tech Pack	
IF @TechPackFinal = 1
BEGIN
	SELECT @StyleVersion = Change FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId 
	BEGIN
	UPDATE pTechPack SET StyleVersion = @StyleVersion , TechpackRelease = 1, 
	MDate = @CreatedDate, MUser = @CreatedBy, Active = 1 WHERE TechPackID = @TechPackId
	END

	BEGIN
	UPDATE pStyleHeader SET TechPackId = @TechPackId, TechPackDate = @CreatedDate WHERE StyleID = @StyleId 
	END	
END
		
IF  @StyleSourcingID IS NOT NULL   
BEGIN  
	SELECT @TradePartnerID = TradePartnerID , @TradePartnerVendorID = TradePartnerVendorID  FROM pStyleSourcing WITH (NOLOCK)  
	WHERE StyleSourcingID = @StyleSourcingID   
END   
  

SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WITH (NOLOCK) WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')   
SELECT @StyleSet = StyleSet, @StyleVersion = Change FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId   
  
SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID FROM dbo.pStyleSeasonYear  WITH (NOLOCK)
WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
  
INSERT INTO dbo.pTechPack(
		TechPackID, TechPackName, TechPackStatus, StyleID, StyleSet, StyleVersion, CDate, CUser, MDate, MUser, Active ,  
		TradePartnerID, TradePartnerVendorID, StyleSourcingID, SystemServerStorageID,StyleSeasonYearID)  
VALUES(	@TechPackId, @TechPackName, @TechPackStatus, @StyleId, @StyleSet, @StyleVersion, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy,   
		'YES' , @TradePartnerID, @TradePartnerVendorID, @StyleSourcingID, @SystemServerStorageID, @StyleSeasonYearID) 
	
-- when creating a tech pack - set status to in progress, if it was not started
UPDATE pStyleTechPackStatus
SET WorkStatus = 6
WHERE StyleID = @StyleId AND StyleSeasonYearID = @StyleSeasonYearID	 
	AND WorkStatus = 1
	
-- when creating a tech pack - set Actual Date to current  
UPDATE pStyleTechPackStatus
SET ActualStart = @CreatedDate
WHERE StyleID = @StyleId AND StyleSeasonYearID = @StyleSeasonYearID	AND ActualStart is NULL 
  
IF @@ROWCOUNT > 0   
 exec spx_StyleTechPack_ChangeLog_UPDATE @TechPackId, @StyleId  



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08615', GetDate())
GO