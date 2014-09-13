IF (SELECT COUNT(WebServiceName)
       FROM sWebService
       WHERE UPPER(WebServiceName) = UPPER('Material')) >= 1
BEGIN

	declare @webServiceID nvarchar(max)
		set @webServiceID = (select WebServiceID from sWebService where UPPER(WebServiceName) = UPPER('Material'))
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style BOM Color')) < 1
		BEGIN
			-- Style BOM
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style BOM Color', '', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style BOM Color Auto')) < 1
		BEGIN
			-- Style BOM
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style BOM Color Auto', '', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style BOM Material')) < 1
		BEGIN
			-- Style BOM
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style BOM Material', '', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style BOM Material Summary')) < 1
		BEGIN
			-- Style BOM
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style BOM Material Summary', '', 1)
       
		END
				
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style BOM Dimension')
			   and WebServiceItemDefaultSchema = 'Style_BOM_Dimension_Default.xml') < 1
		BEGIN
			-- Style BOM Dimension
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style BOM Dimension', 'Style_BOM_Dimension_Default.xml', 1)
       
		END
		
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style BOM Temp')
			   and WebServiceItemDefaultSchema = 'Style_BOM_Temp_Default.xml') < 1
		BEGIN
			-- Style BOM Dimension
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style BOM Temp', 'Style_BOM_Temp_Default.xml', 1)
       
		END
		
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style Dim BOM Material Replace')
			   and WebServiceItemDefaultSchema = 'Style_DBOMMaterial_Replace_Select.xml') < 1
		BEGIN
			-- Style BOM Dimension
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style Dim BOM Material Replace', 'Style_DBOMMaterial_Replace_Select.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style Material Replace')
			   and WebServiceItemDefaultSchema = 'Style_Material_Replace_Select.xml') < 1
		BEGIN
			-- Style BOM Dimension
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style Material Replace', 'Style_Material_Replace_Select.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Style Material Temp')
			   and WebServiceItemDefaultSchema = 'Style_Material_Temp_Select.xml') < 1
		BEGIN
			-- Style BOM Dimension
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Style Material Temp', 'Style_Material_Temp_Select.xml', 1)
       
		END
		
		IF (SELECT COUNT(WebServiceItemName)
			  FROM sWebServiceItem
			 WHERE UPPER(WebServiceItemName) = UPPER('Material Template')
			   and WebServiceItemDefaultSchema = 'Material_Template_Default.xml') < 1
		BEGIN
			-- Style BOM Dimension
			INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
			VALUES (@webServiceID, NEWID(), 'Material Template', 'Material_Template_Default.xml', 1)
       
		END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05522', GetDate())
GO


