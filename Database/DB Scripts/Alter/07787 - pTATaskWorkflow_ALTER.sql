
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pTATaskWorkflow
	DROP CONSTRAINT DF_pTATaskWorkflow_TATaskWorkflowId
GO
CREATE TABLE dbo.Tmp_pTATaskWorkflow
	(
	TATaskWorkflowId uniqueidentifier NOT NULL ROWGUIDCOL,
	TACalReferenceTypeId uniqueidentifier NULL,
	WorkflowId uniqueidentifier NULL,
	WorkflowName nvarchar(200) NULL,
	WorkflowFolder nvarchar(200) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_pTATaskWorkflow SET (LOCK_ESCALATION = TABLE)
GO
ALTER TABLE dbo.Tmp_pTATaskWorkflow ADD CONSTRAINT
	DF_pTATaskWorkflow_TATaskWorkflowId DEFAULT (newsequentialid()) FOR TATaskWorkflowId
GO
IF EXISTS(SELECT * FROM dbo.pTATaskWorkflow)
	 EXEC('INSERT INTO dbo.Tmp_pTATaskWorkflow (TATaskWorkflowId, WorkflowId, WorkflowName, WorkflowFolder)
		SELECT TATaskWorkflowId, WorkflowId, WorkflowName, WorkflowFolder FROM dbo.pTATaskWorkflow WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.pTACalTemplateTask
	DROP CONSTRAINT FK_pTACalTemplateTask_pTATaskWorkflow
GO
DROP TABLE dbo.pTATaskWorkflow
GO
EXECUTE sp_rename N'dbo.Tmp_pTATaskWorkflow', N'pTATaskWorkflow', 'OBJECT' 
GO
ALTER TABLE dbo.pTATaskWorkflow ADD CONSTRAINT
	PK_pTATaskWorkflow PRIMARY KEY CLUSTERED 
	(
	TATaskWorkflowId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pTACalTemplateTask ADD CONSTRAINT
	FK_pTACalTemplateTask_pTATaskWorkflow FOREIGN KEY
	(
	TaskWorkflowId
	) REFERENCES dbo.pTATaskWorkflow
	(
	TATaskWorkflowId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.pTACalTemplateTask SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07787', GetDate())
GO
