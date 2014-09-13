IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleCostingLogic_UPDATE](    
 @StyleCostingId UNIQUEIDENTIFIER    
 ,@StyleSeasonYearID UNIQUEIDENTIFIER     
)    
    
AS    
    
    
/************************/    
/*Declare variables. */    
/************************/    
--General    
DECLARE @StyleId UNIQUEIDENTIFIER    
    
--pStyleCostingHeader    
DECLARE @pStyleCostingHeader_StyleCostingHeaderId UNIQUEIDENTIFIER    
    
--pStyleCosting    
DECLARE @pStyleCosting_StyleCostingTypeId INT    
    
DECLARE @pStyleCosting_StyleCostingCustomField6 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField7 DECIMAL(18,5)    
DECLARE @pStyleCosting_StyleCostingCustomField8 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField9 DECIMAL(18,5)    
DECLARE @pStyleCosting_StyleCostingCustomField10 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField11 DECIMAL(18,5)    
DECLARE @pStyleCosting_StyleCostingCustomField12 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField13 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField14 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField15 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField16 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField17 DECIMAL(18,5)    
DECLARE @pStyleCosting_StyleCostingCustomField18 DECIMAL(18,5)    
DECLARE @pStyleCosting_StyleCostingCustomField19 INT    
DECLARE @pStyleCosting_StyleCostingCustomField20 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField21 DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingCustomField22 DECIMAL(18,3)   
DECLARE @pStyleCosting_StyleCostingCustomField23 DECIMAL(18,5)   
    
DECLARE @pStyleCosting_StyleCostingBOM DECIMAL(18,3)    
DECLARE @pStyleCosting_StyleCostingBOL DECIMAL(18,3)    
    
/************************************************************/    
/*Get some initial data for field pulls for calculations. */    
/************************************************************/    
/*Get the 'StyleId' and the 'StyleSeasonYearId', in case the 'StyleSeasonYearId' wasn't passed in the parameters.*/    
SELECT @StyleId = StyleId    
 ,@StyleSeasonYearId = StyleSeasonYearId    
FROM pStyleCosting    
WHERE StyleCostingId = @StyleCostingId    
    
    
/*Get the 'StyleCostingHeaderId'.*/    
SELECT @pStyleCostingHeader_StyleCostingHeaderId = StyleCostingHeaderId    
FROM pStyleCostingHeader    
WHERE StyleId = @StyleId    
 AND StyleSeasonYearId = @StyleSeasonYearId    
    
    
/********************************************/    
/*Get some initial values for calculations. */    
/********************************************/    
--pStyleCostingHeader    
SELECT @pStyleCosting_StyleCostingCustomField15 = ISNULL(StyleCostingCustomField1, 0)    
 ,@pStyleCosting_StyleCostingCustomField16 = ISNULL(StyleCostingCustomField2, 0)    
FROM pStyleCostingHeader    
WHERE StyleCostingHeaderId = @pStyleCostingHeader_StyleCostingHeaderId    
    
    
--pStyleCosting    
SELECT @pStyleCosting_StyleCostingTypeId = StyleCostingTypeId    
    
 ,@pStyleCosting_StyleCostingCustomField6 = ISNULL(StyleCostingCustomField6, 0)    
 ,@pStyleCosting_StyleCostingCustomField7 = ISNULL(StyleCostingCustomField7, 0)    
 ,@pStyleCosting_StyleCostingCustomField9 = ISNULL(StyleCostingCustomField9, 0)    
 ,@pStyleCosting_StyleCostingCustomField11 = ISNULL(StyleCostingCustomField11, 0)    
 ,@pStyleCosting_StyleCostingCustomField13 = ISNULL(StyleCostingCustomField13, 0)    
 ,@pStyleCosting_StyleCostingCustomField19 = ISNULL(StyleCostingCustomField19, 0)    
 ,@pStyleCosting_StyleCostingBOM = ISNULL(BOMCost, 0)    
 ,@pStyleCosting_StyleCostingBOL = ISNULL(BOLCost, 0)    
