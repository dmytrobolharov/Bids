alter table pStyleHeader
add DivisionID uniqueidentifier

GO

ALTER table pStyleHeader
add  StyleThemeID uniqueidentifier

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05304', GetDate())
GO