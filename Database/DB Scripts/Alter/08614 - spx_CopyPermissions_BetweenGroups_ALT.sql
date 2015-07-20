/****** Object:  StoredProcedure [dbo].[spx_CopyPermissions_BetweenGroups]    Script Date: 08/07/2014 21:19:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CopyPermissions_BetweenGroups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CopyPermissions_BetweenGroups]
GO

/****** Object:  StoredProcedure [dbo].[spx_CopyPermissions_BetweenGroups]    Script Date: 08/07/2014 21:19:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_CopyPermissions_BetweenGroups] 
 @GroupIdFrom uniqueidentifier,
 @GroupIdTo uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   -- create temp table product type
declare @SourceProductTypes table 
(
	[PermissionProductTypeId] [uniqueidentifier]   NOT NULL,
	[PermissionFolderId] [uniqueidentifier] NULL,
	[PermissionProductTypeMapId] [int] NULL,
	[PermissionProductTypeNotLocked] [int] NULL,
	[GroupId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[PermissionProductTypeName] [nvarchar](256) NULL,
	[PermissionFolderTypeId] [int] NOT NULL
)

declare @NewDestinationProductTypes table
(
	[PermissionProductTypeId] [uniqueidentifier]   NOT NULL,
	[PermissionFolderId] [uniqueidentifier] NULL,
	[PermissionProductTypeMapId] [int] NULL,
	[PermissionProductTypeNotLocked] [int] NULL,
	[GroupId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[PermissionProductTypeName] [nvarchar](256) NULL,
	[PermissionFolderTypeId] [int] NOT NULL
)

declare @ExistingDestinationProductTypes table
(
	[PermissionProductTypeId] [uniqueidentifier]   NOT NULL,
	[PermissionFolderId] [uniqueidentifier] NULL,
	[PermissionProductTypeMapId] [int] NULL,
	[PermissionProductTypeNotLocked] [int] NULL,
	[GroupId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[PermissionProductTypeName] [nvarchar](256) NULL,
	[PermissionFolderTypeId] [int] NOT NULL
)

--create temp workflow
declare @SourceWorkflows table
(
	[PermissionWorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionFolderId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeMapId] [int] NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionRoleId] [int] NOT NULL,
	[PermissionView] [int] NOT NULL,
	[PermissionCreate] [int] NOT NULL,
	[PermissionRemove] [int] NOT NULL,
	[PermissionModify] [int] NOT NULL,
	[PermissionDelete] [int] NOT NULL,
	[PermissionPrint] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,	
	[PermissionWorkflowName] [nvarchar](256) NULL,	
	[ParentWorkflowID] [uniqueidentifier] NULL,
	[PermissionFolderTypeId] [int] NOT NULL
)

declare @NewDestinationWorkflows table
(
	[PermissionWorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionFolderId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeMapId] [int] NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionRoleId] [int] NOT NULL,
	[PermissionView] [int] NOT NULL,
	[PermissionCreate] [int] NOT NULL,
	[PermissionRemove] [int] NOT NULL,
	[PermissionModify] [int] NOT NULL,
	[PermissionDelete] [int] NOT NULL,
	[PermissionPrint] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[PermissionWorkflowName] [nvarchar](256) NULL,
	[ParentWorkflowID] [uniqueidentifier] NULL
)

declare @ExistingDestinationWorkflows table
(
	[PermissionWorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionFolderId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeMapId] [int] NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionRoleId] [int] NOT NULL,
	[PermissionView] [int] NOT NULL,
	[PermissionCreate] [int] NOT NULL,
	[PermissionRemove] [int] NOT NULL,
	[PermissionModify] [int] NOT NULL,
	[PermissionDelete] [int] NOT NULL,
	[PermissionPrint] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[PermissionWorkflowName] [nvarchar](256) NULL,
	[ParentWorkflowID] [uniqueidentifier] NULL
)

--fill product type by groupIdFrom
INSERT INTO @SourceProductTypes 
SELECT p.*,f.PermissionFolderTypeId FROM sPermissionProductType AS p 
INNER JOIN sPermissionFolder AS f ON f.PermissionFolderId = p.PermissionFolderId 
WHERE p.GroupId = @GroupIdFrom

--fill workflow temp
INSERT INTO @SourceWorkflows 
SELECT w.*,f.PermissionFolderTypeId AS PermissionFolderTypeId  FROM sPermissionWorkflow AS w 
INNER JOIN @SourceProductTypes AS p ON p.PermissionProductTypeId = w.PermissionProductTypeId
INNER JOIN sPermissionFolder AS f ON f.PermissionFolderId = w.PermissionFolderId
	

--update product type, set folderId by GroupIdTo 
UPDATE @SourceProductTypes SET PermissionFolderId = f2.PermissionFolderId, GroupId = @GroupIdTo FROM sPermissionFolder AS f1
INNER JOIN @SourceProductTypes AS p ON p.PermissionFolderId = f1.PermissionFolderId
INNER JOIN sPermissionFolder AS f2 ON f1.PermissionFolderTypeId = f2.PermissionFolderTypeId
WHERE f2.GroupId = @GroupIdTo

--update folder permission
UPDATE sPermissionFolder SET PermissionFolderNotLocked = f2.PermissionFolderNotLocked  FROM sPermissionFolder AS f1 
INNER JOIN (SELECT f1.PermissionFolderNotLocked,f2.PermissionFolderId FROM sPermissionFolder AS f1 
INNER JOIN sPermissionFolder AS f2 ON f1.PermissionFolderTypeId = f2.PermissionFolderTypeId 
WHERE f1.GroupId = @GroupIdFrom and f2.GroupId = @GroupIdTo) AS f2 ON f1.PermissionFolderId = f2.PermissionFolderId

IF EXISTS (SELECT * FROM sPermissionProductType AS p WHERE p.GroupId = @GroupIdTo) 
	BEGIN
	--PRODUCTTYPES FOR INSERT
		INSERT INTO @NewDestinationProductTypes 
		SELECT NEWID() as PermissionProductTypeId,
		p1.PermissionFolderId,
		p1.PermissionProductTypeMapId,
		p1.PermissionProductTypeNotLocked, 
		@GroupIdTo as GroupId,
		p1.CUser,
		p1.CDate,  
		p1.MUser,
		p1.MDate,
		p1.Active,
		p1.PermissionProductTypeName,
		p1.PermissionFolderTypeId as PermissionFolderTypeId 
		from @SourceProductTypes as p1 
		LEFT OUTER JOIN 
		 (SELECT p.*,f.PermissionFolderTypeId FROM sPermissionProductType AS p
			INNER JOIN sPermissionFolder AS f ON f.PermissionFolderId = p.PermissionFolderId
			WHERE p.GroupId = @GroupIdTo) AS p2 ON p1.PermissionProductTypeMapId = p2.PermissionProductTypeMapId AND p1.PermissionFolderTypeId = p2.PermissionFolderTypeId 
		  WHERE p2.PermissionProductTypeId IS NULL

		IF EXISTS(SELECT * FROM @NewDestinationProductTypes)
			BEGIN			
			INSERT INTO sPermissionProductType  
				SELECT p.PermissionProductTypeId,
				p.PermissionFolderId,
				p.PermissionProductTypeMapId,
				p.PermissionProductTypeNotLocked,
				p.GroupId, 
				p.CUser,
				p.CDate,  
				p.MUser,
				p.MDate,
				p.Active,
				p.PermissionProductTypeName 
				FROM @NewDestinationProductTypes AS p
			END
			
--product type for update
		INSERT INTO @ExistingDestinationProductTypes 
			SELECT p2.PermissionProductTypeId,
			p1.PermissionFolderId,
			p1.PermissionProductTypeMapId,
			p1.PermissionProductTypeNotLocked,
			p1.GroupId AS GroupId, 
			p1.CUser,
			p1.CDate, 
			p1.MUser, 
			p1.MDate,
			p1.Active,
			p1.PermissionProductTypeName,
			p1.PermissionFolderTypeId  
			FROM @SourceProductTypes AS p1 
			INNER JOIN sPermissionProductType AS p2 ON p1.PermissionProductTypeMapId = p2.PermissionProductTypeMapId
			INNER JOIN sPermissionFolder AS f ON f.PermissionFolderId = p2.PermissionFolderId	
			WHERE p2.GroupId = @GroupIdTo AND f.PermissionFolderTypeId = p1.PermissionFolderTypeId
		  
		  
		IF EXISTS(SELECT * FROM @ExistingDestinationProductTypes)
			BEGIN			
				UPDATE sPermissionProductType SET Active = pu.Active, 
				CDate = pu.CDate, 
				CUser = pu.CUser, 
				GroupId = pu.GroupId, 
				MDate = pu.MDate, 
				MUser = pu.MUser, 
				PermissionFolderId = pu.PermissionFolderId, 
				PermissionProductTypeMapId = pu.PermissionProductTypeMapId, 
				PermissionProductTypeName = pu.PermissionProductTypeName, 
				PermissionProductTypeNotLocked = pu.PermissionProductTypeNotLocked 
				FROM sPermissionProductType AS p INNER JOIN @ExistingDestinationProductTypes AS pu ON p.PermissionProductTypeId = pu.PermissionProductTypeId
			END
			
		--upate or insert workflow
		INSERT INTO @NewDestinationWorkflows 
		SELECT NEWID() AS PermissionWorkflowId,
			np.PermissionFolderId,
			np.PermissionProductTypeId,
			w.PermissionProductTypeMapId,
			@GroupIdTo AS GroupId,
			w.WorkflowId,
			w.PermissionRoleId,
			w.PermissionView,
			w.PermissionCreate,
			w.PermissionRemove,
			w.PermissionModify,
			w.PermissionDelete,
			w.PermissionPrint, 
			w.CUser,
			w.CDate,
			w.MUser,
			w.MDate, 
			w.PermissionWorkflowName,
			W.ParentWorkflowID  
			FROM @SourceWorkflows AS w 
			INNER JOIN @NewDestinationProductTypes AS np ON np.PermissionProductTypeMapId = w.PermissionProductTypeMapId 
			AND w.PermissionFolderTypeId = np.PermissionFolderTypeId 
	
	
	INSERT INTO @ExistingDestinationWorkflows 
	SELECT w2.PermissionWorkflowId,
		w2.PermissionFolderId,
		w2.PermissionProductTypeId,
		w2.PermissionProductTypeMapId,
		@GroupIdTo AS GroupId,
		w1.WorkflowId,
		w1.PermissionRoleId,
		w1.PermissionView,
		w1.PermissionCreate,
		w1.PermissionRemove,
		w1.PermissionModify,
		w1.PermissionDelete,
		w1.PermissionPrint, 
		w1.CUser,
		w1.CDate,
		w1.MUser,
		w1.MDate, 
		w1.PermissionWorkflowName,
		W1.ParentWorkflowID  
		FROM @SourceWorkflows AS w1 
		INNER JOIN sPermissionWorkflow AS w2 ON w2.PermissionProductTypeMapId = w1.PermissionProductTypeMapId 
		AND w2.WorkflowId = w1.WorkflowId
		INNER JOIN @ExistingDestinationProductTypes AS p ON p.PermissionProductTypeId = w2.PermissionProductTypeId	
		
		IF EXISTS(SELECT * FROM @NewDestinationWorkflows)
			BEGIN
				INSERT INTO sPermissionWorkflow SELECT w.* FROM @NewDestinationWorkflows as w
			END
		
		IF EXISTS(SELECT * FROM @ExistingDestinationWorkflows)
			BEGIN
			UPDATE sPermissionWorkflow SET CDate = wu.CDate, 
			CUser = wu.CUser, 
			GroupId = wu.GroupId, 
			MDate = wu.MDate,
			MUser = wu.MUser, 
			PermissionCreate = wu.PermissionCreate, 
			PermissionDelete = wu.PermissionDelete, 
			PermissionFolderId = wu.PermissionFolderId, 
			PermissionModify = wu.PermissionModify, 
			PermissionPrint = wu.PermissionPrint, 
			PermissionProductTypeId = wu.PermissionProductTypeId, 
			PermissionProductTypeMapId = wu.PermissionProductTypeMapId, 
			PermissionRemove = wu.PermissionRemove, 
			PermissionRoleId = wu.PermissionRoleId, 
			PermissionView = wu.PermissionView, 
			PermissionWorkflowId = wu.PermissionWorkflowId, 
			PermissionWorkflowName = wu.PermissionWorkflowName, 
			WorkflowId = wu.WorkflowId 
			FROM sPermissionWorkflow AS w1 INNER JOIN @ExistingDestinationWorkflows AS wu ON wu.PermissionWorkflowId = w1.PermissionWorkflowId
			END
			
	END
ELSE
	BEGIN
		INSERT INTO @NewDestinationProductTypes  
		SELECT NEWID() AS PermissionProductTypeId, 
			p1.PermissionFolderId,
			p1.PermissionProductTypeMapId,
			p1.PermissionProductTypeNotLocked, 
			@GroupIdTo AS GroupId,
			p1.CUser,
			p1.CDate,  
			p1.MUser,
			p1.MDate,
			p1.Active,
			p1.PermissionProductTypeName,
			p1.PermissionFolderTypeId AS PermissionFolderTypeId 
			FROM @SourceProductTypes AS p1
	
	
	INSERT INTO @NewDestinationWorkflows 
	SELECT NEWID() AS PermissionWorkflowId,
		np.PermissionFolderId,
		np.PermissionProductTypeId,
		w.PermissionProductTypeMapId,
		@GroupIdTo AS GroupId,
		w.WorkflowId,
		w.PermissionRoleId,
		w.PermissionView,
		w.PermissionCreate,
		w.PermissionRemove,
		w.PermissionModify,
		w.PermissionDelete,
		w.PermissionPrint, 
		w.CUser,
		w.CDate,
		w.MUser,
		w.MDate, 
		w.PermissionWorkflowName,
		W.ParentWorkflowID  
		FROM @SourceWorkflows AS w 
		INNER JOIN @NewDestinationProductTypes AS np ON np.PermissionProductTypeMapId = w.PermissionProductTypeMapId 
		AND w.PermissionFolderTypeId = np.PermissionFolderTypeId 	
	
	   INSERT INTO sPermissionProductType  
		   SELECT p.PermissionProductTypeId,
		   p.PermissionFolderId,
		   p.PermissionProductTypeMapId,
		   p.PermissionProductTypeNotLocked,
		   p.GroupId, 
		   p.CUser,
		   p.CDate,  
		   p.MUser,
		   p.MDate,
		   p.Active,
		   p.PermissionProductTypeName 
		   FROM @NewDestinationProductTypes AS p
	   
		INSERT INTO sPermissionWorkflow SELECT w.* FROM @NewDestinationWorkflows AS w   
	END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08614', GetDate())
GO
