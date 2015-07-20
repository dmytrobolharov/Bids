Update pStyleHeader Set UserCID = NULL 
Update pStyleHeader Set UserMID = NULL
alter table pStyleHeader DROP column UserCID
alter table pStyleHeader DROP column UserMID
alter table pStyleHeader add UserCID uniqueidentifier null
alter Table pStyleHeader add UserMID uniqueidentifier null
go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02221'))
      BEGIN
            INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
            VALUES ('DB_Version', '4.1.0000', '02221', GetDate())
      END
GO