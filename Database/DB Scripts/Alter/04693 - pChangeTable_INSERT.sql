if NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = '7938a3fd-0580-422f-a3a6-895ca0223a81')
begin
	INSERT [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) 
	VALUES (N'7938a3fd-0580-422f-a3a6-895ca0223a81', N'pSourcingTradePartner', N'SourcingTradePartnerID', N'SourcingTradePartnerID', N'ChangeLogItem_Advanced.xml')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04693', GetDate())
GO