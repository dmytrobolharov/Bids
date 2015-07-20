create table pWorkflowAccessType
(
	WorkflowAccessTypeID						int					not null,
	WorkflowAccessTypeDesc						varchar(100)		null,
	WorkflowAccessTypeOrder						int					null,
	CUser										nvarchar(50)		null,
	CDate										datetime			null,
	MUser										nvarchar(50)		null,
	MDate										datetime			null
constraint PK_pWorkflowAccessType primary key clustered
(
	WorkflowAccessTypeID ASC
)	
)
go


insert into pWorkflowAccessType
		(WorkflowAccessTypeID, WorkflowAccessTypeDesc, WorkflowAccessTypeOrder)
values
		(1, 'Locked', 1)
go


insert into pWorkflowAccessType
		(WorkflowAccessTypeID, WorkflowAccessTypeDesc, WorkflowAccessTypeOrder)
values
		(2, 'Draft', 2)
go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03333', GetDate())
GO