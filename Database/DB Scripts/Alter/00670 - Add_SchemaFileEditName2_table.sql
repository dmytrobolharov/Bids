IF NOT EXISTS (select * from information_schema.tables where TABLE_NAME = N'pWorkFlowItemType')
       BEGIN 
              CREATE TABLE pWorkflowItemType(
	                                     [WorkflowItemTypeId] [uniqueidentifier] NOT NULL,
	                                     [MapId] [uniqueidentifier] NOT NULL,
	                                     [SchemaFileName] [nvarchar](200) NULL,
	                                     [ItemTypeLabel] [nvarchar](200) NULL,
                                          CONSTRAINT [PK_WorkflowItemTypeId] PRIMARY KEY CLUSTERED 
                                          (
	                                        [WorkflowItemTypeId] ASC )
	                                      WITH (PAD_INDEX  = OFF
	                                            , STATISTICS_NORECOMPUTE  = OFF
	                                            , IGNORE_DUP_KEY = OFF
	                                            , ALLOW_ROW_LOCKS  = ON
	                                            , ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]) ON [PRIMARY]


       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pWorkflowItemType' and COLUMN_NAME = N'SchemaFileEditName')
       BEGIN 
            ALTER TABLE pWorkflowItemType ADD SchemaFileEditName NVARCHAR(200) NULL
       END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '670', GetDate())
GO