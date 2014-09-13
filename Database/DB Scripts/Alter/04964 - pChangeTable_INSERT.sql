if NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = '9038A3FD-0580-422F-A3A6-895CA0223A81')
begin
	INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES('9038A3FD-0580-422F-A3A6-895CA0223A81', 'pSourcingCommitmentItem', 'SourcingCommitmentItemID', 'SourcingCommitmentItemID', 'ChangeLogItem_Default.xml')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04964', GetDate())
GO
