-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 14 September 2011                                                                               */
-- * WorkItem #5032                                                                             */
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
/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartnerColors_ApplyToAllLogic_UPDATE]    Script Date: 09/14/2011 14:12:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColors_ApplyToAllLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColors_ApplyToAllLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartnerColors_ApplyToAllLogic_UPDATE]    Script Date: 09/14/2011 16:11:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


--  
-- Comment #01 - Clay Parker Dec 21 2009
--	         Added MaterialPrice field to the apply to all functionality.
--
-- Comment #02 - Clay Parker Dec 21 2009
--	         Removed MaterialTradeColor4 and MaterialTradeColor5 for Burberry. These fields need to 
--	         be different for each color.
-- Comment #03 - Artemio Gomez 3/18/2010
--	         Remove MaterialColorID = @MaterialColorID condition to be able to apply changes to "All Colors"	
--
-- Comment #04 - Smita Parab 9/14/2011
--Added Back MaterialTradeColor4 and MaterialTradeColor5 to be able to apply changes to Duty And Leadtime
--Requested By Courtney Dunn for WorkItem#5032


CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerColors_ApplyToAllLogic_UPDATE](
@MaterialTradePartnerID UNIQUEIDENTIFIER,
@MaterialTradePartnerColorID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME 
)
AS 

DECLARE @MaterialColorID UNIQUEIDENTIFIER 

DECLARE @MaterialPrice MONEY                 -- #01
DECLARE @MaterialTradeColor1 NVARCHAR(200)
DECLARE @MaterialTradeColor2 NVARCHAR(200)
DECLARE @MaterialTradeColor3 NVARCHAR(200)
DECLARE @MaterialTradeColor4 NVARCHAR(200)   -- #04
DECLARE @MaterialTradeColor5 NVARCHAR(200)   -- #04	
DECLARE @MaterialTradeColor6 NVARCHAR(200)
DECLARE @MaterialTradeColor7 NVARCHAR(200)
DECLARE @MaterialTradeColor8 NVARCHAR(200)
DECLARE @MaterialTradeColor9 NVARCHAR(200)
DECLARE @MaterialTradeColor10 NVARCHAR(200)
DECLARE @MaterialTradeColor11 NVARCHAR(200)
DECLARE @MaterialTradeColor12 NVARCHAR(200)
DECLARE @MaterialTradeColor13 NVARCHAR(200)
DECLARE @MaterialTradeColor14 NVARCHAR(200)
DECLARE @MaterialTradeColor15 NVARCHAR(200)
DECLARE @MaterialTradeColor16 NVARCHAR(200)
DECLARE @MaterialTradeColor17 NVARCHAR(200)
DECLARE @MaterialTradeColor18 NVARCHAR(200)
DECLARE @MaterialTradeColor19 NVARCHAR(200)
DECLARE @MaterialTradeColor20 NVARCHAR(200)
DECLARE @MaterialTradeColor21 NVARCHAR(200)
DECLARE @MaterialTradeColor22 NVARCHAR(200)
DECLARE @MaterialTradeColor23 NVARCHAR(200)
DECLARE @MaterialTradeColor24 NVARCHAR(200)
DECLARE @MaterialTradeColor25 NVARCHAR(200)


SELECT @MaterialColorID = MaterialColorID,
@MaterialPrice = MaterialPrice,			-- #01
@MaterialTradeColor1 = MaterialTradeColor1,
@MaterialTradeColor2 = MaterialTradeColor2,
@MaterialTradeColor3 = MaterialTradeColor3,
@MaterialTradeColor4 = MaterialTradeColor4,	-- #04
@MaterialTradeColor5 = MaterialTradeColor5,	-- #04
@MaterialTradeColor6 = MaterialTradeColor6,
@MaterialTradeColor7 = MaterialTradeColor7,
@MaterialTradeColor8 = MaterialTradeColor8,
@MaterialTradeColor9 = MaterialTradeColor9,
@MaterialTradeColor10 = MaterialTradeColor10,
@MaterialTradeColor11 = MaterialTradeColor11,
@MaterialTradeColor12 = MaterialTradeColor12,
@MaterialTradeColor13 = MaterialTradeColor13,
@MaterialTradeColor14 = MaterialTradeColor14,
@MaterialTradeColor15 = MaterialTradeColor15,
@MaterialTradeColor16 = MaterialTradeColor16,
@MaterialTradeColor17 = MaterialTradeColor17,
@MaterialTradeColor18 = MaterialTradeColor18,
@MaterialTradeColor19 = MaterialTradeColor19,
@MaterialTradeColor20 = MaterialTradeColor20,
@MaterialTradeColor21 = MaterialTradeColor21,
@MaterialTradeColor22 = MaterialTradeColor22,
@MaterialTradeColor23 = MaterialTradeColor23,
@MaterialTradeColor24 = MaterialTradeColor24,
@MaterialTradeColor25 = MaterialTradeColor25
FROM pMaterialTradePartnerColor 
WHERE MaterialTradePartnerColorID= @MaterialTradePartnerColorID


DECLARE @TradepartnerVendorID UNIQUEIDENTIFIER 
DECLARE @MaterialID UNIQUEIDENTIFIER 

SELECT @TradepartnerVendorID = TradepartnerVendorID, @MaterialID = MaterialID 
FROM pMaterialTradePartner
WHERE MaterialTradePartnerID = @MaterialTradePartnerID


UPDATE pMaterialTradePartnerColor SET 
MaterialPrice		= @MaterialPrice,			-- #01
MaterialTradeColor1 = @MaterialTradeColor1,
MaterialTradeColor2 = @MaterialTradeColor2,
MaterialTradeColor3 = @MaterialTradeColor3,
MaterialTradeColor4 = @MaterialTradeColor4,	-- #04
MaterialTradeColor5 = @MaterialTradeColor5,	-- #04
MaterialTradeColor6 = @MaterialTradeColor6,
MaterialTradeColor7 = @MaterialTradeColor7,
MaterialTradeColor8 = @MaterialTradeColor8,
MaterialTradeColor9 = @MaterialTradeColor9,
MaterialTradeColor10 = @MaterialTradeColor10,
MaterialTradeColor11 = @MaterialTradeColor11,
MaterialTradeColor12 = @MaterialTradeColor12,
MaterialTradeColor13 = @MaterialTradeColor13,
MaterialTradeColor14 = @MaterialTradeColor14,
MaterialTradeColor15 = @MaterialTradeColor15,
MaterialTradeColor16 = @MaterialTradeColor16,
MaterialTradeColor17 = @MaterialTradeColor17,
MaterialTradeColor18 = @MaterialTradeColor18,
MaterialTradeColor19 = @MaterialTradeColor19,
MaterialTradeColor20 = @MaterialTradeColor20,
MaterialTradeColor21 = @MaterialTradeColor21,
MaterialTradeColor22 = @MaterialTradeColor22,
MaterialTradeColor23 = @MaterialTradeColor23,
MaterialTradeColor24 = @MaterialTradeColor24,
MaterialTradeColor25 = @MaterialTradeColor25
WHERE --MaterialColorID = @MaterialColorID AND  -- #03
MaterialTradePartnerID IN (
	SELECT MaterialTradePartnerID FROM pMaterialTradePartner 
	WHERE TradepartnerVendorId = @TradepartnerVendorId 
	AND MaterialId = @MaterialID
)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01940'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01940', GetDate())
END	

GO