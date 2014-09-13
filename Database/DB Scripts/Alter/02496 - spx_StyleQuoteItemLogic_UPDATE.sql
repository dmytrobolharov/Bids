IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE  PROCEDURE [dbo].[spx_StyleQuoteItemLogic_UPDATE]    
(    
 @StyleQuoteItemID uniqueidentifier,    
 @StyleID uniqueidentifier = NULL,     
 @LinePlanID uniqueidentifier = NULL,     
 @LinePlanRangeID uniqueidentifier = NULL,     
 @LinePlanAttributeItemID1 uniqueidentifier = NULL,     
 @LinePlanAttributeItemID2 uniqueidentifier= NULL,     
 @LinePlanAttributeItemID3 uniqueidentifier= NULL,     
 @LinePlanAttributeItemID4 uniqueidentifier = NULL    
)    
AS     
    
/***********************************************************/
/*** Procedure which calculates QuoteItem fields ***********/
Exec spx_StyleQuoteDetailLogic_UPDATE @StyleQuoteItemID
/***********************************************************/       


/************************************************************    
Original statements commented out by Ryan Cabanas on 8/26/08.    
*************************************************************/    
    
--DECLARE @StyleId uniqueidentifier    
DECLARE @StyleCostingId uniqueidentifier    
DECLARE @StyleQuoteDutyId uniqueidentifier    
DECLARE @TradePartnerID uniqueidentifier    
DECLARE @TradePartnerVendorID uniqueidentifier    
    
DECLARE @ComissionPerc decimal(19,3) --StyleCostingCustomField9    
DECLARE @GarmentWgt decimal(19,3) --StyleCostingCustomField2    
DECLARE @AvgFirstCost decimal(19,3) --StyleQuoteItemCustomField1    
DECLARE @RetailCost decimal(19,3) --StyleQuoteItemCustomField1    
DECLARE @MiscCost  decimal(19,3) --StyleCostingCustomField4      
DECLARE @RoyaltyPerc decimal(19,3) --StyleCostingCustomField8     
DECLARE @RoyaltyCode decimal(18,0)    
DECLARE @VariancePerc decimal(19,3) --StyleCostingCustomField10    
DECLARE @DutyPerc decimal(19,3) --StyleCostingCustomField11    
DECLARE @Surcharge decimal(19,3) --StyleCostingCustomField12    
DECLARE @BrokerHarborFee decimal(19,3) --StyleCostingCustomField13    
DECLARE @CountryCode varchar(50) --StyleQuoteItemCustomField4,    
DECLARE @StateCode varchar(50) --StyleQuoteItemCustomField5,    
DECLARE @StyleCostingType int    
DECLARE @TradePartnerState varchar(2)    
DECLARE @NumberOfUnit decimal(19,3)    
DECLARE @FreightMethod decimal(19,3)  
DECLARE @Wholesale  decimal(19,3)  
DECLARE @FinalLDP decimal(19,3)   
DECLARE @FreightCost decimal(19,4)   
  
DECLARE @CartonHeight decimal(19,3) --StyleQuoteItemCustomField14    
DECLARE @CartonLeght decimal(19,3) --StyleQuoteItemCustomField15     
DECLARE @CartonWidth decimal(19,3) --StyleQuoteItemCustomField16    
DECLARE @UnitPerCarton decimal(19,3) --StyleQuoteItemCustomField17    
DECLARE @VolCubicFeet decimal(19,3) --StyleQuoteItemCustomField18    
DECLARE @ContainerSize varchar(10) --StyleQuoteItemCustomField12    
    
DECLARE @HomeCost varchar(10)    
    
--Preference Table    
DECLARE @PrefImportVariance decimal(19,3)    
DECLARE @PrefDomesticVariance decimal(19,3)    
DECLARE @PrefIndirectVariance decimal(19,3)    
    
SELECT @PrefImportVariance = ImportVariance, @PrefDomesticVariance = DomesticVariance, @PrefIndirectVariance = IndirectVariance FROM pStyleCostingPreference    
    
