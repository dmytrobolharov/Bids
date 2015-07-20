-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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
/****** Object:  StoredProcedure [dbo].[spx_StyleSourcingBOMAgentVendor_SELECT]    Script Date: 12/18/2011 18:34:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingBOMAgentVendor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingBOMAgentVendor_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleSourcingBOMAgentVendor_SELECT]    Script Date: 12/18/2011 18:34:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_StyleSourcingBOMAgentVendor_SELECT]  (
@StyleMaterialID UNIQUEIDENTIFIER ,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null,
@StyleSourcingID UNIQUEIDENTIFIER ,
@ShowCount INT =  0  OUTPUT
)
AS


DECLARE @MaterialColorID UNIQUEIDENTIFIER 
DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR (100)
DECLARE @MaterialSizeID UNIQUEIDENTIFIER 
DECLARE @ColorWay as INT



SELECT @MaterialColorID  = a.MaterialColorID , @MaterialID  = a.MaterialID ,
@MaterialSizeID = b.MaterialSizeID , @MaterialSize = b.MaterialSize , @ColorWay = b.Colorway
FROM pStyleColorwayItem a  INNER JOIN pStyleBOM b  ON a.StyleMaterialID =  b.StyleMaterialID 
WHERE a.StyleColorId = @ItemDim1Id or a.StyleColorId = @ItemDim2Id or a.StyleColorId = @ItemDim3Id
AND a.StyleMaterialID = @StyleMaterialID


--SELECT MaterialColorID = @MaterialColorID  , MaterialID =@MaterialID   , MaterialSizeID = @MaterialSizeID  ,   MaterialSize = @MaterialSize 
--SELECT @MaterialSize


UPDATE pMaterialTradePartnerColor SET MaterialSizeID = '00000000-0000-0000-0000-000000000000'
WHERE  MaterialID = @MaterialID
AND MaterialSizeID  IS NULL



IF  LOWER ( @MaterialSize ) = '*na'  
BEGIN 
	
	IF @MaterialSizeID  IS NULL
		SET @MaterialSizeID  =  '00000000-0000-0000-0000-000000000000'

	UPDATE pStyleBOM SET MaterialSizeID =  '00000000-0000-0000-0000-000000000000'   WHERE StyleMaterialID = @StyleMaterialID 

END
ELSE 
BEGIN 
	IF @MaterialSizeID  IS NULL 
	BEGIN 
		SELECT @MaterialSizeID = MaterialSizeID FROM pMaterialSize WHERE MaterialID = @MaterialID  AND MaterialSize = @MaterialSize
		IF @MaterialSizeID IS NOT NULL
		BEGIN
			UPDATE pStyleBOM SET MaterialSizeID = @MaterialSizeID WHERE StyleMaterialID = @StyleMaterialID 
		END
	END 
END 


--SELECT @ColorWay AS COLORWAY 

DECLARE @COUNT AS INT 

set @COUNT = 0 


IF @ColorWay  = 1 
BEGIN 

		IF  @ShowCount = 1  
		BEGIN
			SELECT @COUNT  = COUNT(*) 
			FROM pMaterialTradePartnerColor a INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID =  b.MaterialTradePartnerID 
			INNER JOIN  uTradePartnerVendor c   ON  b.TradepartnerVendorId = c.TradePartnerVendorID 
			INNER JOIN  uTradePartner d ON  c.TradePartnerID =  d.TradePartnerID   
			WHERE a.MaterialID = @MaterialID
			AND a.MaterialColorID = @MaterialColorID  
			AND a.MaterialSizeID  = @MaterialSizeID 
			GROUP BY  d.TradePartnerName + ' - ' +  c.VendorName   , c.TradePartnerVendorID
		END 
		ELSE 
		BEGIN 

			SELECT d.TradePartnerName + ' - ' +  c.VendorName   as TextValue ,  c.TradePartnerVendorID 
			,a.MaterialtradeColor5 as ColorCode , a.MaterialTradeColor6 AS ColorName
			FROM pMaterialTradePartnerColor a INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID =  b.MaterialTradePartnerID 
			INNER JOIN  uTradePartnerVendor c   ON  b.TradepartnerVendorId = c.TradePartnerVendorID 
			INNER JOIN  uTradePartner d ON  c.TradePartnerID =  d.TradePartnerID   
			WHERE a.MaterialID = @MaterialID
			AND a.MaterialColorID = @MaterialColorID  
			AND a.MaterialSizeID  = @MaterialSizeID 
			GROUP BY  d.TradePartnerName + ' - ' +  c.VendorName   , c.TradePartnerVendorID
			,a.MaterialtradeColor5, a.MaterialTradeColor6

		END 

END



SET  @ShowCount  =  @COUNT

PRINT 'showcount = ' + CAST ( @ShowCount  AS NVARCHAR(50))

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02405'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02405', GetDate())

END

GO