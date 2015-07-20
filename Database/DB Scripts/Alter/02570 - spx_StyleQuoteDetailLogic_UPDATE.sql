IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteDetailLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteDetailLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleQuoteDetailLogic_UPDATE](      
 @StyleQuoteItemID UNIQUEIDENTIFIER    
)      
      
AS      
      
      
/************************/      
/*Declare variables. */      
/************************/      
--General      
DECLARE @StyleId UNIQUEIDENTIFIER      
DECLARE @StyleCostingType INT
     
--pStyleCosting      
DECLARE @QuoteDetail_StyleQuoteItemCustomField5 DECIMAL(18,3) -- FOB Quote
DECLARE @QuoteDetail_StyleQuoteItemCustomField9 DECIMAL(18,3)  -- Commission %
DECLARE @QuoteDetail_StyleQuoteItemCustomField11 DECIMAL(18,5) -- Agent %
DECLARE @QuoteDetail_StyleQuoteItemCustomField13 DECIMAL(18,3) -- Freight
DECLARE @QuoteDetail_StyleQuoteItemCustomField2 DECIMAL(18,3) -- Wholesale
DECLARE @QuoteDetail_StyleQuoteItemCustomField6 DECIMAL(18,3) -- Retail
DECLARE @QuoteDetail_StyleQuoteItemCustomField16 DECIMAL(18,3) -- Proposed Units

DECLARE @QuoteDetail_StyleQuoteItemBOM DECIMAL(18,3) -- BOM Cost
DECLARE @QuoteDetail_StyleQuoteItemBOL DECIMAL(18,3) -- BOL Cost

DECLARE @QuoteDetail_StyleQuoteItemCustomField7 DECIMAL(18,5) -- Duty %
DECLARE @QuoteDetail_StyleQuoteItemCustomField8 DECIMAL(18,3) -- Duty Amount
DECLARE @QuoteDetail_StyleQuoteItemCustomField10 DECIMAL(18,3) -- Commission Amount
DECLARE @QuoteDetail_StyleQuoteItemCustomField12 DECIMAL(18,3) -- Agent Amount
DECLARE @QuoteDetail_StyleQuoteItemCustomField14 DECIMAL(18,3) -- LDP
DECLARE @QuoteDetail_StyleQuoteItemCustomField15 DECIMAL(18,5) -- Wholesale MU %
DECLARE @QuoteDetail_StyleQuoteItemCustomField17 DECIMAL(18,5) -- Retail MU %
DECLARE @QuoteDetail_StyleQuoteItemCustomField18 DECIMAL(18,3) -- Extended LDP Cost
DECLARE @QuoteDetail_StyleQuoteItemCustomField19 DECIMAL(18,3) -- Extended Wholesale
DECLARE @QuoteDetail_StyleQuoteItemCustomField20 DECIMAL(18,3) -- Extended Retail

/************************************************************/      
/*Get some initial data for field pulls for calculations. */      
/************************************************************/      
      
/********************************************/      
/*Get some initial values for calculations. */      
/********************************************/      
      
 
SELECT @StyleId = StyleId 
 ,@StyleCostingType = StyleCostingType    
 ,@QuoteDetail_StyleQuoteItemCustomField5 = ISNULL(StyleQuoteItemCustomField5, 0)      
 ,@QuoteDetail_StyleQuoteItemCustomField9 = ISNULL(StyleQuoteItemCustomField9, 0)      
 ,@QuoteDetail_StyleQuoteItemCustomField11 = ISNULL(StyleQuoteItemCustomField11, 0)      
 ,@QuoteDetail_StyleQuoteItemCustomField13 = ISNULL(StyleQuoteItemCustomField13, 0)      
 ,@QuoteDetail_StyleQuoteItemCustomField2 = ISNULL(StyleQuoteItemCustomField2, 0)      
 ,@QuoteDetail_StyleQuoteItemCustomField6 = ISNULL(StyleQuoteItemCustomField6, 0) 
 ,@QuoteDetail_StyleQuoteItemCustomField7 = ISNULL(StyleQuoteItemCustomField7, 0)  
 ,@QuoteDetail_StyleQuoteItemCustomField16 = ISNULL(StyleQuoteItemCustomField16, 0)   
 ,@QuoteDetail_StyleQuoteItemBOM = ISNULL(BOMCost, 0)  
 ,@QuoteDetail_StyleQuoteItemBOL = ISNULL(BOLCost, 0)   
