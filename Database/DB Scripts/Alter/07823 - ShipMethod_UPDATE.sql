UPDATE ShipMethod SET CarrierURL = 'http://webtrack.dhlglobalmail.com/?trackingnumber=' WHERE CarrierName = 'DHL'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07823', GetDate())
GO