DECLARE @StyleQuoteItemShare  INT     
    
--select @StyleQuoteItemShare as StyleQuoteItemShare    

SELECT     
 @StyleId = ISNULL(StyleId,'{00000000-0000-0000-0000-000000000000}'),     
 @StyleQuoteDutyId = ISNULL(StyleQuotaDutyId,'{00000000-0000-0000-0000-000000000000}'),    
 @TradePartnerID = ISNULL(TradePartnerID,'{00000000-0000-0000-0000-000000000000}'),     
 @TradePartnerVendorID = ISNULL(TradePartnerVendorID,'{00000000-0000-0000-0000-000000000000}'),      
 @StyleCostingType = ISNULL(StyleCostingType,0),      
 @AvgFirstCost = cast(COALESCE(StyleQuoteItemCustomField4,0) as decimal(19,3)),       
 @RetailCost = CAST(COALESCE(StyleCostingCustomField1,0) as decimal(19,3)),    
 --@RoyaltyCode = CAST(COALESCE(StyleQuoteItemCustomField3,0) as decimal(19,0)),   
 @Wholesale  = ISNULL(StyleQuoteItemCustomField2,0),    
 --@RoyaltyCode = ISNULL(StyleQuoteItemCustomField3,0),
 @RoyaltyCode = ISNULL(CAST(COALESCE(StyleQuoteItemCustomField3,0) as decimal(19,0)),0),    
 @CountryCode = ISNULL(StyleQuoteItemCustomField1,''),    
 @StateCode = StyleQuoteItemCustomField5,    
 @MiscCost = ISNULL(StyleCostingCustomField4,0),    
 @RoyaltyPerc = ISNULL(StyleCostingCustomField8,0),    
 @ComissionPerc = ISNULL(StyleCostingCustomField9,0),    
 @VariancePerc = ISNULL(StyleCostingCustomField10,0),    
 @DutyPerc = ISNULL(StyleCostingCustomField11,0),    
 @Surcharge = ISNULL(StyleCostingCustomField12,0),    
 @GarmentWgt = ISNULL(StyleCostingCustomField2,0),    
 @BrokerHarborFee = ISNULL(StyleCostingCustomField13,0),  
 @FreightCost = ISNULL(StyleQuoteItemCustomField13,0),  
 @FinalLDP =  ISNULL(StyleCostingCustomField14,0),  
 @NumberOfUnit = ISNULL(StyleCostingCustomField18,0),    
 @FreightMethod = StyleCostingCustomField16 ,    
 @StyleQuoteItemShare = StyleQuoteItemShare    
FROM  pStyleQuoteItem    
WHERE  (StyleQuoteItemID = @StyleQuoteItemID)    
    
  
    
/*********************************************************************************************************************************************************************************    
IF StyleQuoteItemShare = 1  check if the style is shared with the TradePartner     
*/     
select @StyleQuoteItemShare as StyleQuoteItemShare1    
    
    
    
    
IF @StyleQuoteItemShare = 1  AND @TradePartnerID  IS NOT NULL    
BEGIN     
 DECLARE  @StyleDevelopmentID  UNIQUEIDENTIFIER    
  SELECT  @StyleDevelopmentID   = DevelopmentID   FROM pStyleHeader WHERE StyleID = @StyleId    
    
 IF ( SELECT COUNT(*)  FROM pStyleTeam WHERE StyleID = @StyleId AND TeamID = @TradePartnerID  )  =  0    
 BEGIN     
  INSERT INTO pStyleTeam ( StyleTeamID ,  TeamID , StyleDevelopmentId, StyleID ,  TradePartner  )     
  VALUES ( NEWID(),   @TradePartnerID ,  @StyleDevelopmentID ,   @StyleId , 1 )     
 END     
    
END     
    
    
/********************************************************************************************************************************************************************************/    
    
    
    
SELECT * FROM  pStyleQuoteItem WHERE (StyleQuoteItemID = @StyleQuoteItemID)    
    
