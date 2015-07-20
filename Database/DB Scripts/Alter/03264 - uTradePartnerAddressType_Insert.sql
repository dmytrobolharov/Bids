
if not exists (select * from uTradePartnerAddressType WHERE UPPER(TradePartnerAddressName) = 'BILLING')
begin
	INSERT INTO [uTradePartnerAddressType]
	([TradePartnerAddressName]
   ,[TradePartnerAddressDesc])
	VALUES
   ('Billing'           
   ,'Billing')
end

GO

if not exists (select * from uTradePartnerAddressType WHERE UPPER(TradePartnerAddressName) = 'HEADQUARTER')
begin
	INSERT INTO [uTradePartnerAddressType]
	([TradePartnerAddressName]
   ,[TradePartnerAddressDesc])
	VALUES
   ('Headquarter'           
   ,'Headquarter')
end

GO


if not exists (select * from uTradePartnerAddressType WHERE UPPER(TradePartnerAddressName) = 'MANUFACTURING')
begin
	INSERT INTO [uTradePartnerAddressType]
	([TradePartnerAddressName]
   ,[TradePartnerAddressDesc])
	VALUES
   ('Manufacturing'           
   ,'Manufacturing')
end

GO


if not exists (select * from uTradePartnerAddressType WHERE UPPER(TradePartnerAddressName) = 'SHIPPING')
begin
	INSERT INTO [uTradePartnerAddressType]
	([TradePartnerAddressName]
   ,[TradePartnerAddressDesc])
	VALUES
   ('Shipping'           
   ,'Shipping')
end

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03264'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03264', GetDate())

END

GO