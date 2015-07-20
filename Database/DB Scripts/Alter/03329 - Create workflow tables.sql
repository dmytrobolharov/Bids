--select * from pWorkflowTemplateItem
alter table pWorkflowTemplateItem
  add WorkflowTemplateItemStatusItemID			uniqueidentifier	null,
	  DueDate									datetime			null,
	  StartDate									datetime			null,
	  WorkflowAccessTypeID						int					null,
	  WorkflowEscalateTo						int					null
go  


create table pWorkflowTemplateItemDep
(
	WorkflowTemplateItemDepID					uniqueidentifier	not null,
	WorkflowTemplateID							uniqueidentifier	null,
	DependentWorkflowTemplateItemID				uniqueidentifier	null,
	DependentOnWorkflowTemplateItemID			uniqueidentifier	null,
	WorkflowRuleID								int					null,
	WorkflowStatusID							int					null,
	CUser										nvarchar(50)		null,
	CDate										datetime			null,
	MUser										nvarchar(50)		null,
	MDate										datetime			null
constraint PK_pWorkflowTemplateItemDep primary key clustered
(
	WorkflowTemplateItemDepID ASC
)	
)
go


create table pWorkflowRule
(
	WorkflowRuleID								int					not null,
	WorkflowRuleDesc							varchar(100)		null,
	CUser										nvarchar(50)		null,
	CDate										datetime			null,
	MUser										nvarchar(50)		null,
	MDate										datetime			null
constraint PK_pWorkflowRule primary key clustered
(
	WorkflowRuleID ASC
)	
)
go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03329', GetDate())
GO