IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_TechPackNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_TechPackNew_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[spx_Sample_TechPackNew_INSERT]  
 @TechPackId [uniqueidentifier],  
 @TechPackName [nvarchar](200),  
 @TechPackStatus [int],  
 @TechPackFinal [int],  
 @StyleId [uniqueidentifier],  
 @CreatedDate [datetime],  
 @CreatedBy [nvarchar](200),  
 @StyleSourcingID [uniqueidentifier] = NULL,  
 @SeasonYearID [uniqueidentifier] = NULL  ,
 @SampleRequestSubmitId [uniqueidentifier],
 @Submit NVARCHAR(4)
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
  TradePartnerID, TradePartnerVendorID, StyleSourcingID, SystemServerStorageID,StyleSeasonYearID,SampleRequestSubmitId ,Submit)    
VALUES( @TechPackId, @TechPackName, @TechPackStatus, @StyleId, @StyleSet, @StyleVersion, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy,     
  'YES' , @TradePartnerID, @TradePartnerVendorID, @StyleSourcingID, @SystemServerStorageID, @StyleSeasonYearID,@SampleRequestSubmitId , @Submit)    
    
--IF @@ROWCOUNT > 0     
 --exec spx_StyleTechPack_ChangeLog_UPDATE @TechPackId, @StyleId    
  
  
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03053'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03053', GetDate())     

END	  
GO