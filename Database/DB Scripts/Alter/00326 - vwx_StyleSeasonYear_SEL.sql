
CREATE VIEW vwx_StyleSeasonYear_SEL
AS

SELECT a.* , b.MaterialName AS MainMaterialName, c.VendorName
FROM pStyleSeasonYear a
INNER JOIN pStyleHeader b ON a.StyleID =  b.StyleID  
LEFT OUTER JOIN uTradePartnerVendor c ON a.TradePartnerVendorID =  c.TradePartnerVendorID