FROM pStyleQuoteItem      
WHERE StyleQuoteItemID = @StyleQuoteItemID     
      
      
/****************/      
/*Calculations. */      
/****************/      
IF @StyleCostingType = 1   -- IMPORT
 BEGIN      
  /*pStyleCosting.StyleCostingCustomField8 (Duty Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField8 = @QuoteDetail_StyleQuoteItemCustomField5 * @QuoteDetail_StyleQuoteItemCustomField7      
       
       
  /*pStyleCosting.StyleCostingCustomField10 (Commission Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField10 = @QuoteDetail_StyleQuoteItemCustomField5 * @QuoteDetail_StyleQuoteItemCustomField9      
      
        
  /*pStyleCosting.StyleCostingCustomField12 (Agent Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField12 = @QuoteDetail_StyleQuoteItemCustomField5 * @QuoteDetail_StyleQuoteItemCustomField11      
        
        
  /*pStyleCosting.StyleCostingCustomField14 (LDP)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField14 = @QuoteDetail_StyleQuoteItemCustomField5      
              + @QuoteDetail_StyleQuoteItemCustomField8      
              + @QuoteDetail_StyleQuoteItemCustomField10      
              + @QuoteDetail_StyleQuoteItemCustomField12      
              + @QuoteDetail_StyleQuoteItemCustomField13      
                    
                 
  /*@pStyleCosting_StyleCostingCustomField23 (Wholesale MU %)*/      
  IF (@QuoteDetail_StyleQuoteItemCustomField14 IS NULL OR @QuoteDetail_StyleQuoteItemCustomField14 = 0)      
   SET @QuoteDetail_StyleQuoteItemCustomField15 = 0      
    ELSE     
  SET @QuoteDetail_StyleQuoteItemCustomField15 = (@QuoteDetail_StyleQuoteItemCustomField2 - @QuoteDetail_StyleQuoteItemCustomField14) / @QuoteDetail_StyleQuoteItemCustomField2     
     
                          
  /*pStyleCosting.StyleCostingCustomField18 (Retail Markup %)*/      
  IF (@QuoteDetail_StyleQuoteItemCustomField2 IS NULL OR @QuoteDetail_StyleQuoteItemCustomField2 = 0)      
   SET @QuoteDetail_StyleQuoteItemCustomField17 = 0      
  ELSE      
   SET @QuoteDetail_StyleQuoteItemCustomField17 = (@QuoteDetail_StyleQuoteItemCustomField6 - @QuoteDetail_StyleQuoteItemCustomField2)      
               / @QuoteDetail_StyleQuoteItemCustomField6     
                     
                     
  /*pStyleCosting.StyleCostingCustomField20 (Extended LDP Cost)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField18 = @QuoteDetail_StyleQuoteItemCustomField14 * @QuoteDetail_StyleQuoteItemCustomField16      
        
        
  /*pStyleCosting.StyleCostingCustomField21 (Extended Wholesale)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField19 = @QuoteDetail_StyleQuoteItemCustomField2 * @QuoteDetail_StyleQuoteItemCustomField16      
        
        
  /*pStyleCosting.StyleCostingCustomField22 (Extended Retail)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField20 = @QuoteDetail_StyleQuoteItemCustomField6 * @QuoteDetail_StyleQuoteItemCustomField16      
      
END 


IF @StyleCostingType = 3   -- DOMESTIC
 BEGIN      
       
  /*pStyleCosting.StyleCostingCustomField10 (Commission Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField10 = (@QuoteDetail_StyleQuoteItemBOM + @QuoteDetail_StyleQuoteItemBOL) * @QuoteDetail_StyleQuoteItemCustomField9      
      
        
  /*pStyleCosting.StyleCostingCustomField12 (Agent Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField12 = (@QuoteDetail_StyleQuoteItemBOM + @QuoteDetail_StyleQuoteItemBOL) * @QuoteDetail_StyleQuoteItemCustomField11      
        
        
  /*pStyleCosting.StyleCostingCustomField14 (Total Cost)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField14 = @QuoteDetail_StyleQuoteItemBOM + @QuoteDetail_StyleQuoteItemBOL      
              + @QuoteDetail_StyleQuoteItemCustomField10      
              + @QuoteDetail_StyleQuoteItemCustomField12      
              + @QuoteDetail_StyleQuoteItemCustomField13      
                    
                 
  /*@pStyleCosting_StyleCostingCustomField23 (Wholesale MU %)*/      
  IF (@QuoteDetail_StyleQuoteItemCustomField14 IS NULL OR @QuoteDetail_StyleQuoteItemCustomField14 = 0)      
   SET @QuoteDetail_StyleQuoteItemCustomField15 = 0      
    ELSE     
  SET @QuoteDetail_StyleQuoteItemCustomField15 = (@QuoteDetail_StyleQuoteItemCustomField2 - @QuoteDetail_StyleQuoteItemCustomField14) / @QuoteDetail_StyleQuoteItemCustomField2     
     
                          
  /*pStyleCosting.StyleCostingCustomField18 (Retail Markup %)*/      
  IF (@QuoteDetail_StyleQuoteItemCustomField2 IS NULL OR @QuoteDetail_StyleQuoteItemCustomField2 = 0)      
   SET @QuoteDetail_StyleQuoteItemCustomField17 = 0      
  ELSE      
   SET @QuoteDetail_StyleQuoteItemCustomField17 = (@QuoteDetail_StyleQuoteItemCustomField6 - @QuoteDetail_StyleQuoteItemCustomField2)      
               / @QuoteDetail_StyleQuoteItemCustomField6
                     
                     
  /*pStyleCosting.StyleCostingCustomField20 (Extended Cost)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField18 = @QuoteDetail_StyleQuoteItemCustomField14 * @QuoteDetail_StyleQuoteItemCustomField16      
        
        
  /*pStyleCosting.StyleCostingCustomField21 (Extended Wholesale)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField19 = @QuoteDetail_StyleQuoteItemCustomField2 * @QuoteDetail_StyleQuoteItemCustomField16      
        
        
  /*pStyleCosting.StyleCostingCustomField22 (Extended Retail)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField20 = @QuoteDetail_StyleQuoteItemCustomField6 * @QuoteDetail_StyleQuoteItemCustomField16      
      
END 


IF @StyleCostingType = 4   -- INDIRECT
 BEGIN      
  /*pStyleCosting.StyleCostingCustomField8 (Duty Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField8 = @QuoteDetail_StyleQuoteItemCustomField5 * @QuoteDetail_StyleQuoteItemCustomField7      
       
       
  /*pStyleCosting.StyleCostingCustomField10 (Commission Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField10 = @QuoteDetail_StyleQuoteItemCustomField5 * @QuoteDetail_StyleQuoteItemCustomField9      
      
        
  /*pStyleCosting.StyleCostingCustomField12 (Agent Amount)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField12 = @QuoteDetail_StyleQuoteItemCustomField5 * @QuoteDetail_StyleQuoteItemCustomField11      
        
        
  /*pStyleCosting.StyleCostingCustomField14 (Total Cost)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField14 = @QuoteDetail_StyleQuoteItemCustomField5      
              + @QuoteDetail_StyleQuoteItemCustomField8      
              + @QuoteDetail_StyleQuoteItemCustomField10      
              + @QuoteDetail_StyleQuoteItemCustomField12      
              + @QuoteDetail_StyleQuoteItemCustomField13      
                    
                 
  /*@pStyleCosting_StyleCostingCustomField23 (Wholesale MU %)*/      
  IF (@QuoteDetail_StyleQuoteItemCustomField14 IS NULL OR @QuoteDetail_StyleQuoteItemCustomField14 = 0)      
   SET @QuoteDetail_StyleQuoteItemCustomField15 = 0      
    ELSE     
  SET @QuoteDetail_StyleQuoteItemCustomField15 = (@QuoteDetail_StyleQuoteItemCustomField2 - @QuoteDetail_StyleQuoteItemCustomField14) / @QuoteDetail_StyleQuoteItemCustomField2
     
                          
  /*pStyleCosting.StyleCostingCustomField18 (Retail Markup %)*/      
  IF (@QuoteDetail_StyleQuoteItemCustomField2 IS NULL OR @QuoteDetail_StyleQuoteItemCustomField2 = 0)      
   SET @QuoteDetail_StyleQuoteItemCustomField17 = 0      
  ELSE      
   SET @QuoteDetail_StyleQuoteItemCustomField17 = (@QuoteDetail_StyleQuoteItemCustomField6 - @QuoteDetail_StyleQuoteItemCustomField2)      
               / @QuoteDetail_StyleQuoteItemCustomField6     
                     
                     
  /*pStyleCosting.StyleCostingCustomField20 (Extended Cost)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField18 = @QuoteDetail_StyleQuoteItemCustomField14 * @QuoteDetail_StyleQuoteItemCustomField16      
        
        
  /*pStyleCosting.StyleCostingCustomField21 (Extended Wholesale)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField19 = @QuoteDetail_StyleQuoteItemCustomField2 * @QuoteDetail_StyleQuoteItemCustomField16      
        
        
  /*pStyleCosting.StyleCostingCustomField22 (Extended Retail)*/      
  SET @QuoteDetail_StyleQuoteItemCustomField20 = @QuoteDetail_StyleQuoteItemCustomField6 * @QuoteDetail_StyleQuoteItemCustomField16      
      
END 


/************/      
/*Update. */      
/************/      
UPDATE pStyleQuoteItem      
SET StyleQuoteItemCustomField8 = @QuoteDetail_StyleQuoteItemCustomField8      
 ,StyleQuoteItemCustomField10 = @QuoteDetail_StyleQuoteItemCustomField10      
 ,StyleQuoteItemCustomField12 = @QuoteDetail_StyleQuoteItemCustomField12      
 ,StyleQuoteItemCustomField14 = @QuoteDetail_StyleQuoteItemCustomField14      
 ,StyleQuoteItemCustomField15 = @QuoteDetail_StyleQuoteItemCustomField15      
 ,StyleQuoteItemCustomField17 = @QuoteDetail_StyleQuoteItemCustomField17      
 ,StyleQuoteItemCustomField18 = @QuoteDetail_StyleQuoteItemCustomField18      
 ,StyleQuoteItemCustomField19 = @QuoteDetail_StyleQuoteItemCustomField19      
 ,StyleQuoteItemCustomField20 = @QuoteDetail_StyleQuoteItemCustomField20  
 WHERE StyleQuoteItemID = @StyleQuoteItemID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02570'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02570', GetDate())
END
GO