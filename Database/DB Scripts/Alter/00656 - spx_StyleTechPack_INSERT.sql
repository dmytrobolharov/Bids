  
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPack_INSERT]') AND type in (N'P', N'PC'))
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
  
DECLARE  
@StyleSet int,  
@StyleVersion int,  
@TradePartnerVendorID UNIQUEIDENTIFIER,  
@TradePartnerID UNIQUEIDENTIFIER,
@StyleSeasonYearID UNIQUEIDENTIFIER, 
@CountTP int

SET @StyleSeasonYearID = (SELECT StyleSeasonYearID FROM dbo.pStyleSeasonYear WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID)
  
IF  @StyleSourcingID IS NOT NULL   
BEGIN  
 SELECT @TradePartnerID = TradePartnerID , @TradePartnerVendorID = TradePartnerVendorID  FROM pStyleSourcing WITH (NOLOCK)  
 WHERE StyleSourcingID = @StyleSourcingID   
END   
  
 DECLARE @SystemServerStorageID uniqueidentifier  
 SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')   
 SELECT @StyleSet = StyleSet, @StyleVersion = Change FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleId   
 
  SET @CountTP = (SELECT COUNT(*) FROM dbo.pTechPack WHERE TechPackId = @TechPackId)
  
IF @CountTP = 0
 BEGIN
  INSERT INTO dbo.pTechPack  
  (TechPackID, TechPackName, TechPackStatus, StyleID, StyleSet, StyleVersion, CDate, CUser, MDate, MUser, Active ,  
   TradePartnerID, TradePartnerVendorID, StyleSourcingID, SystemServerStorageID,StyleSeasonYearID)  
    VALUES     (@TechPackId, @TechPackName, @TechPackStatus, @StyleId, @StyleSet, @StyleVersion, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy,   
    @Active , @TradePartnerID, @TradePartnerVendorID, @StyleSourcingID, @SystemServerStorageID,@StyleSeasonYearID)  
 END
IF @@ROWCOUNT > 0   
 exec spx_StyleTechPack_ChangeLog_UPDATE @TechPackId, @StyleId  
  
  
set ANSI_NULLS ON  
set QUOTED_IDENTIFIER ON  


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '656', GetDate())

GO

  