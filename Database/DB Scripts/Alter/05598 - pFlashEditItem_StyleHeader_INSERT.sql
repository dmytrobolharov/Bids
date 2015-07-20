IF NOT EXISTS(SELECT * FROM pFlashEditFolderItem WHERE FlashEditFormName='Style Header')
BEGIN

	DECLARE @StyleFolderID UNIQUEIDENTIFIER
	SELECT @StyleFolderID = FlashEditFolderID FROM pFlashEditFolder WHERE FlashEditFolderName = 'Style'
	
	IF @StyleFolderID IS NULL
	BEGIN
		SELECT @StyleFolderID = NEWID()
		INSERT INTO pFlashEditFolder (FlashEditFolderId, FlashEditFolderName, FlashEditFolderDesc, FlashEditFolderSort, 
										FlashEditDefaultXML, FlashEditSearchXML, Active)
		VALUES (@StyleFolderID, 'Style', 'Style_Quote_Pre costing', '00001', 'FlashEditFolder_Default.xml', 
				'FlashEditFolder_Search.xml', 1)
	END
	
	INSERT INTO pFlashEditFolderItem(FlashEditFolderItemId, FlashEditFolderId, FlashEditFormName, FlashEditItemName,
										FlashEditItemDescription, FlashEditTableName, FlashEditTablePKI, 
										FlashEditItemSort, FlashEditItemURL, FlashEditItemXML, 
										FlashEditItemSearchXML,FlashEditItemBatchXML, FlashEditItemBatchGridXML, Active)
	VALUES (NEWID(), '985B2F44-EF92-4D27-A606-91B90C579495', 'Style Header', 'Style Header', 
					'Style Header Edit', 'pStyleHeader', 'StyleID',
					'00004', 'FlashEdit_Style_Header_Search.aspx', 'FlashEdit_StyleHeader_Default.xml',
					'FlashEdit_StyleHeader_Search.xml','FlashEdit_StyleHeader_BatchForm.xml','FlashEdit_StyleHeader_BatchGrid.xml', 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05598', GetDate())
GO
