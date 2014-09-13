
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'StyleCareWashFlag' 
            and Object_ID = Object_ID(N'pStyleCare') )
BEGIN
ALTER TABLE pStyleCare ADD  StyleCareWashFlag BIT NULL  DEFAULT 1
END
GO
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'StyleCareCycleFlag' 
            and Object_ID = Object_ID(N'pStyleCare') )
BEGIN
ALTER TABLE pStyleCare ADD  StyleCareCycleFlag BIT  NULL  DEFAULT 1
end
GO
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'StyleCareBleachFlag' 
            and Object_ID = Object_ID(N'pStyleCare') )
BEGIN
ALTER TABLE pStyleCare ADD  StyleCareBleachFlag BIT NULL  DEFAULT 1
END
GO
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'StyleCareDryFlag' 
            and Object_ID = Object_ID(N'pStyleCare') )
BEGIN
ALTER TABLE pStyleCare ADD  StyleCareDryFlag BIT NULL  DEFAULT 1
end
GO
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'StyleCareIronFlag' 
            and Object_ID = Object_ID(N'pStyleCare') )
begin
ALTER TABLE pStyleCare ADD  StyleCareIronFlag BIT NULL  DEFAULT 1
end
GO
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'StyleCareDryCleanFlag' 
            and Object_ID = Object_ID(N'pStyleCare') )
BEGIN
ALTER TABLE pStyleCare ADD  StyleCareDryCleanFlag BIT NULL  DEFAULT 1
END

GO
UPDATE pStyleCare 
SET StyleCareWashFlag= CASE WHEN StyleCareWashFlag IS NULL THEN 1 ELSE StyleCareWashFlag END,
						  StyleCareCycleFlag= CASE WHEN StyleCareCycleFlag IS NULL THEN 1 ELSE StyleCareWashFlag END,
						  StyleCareBleachFlag= CASE WHEN StyleCareBleachFlag IS NULL THEN 1 ELSE StyleCareWashFlag END,
						  StyleCareDryFlag= CASE WHEN StyleCareDryFlag IS NULL THEN 1 ELSE StyleCareDryFlag END,
						  StyleCareIronFlag= CASE WHEN StyleCareIronFlag IS NULL THEN 1 ELSE StyleCareIronFlag END,
						  StyleCareDryCleanFlag= CASE WHEN StyleCareDryCleanFlag IS NULL THEN 1 ELSE StyleCareDryCleanFlag END
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01979'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01979', GetDate())     

END	
GO					
						  