GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'StylePagesWorkflowSchema')
BEGIN
	ALTER TABLE pStyleType ADD StylePagesWorkflowSchema nvarchar(200)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'StylePagesWorkflowItemSchema')
BEGIN
	ALTER TABLE pStyleType ADD StylePagesWorkflowItemSchema nvarchar(200)	
END
GO

UPDATE pStyleType SET StylePagesWorkflowSchema='StylePages_Workflow_Default.xml' WHERE StylePagesWorkflowSchema IS NULL
UPDATE pStyleType SET StylePagesWorkflowItemSchema='StylePages_Workflow_Item_Default.xml' WHERE StylePagesWorkflowItemSchema IS NULL

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08348', GetDate())
GO
