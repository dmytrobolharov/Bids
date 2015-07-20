UPDATE pChangeTable SET ChangeTableFieldName = 'WorkFlowItemID' WHERE ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00016' AND ChangeTableFieldName = 'StyleID'
UPDATE pChangeTable SET ChangeTableFieldName = 'WorkFlowItemID' WHERE ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00017' AND ChangeTableFieldName = 'StyleID'
UPDATE pChangeTable SET ChangeTableFieldName = 'WorkFlowItemID' WHERE ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00018' AND ChangeTableFieldName = 'StyleID'
UPDATE pChangeTable SET ChangeTableFieldName = 'WorkFlowItemID' WHERE ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00019' AND ChangeTableFieldName = 'StyleID'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04237', GetDate())
GO
