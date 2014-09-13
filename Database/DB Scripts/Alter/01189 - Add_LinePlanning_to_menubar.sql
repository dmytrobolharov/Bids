insert into sDeskTop
   values(10, 'Line Planning', 'Line Planning', 'icon_image_catalog.gif',
		'Line Planning', 'Folder', 
		'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=9&TID=##TEAMID##'';',
		'../LinePlan/LinePlan_Menu.aspx',
		'../LinePlan/LinePlan_List_Grid.aspx?',
		10, 0 )

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01189', GetDate())