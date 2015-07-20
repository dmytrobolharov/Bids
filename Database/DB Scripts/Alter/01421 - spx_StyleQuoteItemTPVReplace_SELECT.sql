IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemTPVReplace_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleQuoteItemTPVReplace_SELECT]
GO 


CREATE PROCEDURE dbo.spx_StyleQuoteItemTPVReplace_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER,
	@StyleQuoteID UNIQUEIDENTIFIER, 
	@StyleID UNIQUEIDENTIFIER, 
	@search NVARCHAR(MAX)
)
AS 


	DECLARE @SQL NVARCHAR(MAX)
	
	SET @SQL = 'SELECT TradePartnerVendorID, TradePartnerID, VendorCode, VendorName, City, State, Country, Active 
        FROM dbo.uTradePartnerVendor WHERE '

	IF LEN ( ISNULL(@search,'') ) > 0 
	BEGIN 
	
    SET @SQL =  @SQL  + ' (
			VendorCode LIKE ''' + @search + '%'' OR 
			VendorName LIKE ''' + @search + '%'' OR 
            City LIKE  ''' + @search + '%'' OR 
            State LIKE ''' + @search + '%'' OR 
            Country LIKE ''' + @search + '%'' ) AND '
        
	END 
    
    SET @SQL =  @SQL  + ' (Active = 1) AND  (TradePartnerID = ''' + CAST(@TradePartnerID AS NVARCHAR(40)) + ''' ) 
		AND (TradePartnerVendorId NOT IN (SELECT TradePartnerVendorId FROM pStyleQuoteItem 
        WHERE styleQuoteID = ''' + CAST(@StyleQuoteID AS NVARCHAR(40))  + ''' AND StyleId = ''' + CAST(@StyleId AS NVARCHAR(40)) +  ''' ))
        ORDER BY VendorCode, VendorName '
        
     EXECUTE sp_executesql  @SQL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01421', GetDate())

GO




