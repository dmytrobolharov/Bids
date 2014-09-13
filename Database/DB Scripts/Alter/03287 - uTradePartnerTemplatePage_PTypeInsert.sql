

if not exists (select * from uTradePartnerTemplatePage WHERE UPPER(TradePartnerTemplatePageName) = 'Product Type')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]	
				   ,[TradePartnerTemplatePageURL]			   			   
				   ,[Active])				   
			 VALUES
				   ('Product Type'
				   ,'Product Type'	
				   ,'Vendor_FolderPage_ProductType.aspx'			   			  
				   ,1
				  )
	end
	

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03287'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03287', GetDate())

END

GO