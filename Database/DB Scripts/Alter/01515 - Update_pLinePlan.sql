UPDATE pLinePlan set Active = case when Active is null then 1 else Active end

GO

INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01515', GetDate())

GO
