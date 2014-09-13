-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 5 July 2011                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleTechPack_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleTechPack_INSERT
GO


CREATE PROCEDURE spx_StyleTechPack_INSERT
(
	@TechPackId uniqueidentifier,  
	@TechPackName nvarchar(200),  
	@TechPackStatus int,  
	@StyleId uniqueidentifier,  
	@CreatedDate datetime,  
	@CreatedBy nvarchar(200),  
	@Active nvarchar(10),  
	@StyleSourcingID UNIQUEIDENTIFIER = NULL,
	@SeasonYearID UNIQUEIDENTIFIER = NULL, 
	@SystemCultureId uniqueidentifier = NULL
) 
AS   

IF EXISTS (SELECT * FROM dbo.pTechPack WITH (NOLOCK) WHERE TechPackID = @TechPackId)
	RETURN


DECLARE  
	@StyleSet int,  
	@StyleVersion int,  
	@TradePartnerVendorID UNIQUEIDENTIFIER,  
	@TradePartnerID UNIQUEIDENTIFIER,  
	@SystemServerStorageID UNIQUEIDENTIFIER,  
	@StyleSeasonYearID UNIQUEIDENTIFIER
	
IF @StyleSourcingID IS NOT NULL   
BEGIN  
	SELECT @TradePartnerID = TradePartnerID, @TradePartnerVendorID = TradePartnerVendorID  
	FROM pStyleSourcing WITH (NOLOCK) 
	WHERE StyleSourcingID = @StyleSourcingID   
END   


SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WITH (NOLOCK) WHERE CurrentServerStorage = 1), '00000000-0000-0000-0000-000000000000')   
SELECT @StyleSet = StyleSet, @StyleVersion = Change 
FROM pStyleHeader WITH (NOLOCK) 
WHERE StyleID = @StyleId   

SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID 
FROM dbo.pStyleSeasonYear WITH (NOLOCK)
WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
  
INSERT INTO dbo.pTechPack(
		TechPackID, TechPackName, TechPackStatus, StyleID, StyleSet, StyleVersion, CDate, CUser, MDate, MUser, Active,  
		TradePartnerID, TradePartnerVendorID, StyleSourcingID, SystemServerStorageID, StyleSeasonYearID, SystemCultureId) 
VALUES (@TechPackId, @TechPackName, @TechPackStatus, @StyleId, @StyleSet, @StyleVersion, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy, 
		@Active, @TradePartnerID, @TradePartnerVendorID, @StyleSourcingID, @SystemServerStorageID, @StyleSeasonYearID, @SystemCultureId) 

IF @@ROWCOUNT > 0 
	EXEC spx_StyleTechPack_ChangeLog_UPDATE @TechPackId, @StyleId 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01631', GetDate())
GO