DECLARE @TradePartnerClass varchar(50)    
DECLARE @TradePartnerCommission decimal(19,3) --StyleCostingCustomField9    
DECLARE @TradePartnerVendorCountry varchar(50)    
    
SELECT @TradePartnerClass = TradePartnerClass, @TradePartnerCommission = TradePartnerCommision, @TradePartnerState = State FROM uTradePartner WHERE TradePartnerID = @TradePartnerID    
    
SELECT @TradePartnerVendorCountry = Country     
FROM uTradePartnerVendor WHERE TradePartnerVendorID = @TradePartnerVendorID    
    
DECLARE @RoyaltyCost int    
DECLARE @Commision decimal(19,3)    
DECLARE @Variance decimal(19,3)    
DECLARE @Duty decimal(19,3)     
DECLARE @DutySurcharge decimal(19,3)    
DECLARE @BrokerHarbor decimal(19,3)    
DECLARE @ImportCost decimal(19,3)    
DECLARE @DomesticCost decimal(19,3)    
DECLARE @IndirectCost decimal(19,3)    
    
--IF @RoyaltyCode = 1 SET @RoyaltyCost = @AvgFirstCost * @RoyaltyPerc    
--IF @RoyaltyCode = 2 SET @RoyaltyCost = @RetailCost * @RoyaltyPerc    
    
SET @Commision = @AvgFirstCost *  @ComissionPerc --@TradePartnerCommission    
SET @Variance = @AvgFirstCost * @VariancePerc    
SET @Duty = @AvgFirstCost * @DutyPerc --NOT apllicable for DOMEST AND INDIRECT    
SET @DutySurcharge = @Surcharge * @GarmentWgt --NOT apllicable for DOMEST AND INDIRECT    
SET @BrokerHarbor = @AvgFirstCost * @BrokerHarborFee --NOT apllicable for DOMEST AND INDIRECT    
SET @ImportCost = @AvgFirstCost + @RoyaltyCost + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor     
    
IF @RoyaltyCode = 1    
 BEGIN    
 SET @ImportCost = ((@AvgFirstCost * @RoyaltyPerc)+ @AvgFirstCost) + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor     
 END    
ELSE IF @RoyaltyCode = 2    
 BEGIN    
 SET @ImportCost = ((@RetailCost * @RoyaltyPerc) + @AvgFirstCost) + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor     
 END    
ELSE    
 BEGIN    
 SET @ImportCost = 0    
 END    
    
    
SELECT (@AvgFirstCost + (@RetailCost * @RoyaltyPerc)) AS R    
SELECT @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor AS F    
SELECT ((@RetailCost * @RoyaltyPerc) + @AvgFirstCost) + @MiscCost + @Commision + @Variance + @Duty + @DutySurcharge + @BrokerHarbor  AS Royal    
--Transportation Cost    
DECLARE @AirRate decimal(19,3)    
DECLARE @BoatRate decimal(19,3)    
DECLARE @AirCostperUnit decimal(19,3)    
DECLARE @BoatCostperUnit decimal(19,3)    
DECLARE @Container40 decimal(19,3)    
DECLARE @Container20 decimal(19,3)    
DECLARE @ContainerLCL decimal(19,3)    
DECLARE @ContainerVolumeAir decimal(19,3)     
    
DECLARE @CostCode varchar(2)    
DECLARE @DomesticRate decimal(19,6)    
DECLARE @DomesticCostperUnit decimal(19,3)    
DECLARE @DomesticTLC decimal(19,3)    
DECLARE @DomesticMargin decimal(19,3)    
    
    
SELECT @AirRate = AirRate, @BoatRate = SeaRate, @Container40 = Container40, @Container20 = Container20, @ContainerLCL = @ContainerLCL, @ContainerVolumeAir = @ContainerVolumeAir       
FROM uCountry WHERE CountryCode = @CountryCode    
    
