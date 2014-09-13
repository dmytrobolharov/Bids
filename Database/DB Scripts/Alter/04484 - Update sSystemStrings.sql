if exists (select * from sSystemStrings WHERE DesignString = 'Bill Of Labor v.2')
Update sSystemStrings set DesignString = 'Bill of Labor v.2' where DesignString = 'Bill Of Labor v.2'
Go

if exists (select * from sSystemStrings WHERE DesignString = 'Bill of Labor')
Update sSystemStrings set DesignString = 'Bill of Labor' where DesignString = 'Bill Of Labor'
Go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04484', GetDate())
GO