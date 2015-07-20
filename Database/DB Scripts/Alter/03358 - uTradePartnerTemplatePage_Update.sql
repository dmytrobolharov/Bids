Update uTradePartnerTemplatePage set TradePartnerTemplatePageURL = 'Vendor_FolderPage_Relationship_Folder.aspx'
where TradePartnerTemplatePageName = 'Relationship'
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03358'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03358', GetDate())

END

GO