--IF @FreightMethod IS NULL OR  @FreightMethod = 0    
BEGIN    
 DECLARE @StyleCategoryId uniqueidentifier    
 SELECT @StyleCategoryId = StyleCategory FROM pStyleHeader WHERE StyleID = @StyleID    
 SELECT @FreightMethod = StyleCategoryFreightType FROM pStyleCategory WHERE StyleCategoryId = @StyleCategoryId    
END    
    
DECLARE @StyleFreightAirID uniqueidentifier    
DECLARE @StyleFreightBoatID uniqueidentifier    
DECLARE @StyleFreightDomesticID uniqueidentifier    
DECLARE @StyleFreightIndirectID uniqueidentifier    
    
SELECT @StyleFreightAirID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Air'    
SELECT @StyleFreightBoatID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Boat'    
SELECT @StyleFreightDomesticID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Domestic'    
SELECT @StyleFreightIndirectID = ISNULL(StyleQuoteFreightID, NEWID()) FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID AND FreightMethod = 'Indirect'    
    
IF(@StyleFreightAirID IS NULL)    
 BEGIN    
  SET @StyleFreightAirID = NEWID()    
 END    
    
IF(@StyleFreightBoatID IS NULL)    
 BEGIN    
  SET @StyleFreightBoatID = NEWID()    
 END    
    
IF(@StyleFreightDomesticID IS NULL)    
 BEGIN    
  SET @StyleFreightDomesticID = NEWID()    
 END    
    
IF(@StyleFreightIndirectID IS NULL)    
 BEGIN    
  SET @StyleFreightIndirectID = NEWID()    
 END    


DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID    


DECLARE @AirTLC decimal(19,3)    
DECLARE @AirMargin decimal(19,3)
DECLARE @AirMargin1 decimal(19,3)
DECLARE @BoatTLC decimal(19,3)
DECLARE @BoatMargin decimal(19,3)
DECLARE @BoatMargin1 decimal(19,3)


IF @StyleCostingType = '1' OR @StyleCostingType = '2'    
BEGIN    

/****************************************/
/************* OLD CODE  ****************/
    
--DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID    
    
 ----AIR    
 --SET @AirCostperUnit = @GarmentWgt * @AirRate    
    
 --SET @AirTLC = @ImportCost + @AirCostperUnit    
    
 --SELECT @AirRate AS AirRate, @AirCostperUnit AS AirCost, @AirTLC AS AirTLC, @FreightMethod AS FM    
    
 --IF @RetailCost = 0    
 -- BEGIN    
 -- SET @AirMargin = 0    
 -- END    
 --ELSE    
 -- BEGIN    
 -- SET @AirMargin = (@RetailCost - @AirTLC) / @RetailCost    
 -- END    
    
 -- IF @FinalLDP = 0    
 --BEGIN    
 -- SET @FinalLDP = 0    
 --END    
    
 -- IF @AirRate = 0 or  @AirRate is null  
 --  BEGIN    
 --   SET @AirRate = 0    
 --  END   
     
 -- IF @FreightCost = 0    
 --  BEGIN    
 --   SET @FreightCost = 0    
 --  END  
  
 -- SET @AirTLC = @FinalLDP + @FreightCost + @AirRate      
    
 -- IF @AirTLC = 0    
 -- BEGIN    
 -- SET @AirMargin1 = 0    
 -- END    
 --ELSE    
 -- BEGIN    
 -- SET @AirMargin1 = (@Wholesale - @AirTLC) / @AirTLC * 100   
 -- END    
  
  
 ----Update Air Freight Cost     
 --IF @FreightMethod = 1    
 -- BEGIN    
 --  BEGIN     
 --   INSERT INTO pStyleQuoteItemFreightCost    
 --    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
 --   VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin1, @AirTLC, @FreightCost , @AirRate, 1, 1)    
 --  END    
    
 --  UPDATE pStyleQuoteItem SET   
 --   --StyleQuoteItemCustomField6 = 1,    
 --   StyleQuoteItemCustomField22 =  1,     
 --   StyleQuoteItemCustomField23 = @AirTLC,      
 --   StyleQuoteItemCustomField24 = @FreightCost,      
 --   StyleQuoteItemCustomField25 = @AirRate,    
 --   StyleCostingCustomField16 = @FreightMethod         
 --  WHERE StyleQuoteItemID = @StyleQuoteItemID    
 -- END    
 --ELSE    
 -- BEGIN    
 --  INSERT INTO pStyleQuoteItemFreightCost    
 --   (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
 --  VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin1, @AirTLC, @FreightCost , @AirRate, 2, 0)    
 -- END    
    
        
 ----BOAT     
 --SET @BoatCostperUnit = (@GarmentWgt/16) * @BoatRate    
    
 --SET @BoatTLC = @ImportCost + @BoatCostperUnit    
    
 --IF @RetailCost = 0    
 -- BEGIN    
 -- SET @BoatMargin = 0    
 -- END    
 --ELSE    
 -- BEGIN    
 -- SET @BoatMargin = (@RetailCost - @BoatTLC) / @RetailCost    
 -- END    
    
 --SELECT @BoatRate AS BoatRate, @BoatCostperUnit AS BoatCost, @BoatTLC AS BoatTLC, @FreightMethod AS FM    
    
 -- IF @FinalLDP = 0    
 --BEGIN    
 -- SET @FinalLDP = 0    
 --END    
    
 -- IF @BoatRate = 0 or  @BoatRate is null  
 --  BEGIN    
 --   SET @BoatRate = 0    
 --  END   
     
 -- IF @FreightCost = 0    
 --  BEGIN    
 --   SET @FreightCost = 0    
 --  END  
 -- SET @BoatTLC = @FinalLDP + @FreightCost + @BoatRate  
    
 -- IF @BoatTLC = 0    
 -- BEGIN    
 -- SET @BoatMargin1 = 0    
 -- END    
 --ELSE    
 -- BEGIN    
 -- SET @BoatMargin1 = (@Wholesale - @BoatTLC) / @BoatTLC * 100   
 -- END    
  
 ----Update Sea Freight Cost     
 --IF @FreightMethod = 2    
 -- BEGIN    
 --  INSERT INTO pStyleQuoteItemFreightCost    
 --   (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
 --  VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin1, @BoatTLC, @FreightCost , @BoatRate, 1, 1)    
      
 --  UPDATE pStyleQuoteItem SET     
 --   --StyleQuoteItemCustomField6 = 2,    
 --   StyleQuoteItemCustomField22 = 2,     
 --   StyleQuoteItemCustomField23 = @BoatTLC,      
 --   StyleQuoteItemCustomField24 = @FreightCost,      
 --   StyleQuoteItemCustomField25 = @BoatRate,    
 --   StyleCostingCustomField16 = @FreightMethod          
 --  WHERE StyleQuoteItemID = @StyleQuoteItemID    
 -- END    
 --ELSE    
 -- BEGIN    
      
 --  INSERT INTO pStyleQuoteItemFreightCost    
 --   (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
 --  VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin1, @BoatTLC, @FreightCost , @BoatRate, 2, 0)    
      
 -- END    
/****************************************/

