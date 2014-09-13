Create table pStyleTypeTab
(
StyleTypeID int not null,
TabNo int not null, /*Number of the tab (id of the tab)*/
Name nvarchar(200), /*Header text of the tab*/
TabSchema nvarchar(200), /*XML file of the tab*/
Active int,
Position int, /*Sort order*/
primary key(StyleTypeID,TabNo)
)
Go
insert into pStyleTypeTab (StyleTypeID, TabNo , Name , TabSchema , Active , Position ) 
values (10,1,'Style Detail','Style_Category_Default.xml',1,1)

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01991'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.0000'
			,'01991'
			,GetDate()
		)
END	

GO