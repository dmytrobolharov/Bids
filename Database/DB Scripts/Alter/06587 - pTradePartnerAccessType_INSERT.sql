INSERT INTO pTradePartnerAccessType (PartnerAccessTypeID, PartnerAccessTypeDesr, PartnerAccessTypeOrder, Active)
VALUES (0, 'None', 0, 1), (1, 'View', 1, 1), (2, 'Edit', 2, 1)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06587', GetDate())
GO
