-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleColorwayDeliveryStatus_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleColorwayDeliveryStatus_INSERT
GO

CREATE PROCEDURE spx_StyleColorwayDeliveryStatus_INSERT
(
	@StyleColorID UNIQUEIDENTIFIER ,
	@StyleID UNIQUEIDENTIFIER,
	@StyleColorDel1 INT,
	@StyleColorDel2 INT,
	@StyleColorDel3 INT,
	@StyleColorDel4 INT,
	@MUser VARCHAR(200),
	@MDate DATETIME,
	@StyleColorCollection NVARCHAR(200) ,
	@Units INT,
	@SeasonYearID UNIQUEIDENTIFIER ,
	@ColorType NVARCHAR(5),
	@SampleStatus INT,
	@ProdStatus INT,
	@outputMsg VARCHAR(8000) = null output
)
AS


DECLARE @StyleColorName NVARCHAR(200)
DECLARE @Msg NVARCHAR(4000)
DECLARE @ColorDescription NVARCHAR(500)
DECLARE @StyleNo NVARCHAR(50)

SET @Msg = ''

SELECT @StyleColorName = StyleColorName FROM pStyleColorway WHERE StyleColorID = @StyleColorID IF @StyleColorName IS NULL 
                SET @StyleColorName = ''


set @ColorDescription = ''

SELECT @StyleNo = StyleNo  FROM pStyleHeader WHERE StyleID = @StyleID
IF @StyleNo IS NOT NULL 
                SET @ColorDescription = 'StyleNo: (' + @StyleNo  + ')' +  '<br/>'
SET @ColorDescription =  @ColorDescription + 'Colour Name: ' + @StyleColorName + '<br/>'




IF @SampleStatus = 200 OR  @ProdStatus = 200 OR @SampleStatus = 300 OR  @ProdStatus = 300 
BEGIN 

--             IF LEN (@StyleColorCollection) = 0
--                             SET @Msg = @Msg + 'Collection not defined<br/> '
--
--             IF LEN (@ColorType) = 0
--                             SET @Msg = @Msg + 'R/S/F not defined<br/> '

                -- CHECK FOR MAIN MATERIAL AND COMPOSITION 
                
                IF ( SELECT COUNT(*) FROM  pStyleMaterials a 
                                WHERE a.StyleID = @StyleID
                                AND a.MainMaterial = 1 ) = 0 
                                                SET @Msg = @Msg + 'Style Main Material not defined<br/>'
--             ELSE
--             BEGIN
--
--                             IF ( SELECT COUNT(*)
--                             FROM pStylematerials a
--                             INNER JOIN pMaterialContent b ON  a.MaterialID = b.MaterialID 
--                             WHERE a.StyleID = @StyleID
--                             AND a.MainMaterial = 1
--                             AND LEN (ISNULL ( b.MaterialContentName , '')) > 0  ) = 0
--                                             SET @Msg = @Msg + 'Main Material Composition not defined<br/>'
--                                             
--             END 

                --  CHECK FOR StyleHeader fields 
                IF LEN(@Msg) = 0 
                                EXEC dbo.spx_StyleStatus_Logic_UPDATE @StyleID=@StyleID,
                                @StatusID=1,@MUser=@MUser, @MDate=@MDate, @OUT=0, @MSG=@Msg OUTPUT 


                -- CHECK FOR Sourcing / MostLikely Vendor 
--             IF ( SELECT COUNT(*) FROM pStyleSourcing a 
--                             INNER JOIN pStyleSeasonYear b ON a.StyleSeasonYearID = b.StyleSeasonYearID 
--                             WHERE a.StyleID = @StyleID
--                             AND b.SeasonYearID = @SeasonYearID 
--                             AND b.TradePartnerVendorID IS NOT NULL
--                             ) = 0 
--                             SET @Msg = @Msg + 'Most Likely Vendor not defined<br/>'
END 

IF LEN (@Msg) = 0
BEGIN 

                DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

                SET @StyleColorDel4 = 0
                
                IF @StyleColorDel1 = 1 
                                SELECT @StyleColorDel2=1, @StyleColorDel3=1 
                ELSE IF @StyleColorDel2 = 1 
                                SET @StyleColorDel3 = 1


                SELECT @StyleSeasonYearID = StyleSeasonYearID  
                FROM  pStyleSeasonYear
                WHERE SeasonYearID = @SeasonYearID 
                AND StyleID = @StyleID 

                UPDATE pStyleColorwaySeasonYear SET
                                StyleColorDelivery1 = @StyleColorDel1, 
                                StyleColorDelivery2 = @StyleColorDel2, 
                                StyleColorDelivery3 = @StyleColorDel3,
                                StyleColorDelivery4 = @StyleColorDel4,
                                StyleColorStatus = @ProdStatus,
                                CustomField1 = @StyleColorCollection,
                                Units = @Units,
                                ColorType = @ColorType,
                                SampleStatus = @SampleStatus
                WHERE StyleID = @StyleID 
                AND StyleColorwayID = @StyleColorID 
                AND StyleSeasonYearID = @StyleSeasonYearID



END 


IF LEN (@Msg) > 0 
                SET @Msg = @ColorDescription + ' ' +  @Msg  

IF @outputMsg IS NULL 
                SELECT @Msg as [Message]
ELSE
                SET @outputMsg = @Msg
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '02955', GetDate())
GO

SET NOCOUNT Off
GO
