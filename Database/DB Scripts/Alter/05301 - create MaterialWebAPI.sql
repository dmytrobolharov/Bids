IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Material')) >= 1
BEGIN

	declare @webServiceID nvarchar(max)
		set @webServiceID = (select WebServiceID from sWebService where UPPER(WebServiceName) = UPPER('Material'))
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material')) < 1
		BEGIN
			-- Material Type
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material', 'Material_Default.xml', 1)
       
		END

		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Type')) < 1
		BEGIN
			-- Material Type
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Type', 'MaterialType_Default.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Template')
			   and WebServiceItemDefaultSchema = 'Material_Template_Default.xml') < 1
		BEGIN
			-- Material Template
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Template', 'Material_Template_Default.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Size')
			   and WebServiceItemDefaultSchema = 'Material_Size_Default.xml') < 1
		BEGIN
			-- Material Template
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Size', 'Material_Size_Default.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Season Year')
			   and WebServiceItemDefaultSchema = 'Material_SeasonYear_Default.xml') < 1
		BEGIN
			-- Material Template
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Season Year', 'Material_SeasonYear_Default.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Color')
			   and WebServiceItemDefaultSchema = 'Material_Color_Default.xml') < 1
		BEGIN
			-- Material Template
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Color', 'Material_Color_Default.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Color Pending')
			   and WebServiceItemDefaultSchema = 'Material_Color_Pending_Default.xml') < 1
		BEGIN
			-- Material Template
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Color Pending', 'Material_Color_Pending_Default.xml', 1)
       
		END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05301', GetDate())
GO


