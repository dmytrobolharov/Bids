if exists (select * from sSystemStrings WHERE DesignString = 'Attribute')
Update sSystemStrings set DesignString = 'Attribute' where DesignString = 'Attribute'
Go


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05040', GetDate())
GO