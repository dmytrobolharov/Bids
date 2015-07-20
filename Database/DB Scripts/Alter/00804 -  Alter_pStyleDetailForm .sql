IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleDetailForm' and COLUMN_NAME = N'StyleDetailFormGroupID')
       BEGIN
            EXEC sp_rename 'pStyleDetailForm.StyleDetailFormGroupID', 'WorkFlowItemId', 'COLUMN';
       END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '804', GetDate())
GO