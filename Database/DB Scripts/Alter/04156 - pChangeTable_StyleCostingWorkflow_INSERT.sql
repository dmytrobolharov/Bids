IF EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID='D612FAAE-7ACD-DF11-AF06-005056C00023')
BEGIN
	UPDATE pChangeTable SET ChangeTableName = 'pStyleCostingScenarioItems'
	WHERE ChangeTableID='D612FAAE-7ACD-DF11-AF06-005056C00023'
END

IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID='D612FAAE-7ACD-DF11-AF06-005056C00024')
BEGIN
	INSERT INTO pChangeTable VALUES('D612FAAE-7ACD-DF11-AF06-005056C00024', 'pStyleCosting', 'StyleID', 'StyleCostingID', 'ChangeLogItem_Advanced.xml')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04156', GetDate())
GO
