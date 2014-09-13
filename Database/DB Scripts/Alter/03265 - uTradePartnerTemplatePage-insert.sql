IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='TradePartnerTemplatePageURL' AND TABLE_NAME='uTradePartnerTemplatePage')
BEGIN
	ALTER TABLE uTradePartnerTemplatePage ADD TradePartnerTemplatePageURL nvarchar(200) NULL
END
go

update uTradePartnerTemplatePage set TradePartnerTemplatePageURL = 'Vendor_FolderPage_ShippingInfo.aspx' where  UPPER(TradePartnerTemplatePageName) = 'SHIPPING INFO'

update uTradePartnerTemplatePage set TradePartnerTemplatePageURL = 'Vendor_FolderPage_Relationship.aspx' where  UPPER(TradePartnerTemplatePageName) = 'RELATIONSHIP'

update uTradePartnerTemplatePage set TradePartnerTemplatePageURL = 'Vendor_FolderPage_Capacity.aspx' where  UPPER(TradePartnerTemplatePageName) = 'CAPACITY'

go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03265'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03265', GetDate())

END
GO