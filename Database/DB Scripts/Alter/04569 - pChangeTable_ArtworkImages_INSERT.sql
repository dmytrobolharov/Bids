IF NOT EXISTS (SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID = '60000000-0000-0000-0000-000000000666')
BEGIN
	INSERT INTO pStyleWorkflowToChangeTable (WorkflowID, ChangeTableID)
	VALUES ('60000000-0000-0000-0000-000000000666','0DD00510-ABCA-DFAF-AF06-F0001900101F')
END

IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '0DD00510-ABCA-DFAF-AF06-F0001900101F')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('0DD00510-ABCA-DFAF-AF06-F0001900101F', 'pStyleColorwayArtwork','StyleID','SpecID','ChangeLogItem_Advanced.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04569', GetDate())
GO
