if not exists (select * from uTradePartnerTemplatePage WHERE TradePartnerTemplatePageName = 'Equipment')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]	
				   ,[TradePartnerTemplatePageURL]			   			   
				   ,[Active])				   
			 VALUES
				   ('Equipment'
				   ,'Equipment'	
				   ,'Vendor_FolderPage_Equipment.aspx'			   			  
				   ,1
				  )
	end
	

GO

if not exists (select * from uTradePartnerTemplatePage WHERE TradePartnerTemplatePageName = 'Infrastructure')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]	
				   ,[TradePartnerTemplatePageURL]			   			   
				   ,[Active])				   
			 VALUES
				   ('Infrastructure'
				   ,'Infrastructure'	
				   ,'Vendor_FolderPage_Infrastructure.aspx'			   			  
				   ,1
				  )
	end
	

GO

if not exists (select * from uTradePartnerTemplatePage WHERE TradePartnerTemplatePageName = 'Compliance')
	begin
		INSERT INTO [uTradePartnerTemplatePage]
				   ([TradePartnerTemplatePageName]
				   ,[TradePartnerTemplatePageDesc]	
				   ,[TradePartnerTemplatePageURL]			   			   
				   ,[Active])				   
			 VALUES
				   ('Compliance'
				   ,'Compliance'	
				   ,'Vendor_FolderPage_Compliance.aspx'			   			  
				   ,1
				  )
	end
	

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03891', GetDate())



GO