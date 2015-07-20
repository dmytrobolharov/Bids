-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 Mar 2010                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */                                                                     */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS                                                                                    
--

DECLARE @LastScriptRun NVARCHAR(32)
    SET  @LastScriptRun = '019'

   IF EXISTS(SELECT LastScriptRun FROM sVersion WHERE LastScriptRun = @LastScriptRun)
      BEGIN

            IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_MaterialRequestTradePartnerVendor_Replace_UPDATE') AND type in (N'P'))
               BEGIN
                        DROP PROCEDURE spx_MaterialRequestTradePartnerVendor_Replace_UPDATE
               END


               EXEC('
                    CREATE PROCEDURE spx_MaterialRequestTradePartnerVendor_Replace_UPDATE(
                                    @MaterialTradePartnerID UNIQUEIDENTIFIER,
                                    @TradePartnerVendorID UNIQUEIDENTIFIER,
                                    @MUser NVARCHAR(200),
                                    @MDate DATETIME 
                                                   )
                        AS 

                           DECLARE @OldTradePartnerVendorID UNIQUEIDENTIFIER
                           DECLARE @SeasonYearID UNIQUEIDENTIFIER
                           DECLARE @MaterialID UNIQUEIDENTIFIER

                            --***
                            --** Get tradePartnervendorID to be replaced, 
                            --** Seasonyear and material IDs
                            --***

                           SELECT @OldTradePartnerVendorID = TradePartnerVendorID,
                                  @SeasonYearID = SeasonYearID, @MaterialID = MaterialID 
                             FROM pMaterialTradePartner  
                            WHERE MaterialTradePartnerID = @MaterialTradePartnerID

                              --***
                              --** update MaterialRequest tables
                              --***

                            UPDATE pMaterialTradePartner SET  TradepartnerVendorId = @TradePartnerVendorID
                             WHERE MaterialTradePartnerId = @MaterialTradePartnerID 

                            UPDATE pMaterialRequestSubmitWorkflow SET  TradepartnerVendorId = @TradePartnerVendorID
                             WHERE MaterialTradePartnerId = @MaterialTradePartnerID 

                             --***
                             --** update Style sourcing 
                             --***

                          UPDATE pStyleSourcingItem
                             SET  TradePartnerVendorID = @TradePartnerVendorID 
                           WHERE StyleSourcingItemID IN ( 
	                          SELECT a.StyleSourcingItemID 
	                          FROM pStyleSourcingItem a 
	                          INNER JOIN pStyleSourcing  b ON a.StyleSourcingID = b.StyleSourcingID 
	                          INNER JOIN pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
	                          INNER JOIN pStyleMaterials d ON d.StyleMaterialID =  a.StyleMaterialID 
	                           WHERE a.TradePartnerVendorID = @OldTradePartnerVendorID 
	                           AND c.SeasonYearID = @SeasonYearID 
	                           AND d.MaterialID = @MaterialID
                            )
                  ')

               INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
              VALUES ('DB_Version', '2.6.9999', '020', GetDate())


        END
     ELSE

        BEGIN
             select 'Missing Level ' + @LastScriptRun
        END
GO	
