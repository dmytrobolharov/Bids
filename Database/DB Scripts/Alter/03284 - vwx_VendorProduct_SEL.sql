IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_VendorProduct_SEL]'))
DROP VIEW [dbo].[vwx_VendorProduct_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create VIEW [dbo].[vwx_VendorProduct_SEL]
AS
SELECT    TradePartnerProductTypeId , TradePartnerId , u.StyleCategoryId as StyleCategoryId,                       
          c.StyleCategory as CategoryName, c.StyleCategoryCode  as CategoryCode, 
          u.Sort as Sort, u.Active as Active, u.MUser as MUser, u.MDate as MDate, u.CDate as CDate, u.CUser as CUser
FROM      uTradePartnerProductType u INNER JOIN
                      pStyleCategory c ON u.StyleCategoryId = c.StyleCategoryId




GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03284'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03284', GetDate())

END
GO