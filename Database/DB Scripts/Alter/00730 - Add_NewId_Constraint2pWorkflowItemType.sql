IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pWorkflowItemType' 
                                                         AND COLUMN_NAME = N'WorkFlowItemtypeID' 
                                                         AND COLUMN_DEFAULT LIKE N'%NewID()%' )
       BEGIN 
            ALTER TABLE pWorkflowItemType ADD CONSTRAINT
	                DF_pWflowItemType_WorkFlowItemID DEFAULT NewId() FOR WorkFlowItemtypeID
       END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '730', GetDate())
GO
