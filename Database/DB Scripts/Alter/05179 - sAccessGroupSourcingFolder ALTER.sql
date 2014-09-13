
delete from sAccessSourcingFolder
delete from sAccessGroupSourcingFolder

GO

alter table sAccessGroupSourcingFolder 
drop column SourcingTypeId

GO

ALTER TABLE sAccessGroupSourcingFolder
add sourcingTypeId uniqueidentifier 

  
alter table sAccessSourcingFolder
drop column SourcingTypeId

GO

ALTER TABLE sAccessSourcingFolder
add sourcingTypeId uniqueidentifier 
GO

insert into pSourcingType(SourcingCode, SourcingTypeName,Active,Sort) values('Specified','Specified sourcing',1,'0000')

update pSourcingHeader set SourcingType=null 

alter table psourcingheader 
alter column sourcingType uniqueidentifier

update pSourcingHeader set SourcingType = (select top 1 sourcingtypeid from pSourcingType where SourcingCode='Specified' and SourcingTypeName='Specified sourcing') 

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05179', GetDate())
GO