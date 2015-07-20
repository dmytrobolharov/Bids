if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Vendor/Price')
begin
Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelIdSchema,ControlPanelSchema,ControlPanelSearchSchema, ControlPanelTableName,ControlPanelUrl,ControlPanelEditSchema,SPXLogicInsert,SPXLogicUpdate,ControlPanelTypeID,ControlPanelRepId,IsDataValidation) 
values (301,'Vendor/Price', 'Vendor/Price', 301, NULL, 'Control_TradePartnerVendor_Rate_Default.xml', 'Control_TradePartnerVendor_Rate_Search.xml', 'pTradePartnerVendorRate' , 'Control_TradePartnerVendorRate_List.aspx?CPID=301', 'Control_TradePartnerVendor_RateEdit_Default.xml' ,NULL ,NULL, 'ecc16935-3677-e011-8802-000c29807141', '4b5929e6-0fbe-4286-9fac-494af297ff2d', 0)

end
else
Update pControlPanel set ControlPanelEditSchema = 'Control_TradePartnerVendor_RateEdit_Default.xml' where ControlPanelName = 'Vendor/Price' ;
go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02281'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02281', GetDate())
	END
GO	
	