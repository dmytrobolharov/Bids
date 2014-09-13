update mapping set MapPageUrl='Style_SKUItem_View.aspx' where map = '40000000-0000-0000-0000-000000000090'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08195', GetDate())
GO