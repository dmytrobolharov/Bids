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
    SET  @LastScriptRun = '020'

   IF EXISTS(SELECT LastScriptRun FROM sVersion WHERE LastScriptRun = @LastScriptRun)
      BEGIN

            IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_MaterialTradePartnerColorCheck_SELECT') AND type in (N'P'))
               BEGIN
                        DROP PROCEDURE spx_MaterialTradePartnerColorCheck_SELECT
               END


               EXEC('
                    CREATE PROCEDURE spx_MaterialTradePartnerColorCheck_SELECT (@MaterialTradePartnerColorID UNIQUEIDENTIFIER )
                        AS

                          DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER 
                          DECLARE @MaterialID UNIQUEIDENTIFIER 
                          DECLARE @MaterialColorID UNIQUEIDENTIFIER 
                          DECLARE @TradepartnerVendorId UNIQUEIDENTIFIER 
                          DECLARE @SeasonYearID UNIQUEIDENTIFIER


                          SELECT @MaterialTradePartnerID = a.MaterialTradePartnerID, @MaterialID = a.MaterialID, 
                                 @TradepartnerVendorId = b.TradepartnerVendorId, @SeasonYearID = b.SeasonYearID ,
                                 @MaterialColorID = MaterialColorID
                            FROM pMaterialTradePartnerColor a
                                 INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID = b.MaterialTradePartnerId
                                 WHERE a.MaterialTradePartnerColorID = @MaterialTradePartnerColorID

                          SELECT  COUNT(*)
                            FROM pStyleSourcingItem a
                                 INNER JOIN pStyleSourcing b ON a.StyleSourcingID = b.StyleSourcingID 
                                 INNER JOIN pStyleSeasonYear c ON c.StyleSeasonYearID = b.StyleSeasonYearID 
                                 INNER JOIN pStyleMaterials d ON d.StyleMaterialID = a.StyleMaterialID 
                                 INNER JOIN pStyleColorway e ON e.StyleColorID = a.StyleColorID 
                                 INNER JOIN pStyleColorwayItem f ON ( f.StyleColorID = a.StyleColorID AND f.StyleMaterialID = a.StyleMaterialID 
		                            AND f.MaterialColorID = @MaterialColorID)
                           WHERE c.SeasonYearID = @SeasonYearID
                             AND d.MaterialID = @MaterialID
                             AND a.TradePartnerVendorID = @TradepartnerVendorId
                  ')

               INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
               VALUES ('DB_Version', '2.6.9999', '021', GetDate())


        END
     ELSE

        BEGIN
             select 'Missing Level ' + @LastScriptRun
        END
GO	