FROM pStyleCosting    
WHERE StyleCostingId = @StyleCostingId    
    
    
/****************/    
/*Calculations. */    
/****************/    
IF (@pStyleCosting_StyleCostingTypeId = 1) --Import    
 BEGIN    
  /*pStyleCosting.StyleCostingCustomField8 (Duty Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField8 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField7    
     
     
  /*pStyleCosting.StyleCostingCustomField10 (Commission Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField10 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField9    
    
      
  /*pStyleCosting.StyleCostingCustomField12 (Agent Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField12 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField11    
      
      
  /*pStyleCosting.StyleCostingCustomField14 (LDP)*/    
  SET @pStyleCosting_StyleCostingCustomField14 = @pStyleCosting_StyleCostingCustomField6    
              + @pStyleCosting_StyleCostingCustomField8    
              + @pStyleCosting_StyleCostingCustomField10    
              + @pStyleCosting_StyleCostingCustomField12    
              + @pStyleCosting_StyleCostingCustomField13    
                  
                  
  --/*pStyleCosting.StyleCostingCustomField17 (Wholesale Markup %)*/    
  --IF (@pStyleCosting_StyleCostingCustomField15 IS NULL OR @pStyleCosting_StyleCostingCustomField15 = 0)    
  -- SET @pStyleCosting_StyleCostingCustomField17 = 0    
  --ELSE    
  -- SET @pStyleCosting_StyleCostingCustomField17 = (@pStyleCosting_StyleCostingCustomField15 - @pStyleCosting_StyleCostingCustomField14)    
  --             / @pStyleCosting_StyleCostingCustomField15    
                   
                   
  /*pStyleCosting.StyleCostingCustomField18 (Retail Markup %)*/    
  IF (@pStyleCosting_StyleCostingCustomField15 IS NULL OR @pStyleCosting_StyleCostingCustomField15 = 0)    
   SET @pStyleCosting_StyleCostingCustomField18 = 0    
  ELSE    
   SET @pStyleCosting_StyleCostingCustomField18 = (@pStyleCosting_StyleCostingCustomField16 - @pStyleCosting_StyleCostingCustomField15)    
               / @pStyleCosting_StyleCostingCustomField16   
                   
                   
  /*pStyleCosting.StyleCostingCustomField20 (Extended LDP Cost)*/    
  SET @pStyleCosting_StyleCostingCustomField20 = @pStyleCosting_StyleCostingCustomField14 * @pStyleCosting_StyleCostingCustomField19    
      
      
  /*pStyleCosting.StyleCostingCustomField21 (Extended Wholesale)*/    
  SET @pStyleCosting_StyleCostingCustomField21 = @pStyleCosting_StyleCostingCustomField15 * @pStyleCosting_StyleCostingCustomField19    
      
      
  /*pStyleCosting.StyleCostingCustomField22 (Extended Retail)*/    
  SET @pStyleCosting_StyleCostingCustomField22 = @pStyleCosting_StyleCostingCustomField16 * @pStyleCosting_StyleCostingCustomField19    
    
  /*@pStyleCosting_StyleCostingCustomField23 (Wholesale MU %)*/    
  IF (@pStyleCosting_StyleCostingCustomField14 IS NULL OR @pStyleCosting_StyleCostingCustomField14 = 0)    
   SET @pStyleCosting_StyleCostingCustomField23 = 0    
    ELSE   
  SET @pStyleCosting_StyleCostingCustomField23 = (@pStyleCosting_StyleCostingCustomField15 - @pStyleCosting_StyleCostingCustomField14) / @pStyleCosting_StyleCostingCustomField15   
   
   
   
 END    
    


IF (@pStyleCosting_StyleCostingTypeId = 3) --Domestic    
 BEGIN
  /*pStyleCosting.StyleCostingCustomField10 (Commission Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField10 = (@pStyleCosting_StyleCostingBOM + @pStyleCosting_StyleCostingBOL) * @pStyleCosting_StyleCostingCustomField9    

  /*pStyleCosting.StyleCostingCustomField12 (Agent Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField12 = (@pStyleCosting_StyleCostingBOM + @pStyleCosting_StyleCostingBOL) * @pStyleCosting_StyleCostingCustomField11    

  /*pStyleCosting.StyleCostingCustomField14 (Total Cost)*/    
  SET @pStyleCosting_StyleCostingCustomField14 = 
				@pStyleCosting_StyleCostingBOM
			  + @pStyleCosting_StyleCostingBOL
              + @pStyleCosting_StyleCostingCustomField10
              + @pStyleCosting_StyleCostingCustomField12
              + @pStyleCosting_StyleCostingCustomField13


  /*pStyleCosting.StyleCostingCustomField18 (Retail Markup %)*/    
  IF (@pStyleCosting_StyleCostingCustomField15 IS NULL OR @pStyleCosting_StyleCostingCustomField15 = 0)    
   SET @pStyleCosting_StyleCostingCustomField18 = 0    
  ELSE    
   SET @pStyleCosting_StyleCostingCustomField18 = (@pStyleCosting_StyleCostingCustomField16 - @pStyleCosting_StyleCostingCustomField15)    
               / @pStyleCosting_StyleCostingCustomField16   
                   
                   
  /*pStyleCosting.StyleCostingCustomField20 (Extended Cost)*/    
  SET @pStyleCosting_StyleCostingCustomField20 = @pStyleCosting_StyleCostingCustomField14 * @pStyleCosting_StyleCostingCustomField19    
      
      
  /*pStyleCosting.StyleCostingCustomField21 (Extended Wholesale)*/    
  SET @pStyleCosting_StyleCostingCustomField21 = @pStyleCosting_StyleCostingCustomField15 * @pStyleCosting_StyleCostingCustomField19    
      
      
  /*pStyleCosting.StyleCostingCustomField22 (Extended Retail)*/    
  SET @pStyleCosting_StyleCostingCustomField22 = @pStyleCosting_StyleCostingCustomField16 * @pStyleCosting_StyleCostingCustomField19    
    
  /*@pStyleCosting_StyleCostingCustomField23 (Wholesale MU %)*/    
  IF (@pStyleCosting_StyleCostingCustomField14 IS NULL OR @pStyleCosting_StyleCostingCustomField14 = 0)    
   SET @pStyleCosting_StyleCostingCustomField23 = 0    
    ELSE   
  SET @pStyleCosting_StyleCostingCustomField23 = (@pStyleCosting_StyleCostingCustomField15 - @pStyleCosting_StyleCostingCustomField14) / @pStyleCosting_StyleCostingCustomField15

 END


