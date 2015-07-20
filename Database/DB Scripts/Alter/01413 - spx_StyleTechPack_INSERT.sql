IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPack_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleTechPack_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleTechPack_INSERT](  
	@TechPackId uniqueidentifier,  
	@TechPackName nvarchar(200),  
	@TechPackStatus int,  
	@StyleId uniqueidentifier,  
	@CreatedDate datetime,  
	@CreatedBy nvarchar(200),  
	@Active nvarchar(10),  
	@StyleSourcingID UNIQUEIDENTIFIER = NULL,
	@SeasonYearID UNIQUEIDENTIFIER = NULL 
)  
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
		@Active , @TradePartnerID, @TradePartnerVendorID, @StyleSourcingID, @SystemServerStorageID,@StyleSeasonYearID)  
  
IF @@ROWCOUNT > 0   
 exec spx_StyleTechPack_ChangeLog_UPDATE @TechPackId, @StyleId  
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01413', GETDATE())
GO