/****************************************/
/*************** NEW CODE ***************/
/****************************************/
    
 SELECT @FinalLDP = StyleQuoteItemCustomField14 FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

 --AIR    
 
 IF @AirRate is null  
  BEGIN
    SET @AirRate = 0    
  END

 SET @AirTLC = @FinalLDP + @AirRate      --@FinalLDP + @FreightCost + @AirRate      
    
 IF @AirTLC = 0
  BEGIN    
    SET @AirMargin = 0
  END    
 ELSE    
  BEGIN    
    SET @AirMargin = (@Wholesale - @AirTLC) / @AirTLC * 100   
  END    
  
  
 --Update Air Freight Cost     
 IF @FreightMethod = 1    
  BEGIN    
   BEGIN     
    INSERT INTO pStyleQuoteItemFreightCost    
     (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
    VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @FreightCost , @AirRate, 1, 1)    
   END    
    
   UPDATE pStyleQuoteItem SET   
    --StyleQuoteItemCustomField6 = 1,    
    StyleQuoteItemCustomField22 =  1,     
    StyleQuoteItemCustomField23 = @AirTLC,      
    StyleQuoteItemCustomField24 = @FreightCost,      
    StyleQuoteItemCustomField25 = @AirRate,    
    StyleCostingCustomField16 = @FreightMethod         
   WHERE StyleQuoteItemID = @StyleQuoteItemID    
  END    
 ELSE    
  BEGIN    
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @FreightCost , @AirRate, 2, 0)    
  END    
    
        
 --BOAT     
 
 IF @BoatRate is null  
  BEGIN    
   SET @BoatRate = 0    
  END   
    
 SET @BoatTLC = @FinalLDP + @BoatRate --@FinalLDP + @FreightCost + @BoatRate  
    
 IF @BoatTLC = 0    
  BEGIN    
    SET @BoatMargin = 0    
  END    
 ELSE    
  BEGIN    
    SET @BoatMargin = (@Wholesale - @BoatTLC) / @BoatTLC * 100   
  END    
  
 --Update Sea Freight Cost     
 IF @FreightMethod = 2    
  BEGIN    
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @FreightCost , @BoatRate, 1, 1)    
      
   UPDATE pStyleQuoteItem SET     
    --StyleQuoteItemCustomField6 = 2,    
    StyleQuoteItemCustomField22 = 2,     
    StyleQuoteItemCustomField23 = @BoatTLC,      
    StyleQuoteItemCustomField24 = @FreightCost,      
    StyleQuoteItemCustomField25 = @BoatRate,    
    StyleCostingCustomField16 = @FreightMethod          
   WHERE StyleQuoteItemID = @StyleQuoteItemID    
  END    
 ELSE    
  BEGIN    
      
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @FreightCost , @BoatRate, 2, 0)    
      
  END    
/***************************************/
/********** ENDING OF NEW CODE *********/
/***************************************/  
      
END    
    
--DOMESTIC     
ELSE IF @StyleCostingType = '3'  --OR @TradePartnerClass = '3'    
BEGIN    

/****************************************/
/************* OLD CODE  ****************/

----DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID    
    
-- IF @StateCode = '' SET @StateCode = @TradePartnerState    
    
-- SELECT @CostCode = CostCode FROM uState WHERE StateCode = @StateCode     
-- SELECT @DomesticRate = CostRate FROM pStyleCostingDomesticRate WHERE CostCode = @CostCode    
    
-- SET @DomesticCost = @AvgFirstCost + @MiscCost + @Variance     
-- SET @DomesticCostperUnit = @GarmentWgt * @DomesticRate     
    
     
-- SET @DomesticTLC = @DomesticCost + @DomesticCostperUnit    
     
     
-- IF @RetailCost = 0    
--  BEGIN    
--  SET @DomesticMargin = 0    
--  END    
-- ELSE    
--  BEGIN    
--  SET @DomesticMargin = (@RetailCost - @DomesticTLC) / @RetailCost    
--  END     
    
