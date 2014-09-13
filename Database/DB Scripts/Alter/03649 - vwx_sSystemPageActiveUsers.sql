IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_sSystemPageActiveUsers')
drop view vwx_sSystemPageActiveUsers
go

create view vwx_sSystemPageActiveUsers
    as
(
select spau.UserId, PagePathAccessed,
	   case MiddleName
			when null then 
				FirstName + ' ' + MiddleName + ' ' + LastName
			else
				FirstName + ' ' + LastName
		end UserName
  from sSystemPageActiveUser spau
	   left outer join Users u on u.UserId = spau.UserId 
)

go



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03649', GetDate())
go