IF (@pStyleCosting_StyleCostingTypeId = 4) --Indirect    
 BEGIN    
  /*pStyleCosting.StyleCostingCustomField8 (Duty Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField8 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField7    
     
     
  /*pStyleCosting.StyleCostingCustomField10 (Commission Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField10 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField9    
    
      
  /*pStyleCosting.StyleCostingCustomField12 (Agent Amount)*/    
  SET @pStyleCosting_StyleCostingCustomField12 = @pStyleCosting_StyleCostingCustomField6 * @pStyleCosting_StyleCostingCustomField11    
      
      
  /*pStyleCosting.StyleCostingCustomField14 (Total Cost)*/    
  SET @pStyleCosting_StyleCostingCustomField14 = @pStyleCosting_StyleCostingCustomField6    
              + @pStyleCosting_StyleCostingCustomField8    
              + @pStyleCosting_StyleCostingCustomField10    
              + @pStyleCosting_StyleCostingCustomField12    
              + @pStyleCosting_StyleCostingCustomField13    
                  
                  
  /*pStyleCosting.StyleCostingCustomField18 (Retail Markup %)*/    
  IF (@pStyleCosting_StyleCostingCustomField15 IS NULL OR @pStyleCosting_StyleCostingCustomField15 = 0)    
   SET @pStyleCosting_StyleCostingCustomField18 = 0    
  ELSE    
   SET @pStyleCosting_StyleCostingCustomField18 = (@pStyleCosting_StyleCostingCustomField16 - @pStyleCosting_StyleCostingCustomField15)    
               / @pStyleCosting_StyleCostingCustomField16   
                   
                   
  /*pStyleCosting.StyleCostingCustomField20 (Extended Cost)*/    
  SET @pStyleCosting_StyleCostingCustomField20 = @pStyleCosting_StyleCostingCustomField14 * @pStyleCosting_StyleCostingCustomField19    
      
      
  /*pStyleCosting.StyleCostingCustomField21 (Extended Wholesale)*/    
  SET @pStyleCosting_StyleCostingCustomField21 = @pStyleCosting_StyleCostingCustomField15 * @pStyleCosting_StyleCostingCustomField19    
      
      
  /*pStyleCosting.StyleCostingCustomField22 (Extended Retail)*/    
  SET @pStyleCosting_StyleCostingCustomField22 = @pStyleCosting_StyleCostingCustomField16 * @pStyleCosting_StyleCostingCustomField19    
    
  /*@pStyleCosting_StyleCostingCustomField23 (Wholesale MU %)*/    
  IF (@pStyleCosting_StyleCostingCustomField14 IS NULL OR @pStyleCosting_StyleCostingCustomField14 = 0)    
   SET @pStyleCosting_StyleCostingCustomField23 = 0    
    ELSE   
  SET @pStyleCosting_StyleCostingCustomField23 = (@pStyleCosting_StyleCostingCustomField15 - @pStyleCosting_StyleCostingCustomField14) / @pStyleCosting_StyleCostingCustomField15   
   
 END    
    
/************/    
/*Update. */    
/************/    
UPDATE pStyleCosting    
SET StyleCostingCustomField8 = @pStyleCosting_StyleCostingCustomField8    
 ,StyleCostingCustomField10 = @pStyleCosting_StyleCostingCustomField10    
 ,StyleCostingCustomField12 = @pStyleCosting_StyleCostingCustomField12    
 ,StyleCostingCustomField14 = @pStyleCosting_StyleCostingCustomField14    
 ,StyleCostingCustomField15 = @pStyleCosting_StyleCostingCustomField15    
 ,StyleCostingCustomField16 = @pStyleCosting_StyleCostingCustomField16    
 ,StyleCostingCustomField17 = @pStyleCosting_StyleCostingCustomField17    
 ,StyleCostingCustomField18 = @pStyleCosting_StyleCostingCustomField18    
 ,StyleCostingCustomField20 = @pStyleCosting_StyleCostingCustomField20    
 ,StyleCostingCustomField21 = @pStyleCosting_StyleCostingCustomField21    
 ,StyleCostingCustomField22 = @pStyleCosting_StyleCostingCustomField22  
 ,StyleCostingCustomField23 = @pStyleCosting_StyleCostingCustomField23    
WHERE StyleCostingId = @StyleCostingId

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02569'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02569', GetDate())
END
GO