-- INSERT INTO pStyleQuoteItemFreightCost    
--  (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
-- VALUES (@StyleFreightDomesticID, @StyleQuoteItemId, 'Domestic', @DomesticMargin, @DomesticTLC, @DomesticCostperUnit , @DomesticRate, 1, 1)    
    
-- --Update Domestic Freight Cost     
-- IF @FreightMethod = 3    
-- BEGIN    
--  UPDATE pStyleQuoteItem SET     
--   --StyleQuoteItemCustomField6 = 3,    
--   StyleQuoteItemCustomField22 = 3,     
--   StyleQuoteItemCustomField23 = @DomesticTLC,      
--   StyleQuoteItemCustomField24 = @DomesticCostperUnit,      
--   StyleQuoteItemCustomField25 = @DomesticRate         
--  WHERE StyleQuoteItemID = @StyleQuoteItemID    
-- END    
/****************************************/

/****************************************/
/*************** NEW CODE ***************/
/****************************************/

 DECLARE @DomesticTotalCost AS DECIMAL (18,3)
 SELECT @DomesticTotalCost = StyleQuoteItemCustomField14 FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

 --AIR    
 
 IF @AirRate is null  
  BEGIN
    SET @AirRate = 0    
  END

 SET @AirTLC = @DomesticTotalCost + @AirRate  --@DomesticTotalCost + @FreightCost + @AirRate      
    
 IF @AirTLC = 0
  BEGIN    
    SET @AirMargin = 0
  END    
 ELSE    
  BEGIN    
    SET @AirMargin = (@Wholesale - @AirTLC) / @AirTLC * 100   
  END    
  
 --Update Air Freight Cost     
 IF @FreightMethod = 1    
  BEGIN    
   BEGIN     
    INSERT INTO pStyleQuoteItemFreightCost    
     (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
    VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @FreightCost , @AirRate, 1, 1)    
   END    
    
   UPDATE pStyleQuoteItem SET   
    StyleQuoteItemCustomField22 =  1,     
    StyleQuoteItemCustomField23 = @AirTLC,      
    StyleQuoteItemCustomField24 = @FreightCost,      
    StyleQuoteItemCustomField25 = @AirRate,    
    StyleCostingCustomField16 = @FreightMethod         
   WHERE StyleQuoteItemID = @StyleQuoteItemID    
  END    
 ELSE    
  BEGIN    
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @FreightCost , @AirRate, 2, 0)    
  END    
    
        
 --BOAT     
 
 IF @BoatRate is null  
  BEGIN    
   SET @BoatRate = 0    
  END   
    
 SET @BoatTLC = @DomesticTotalCost + @BoatRate  --@DomesticTotalCost + @FreightCost + @BoatRate  
    
 IF @BoatTLC = 0    
  BEGIN    
    SET @BoatMargin = 0    
  END    
 ELSE    
  BEGIN    
    SET @BoatMargin = (@Wholesale - @BoatTLC) / @BoatTLC * 100   
  END    
  
 --Update Sea Freight Cost     
 IF @FreightMethod = 2    
  BEGIN    
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @FreightCost , @BoatRate, 1, 1)    
      
   UPDATE pStyleQuoteItem SET     
    StyleQuoteItemCustomField22 = 2,     
    StyleQuoteItemCustomField23 = @BoatTLC,      
    StyleQuoteItemCustomField24 = @FreightCost,      
    StyleQuoteItemCustomField25 = @BoatRate,    
    StyleCostingCustomField16 = @FreightMethod          
   WHERE StyleQuoteItemID = @StyleQuoteItemID    
  END    
 ELSE    
  BEGIN    
      
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @FreightCost , @BoatRate, 2, 0)    
      
  END    
/***************************************/
/********** ENDING OF NEW CODE *********/
/***************************************/

END    
    
    
--Indirect    
ELSE IF @StyleCostingType = '4'    
BEGIN    

/****************************************/
/************* OLD CODE  ****************/

----DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemID = @StyleQuoteItemID    
    
-- SET @DomesticCost = @AvgFirstCost + @MiscCost + @Variance     
    
-- SET @DomesticCostperUnit = @GarmentWgt     
    
-- SET @DomesticTLC = @DomesticCost     
     
-- IF @RetailCost = 0    
--  BEGIN    
--  SET @DomesticMargin = 0    
--  END    
-- ELSE    
--  BEGIN    
--  SET @DomesticMargin = (@RetailCost - @DomesticTLC) / @RetailCost    
--  END     
    
-- INSERT INTO pStyleQuoteItemFreightCost    
--  (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
-- VALUES (@StyleFreightIndirectID, @StyleQuoteItemId, 'Indirect', @DomesticMargin, @DomesticTLC, @DomesticCostperUnit , @DomesticRate, 2, 1)    
    
       
-- --Update Indirect Freight Cost     
-- IF @FreightMethod = 4    
-- BEGIN    
--  UPDATE pStyleQuoteItem SET     
--   --StyleQuoteItemCustomField6 = 4,    
--   StyleQuoteItemCustomField22= 4,     
--   StyleQuoteItemCustomField23 = @DomesticTLC,      
--   StyleQuoteItemCustomField24 = @DomesticCostperUnit,      
--   StyleQuoteItemCustomField25 = @DomesticRate         
--  WHERE StyleQuoteItemID = @StyleQuoteItemID    
-- END    
/****************************************/


/****************************************/
/*************** NEW CODE ***************/
/****************************************/

 DECLARE @IndirectTotalCost AS DECIMAL (18,3)
 SELECT @IndirectTotalCost = StyleQuoteItemCustomField14 FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID

 --AIR    

  IF @AirRate is null  
  BEGIN
    SET @AirRate = 0    
  END

 SET @AirTLC = @IndirectTotalCost + @AirRate --@IndirectTotalCost + @FreightCost + @AirRate      
    
 IF @AirTLC = 0
  BEGIN    
    SET @AirMargin = 0
  END    
 ELSE    
  BEGIN    
    SET @AirMargin = (@Wholesale - @AirTLC) / @AirTLC * 100   
  END    
  
 --Update Air Freight Cost     
 IF @FreightMethod = 1    
  BEGIN    
   BEGIN     
    INSERT INTO pStyleQuoteItemFreightCost    
     (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
    VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @FreightCost , @AirRate, 1, 1)    
   END    
    
   UPDATE pStyleQuoteItem SET   
    StyleQuoteItemCustomField22 =  1,     
    StyleQuoteItemCustomField23 = @AirTLC,      
    StyleQuoteItemCustomField24 = @FreightCost,      
    StyleQuoteItemCustomField25 = @AirRate,    
    StyleCostingCustomField16 = @FreightMethod         
   WHERE StyleQuoteItemID = @StyleQuoteItemID    
  END    
 ELSE    
  BEGIN    
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightAirID, @StyleQuoteItemId, 'Air', @AirMargin, @AirTLC, @FreightCost , @AirRate, 2, 0)    
  END    
    
        
 --BOAT     
 
  IF @BoatRate is null  
  BEGIN    
   SET @BoatRate = 0    
  END   
    
 SET @BoatTLC = @IndirectTotalCost + @BoatRate --@IndirectTotalCost + @FreightCost + @BoatRate  
    
 IF @BoatTLC = 0    
  BEGIN    
    SET @BoatMargin = 0    
  END    
 ELSE    
  BEGIN    
    SET @BoatMargin = (@Wholesale - @BoatTLC) / @BoatTLC * 100   
  END    
  
 --Update Sea Freight Cost     
 IF @FreightMethod = 2    
  BEGIN    
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @FreightCost , @BoatRate, 1, 1)    
      
   UPDATE pStyleQuoteItem SET     
    StyleQuoteItemCustomField22 = 2,     
    StyleQuoteItemCustomField23 = @BoatTLC,      
    StyleQuoteItemCustomField24 = @FreightCost,      
    StyleQuoteItemCustomField25 = @BoatRate,    
    StyleCostingCustomField16 = @FreightMethod          
   WHERE StyleQuoteItemID = @StyleQuoteItemID    
  END    
 ELSE    
  BEGIN    
      
   INSERT INTO pStyleQuoteItemFreightCost    
    (StyleQuoteFreightID, StyleQuoteItemId, FreightMethod, Margin, TotalLandCost, FreightCost, FreightRate, Sort, FreightCostSelected)    
   VALUES (@StyleFreightBoatID, @StyleQuoteItemId, 'Boat', @BoatMargin, @BoatTLC, @FreightCost , @BoatRate, 2, 0)    
      
  END    
  
/***************************************/
/********** ENDING OF NEW CODE *********/
/***************************************/

END

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02496'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02496', GetDate())

END
GO