
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePageType]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueuePageType]
GO


CREATE TABLE [dbo].[pBatchQueuePageType]
(
[BatchQueuePageTypeID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__3426BFC1] DEFAULT (newsequentialid()),
[BatchQueuePageTypeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageTypeDesc] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePagePkID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageXmlSearch] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageXmlForm] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageXmlGrid] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageXmlSelected] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageUrl] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageRecType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageRecMax] [int] NULL,
[BatchQueuePageSPX] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueExecuteSPX] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[BatchQueueLogicInsertSPX] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuepageXMLGridAlternating] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueGridAlternatingName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueGridXMLThumbnail] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueuePageXmlColorGrid] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO

ALTER TABLE [dbo].[pBatchQueuePageType] ADD CONSTRAINT [PK_pBatchQueuePageType] PRIMARY KEY CLUSTERED ([BatchQueuePageTypeID])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePage]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueuePage]
GO


CREATE TABLE [dbo].[pBatchQueuePage]
(
[BatchQueuePageID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__314A5316] DEFAULT (newsequentialid()),
[BatchQueuePageTypeID] [uniqueidentifier] NOT NULL,
[BatchQueueID] [uniqueidentifier] NOT NULL,
[BatchQueuePageOrder] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
ALTER TABLE [dbo].[pBatchQueuePage] ADD CONSTRAINT [PK_pBatchQueuePage] PRIMARY KEY CLUSTERED ([BatchQueuePageID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobStatus]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueJobStatus]
GO

CREATE TABLE [dbo].[pBatchQueueJobStatus]
(
[BatchQueueJobStatusID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__698EAC39] DEFAULT (newid()),
[STATUS] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueJobStatus] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueJobStatusIcon] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
ALTER TABLE [dbo].[pBatchQueueJobStatus] ADD CONSTRAINT [PK_pBatchQueueJobStatus] PRIMARY KEY CLUSTERED ([BatchQueueJobStatusID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueue]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueue]
GO

CREATE TABLE [dbo].[pBatchQueue]
(
[BatchQueueID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__63D5D2E3] DEFAULT (newsequentialid()),
[BatchQueueTypeID] [uniqueidentifier] NULL,
[BatchQueueName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueDesc] [varchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueUrl] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueIcon] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[BatchQueuePageHistoryUrl] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO


ALTER TABLE [dbo].[pBatchQueue] ADD CONSTRAINT [PK_pBatchQueue] PRIMARY KEY CLUSTERED ([BatchQueueID])
GO




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItem]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueJobItem]
GO

CREATE TABLE [dbo].[pBatchQueueJobItem]
(
[BatchQueueJobItemID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__25D8A06A] DEFAULT (newsequentialid()),
[BatchQueueJobID] [uniqueidentifier] NULL,
[BatchQueuePageID] [uniqueidentifier] NULL,
[BatchQueueJobStatusID] [int] NULL CONSTRAINT [DF__pBatchQue__Batch__26CCC4A3] DEFAULT ((0)),
[BatchQueueJobCount] [int] NULL,
[BatchQueueJobSeq] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueJobTable] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueJobItem] ADD CONSTRAINT [PK__pBatchQu__81E1BEFF2B3C7405] PRIMARY KEY CLUSTERED ([BatchQueueJobItemID])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJob]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueJob]
GO

CREATE TABLE [dbo].[pBatchQueueJob]
(
[BatchQueueJobID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__2C859DF9] DEFAULT (newsequentialid()),
[BatchQueueID] [uniqueidentifier] NULL,
[BatchQueueJobDate] [datetime] NULL,
[BatchQueueJobTeamID] [uniqueidentifier] NULL,
[BatchQueueJobStatusID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__pBatchQue__Batch__2D79C232] DEFAULT ('00000000-0000-0000-0000-000000000000'),
[BatchQueueJobCompleted] [int] NULL CONSTRAINT [DF__pBatchQue__Batch__2E6DE66B] DEFAULT ((0)),
[Description] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueJob] ADD CONSTRAINT [PK_pBatchQueueJob] PRIMARY KEY CLUSTERED ([BatchQueueJobID])
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialSizeTmp]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueStyleMaterialSizeTmp]
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialSizeTmp]
(
[StyleMaterialSizeID] [uniqueidentifier] NOT NULL,
[BatchQueueJobID] [uniqueidentifier] NULL,
[MaterialSizeOldID] [uniqueidentifier] NULL,
[MaterialSizeNewID] [uniqueidentifier] NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueStyleMaterialSizeTmp] ADD CONSTRAINT [PK_pBatchQueueStyleMaterialSizeTmp] PRIMARY KEY CLUSTERED ([StyleMaterialSizeID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialTmp]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueStyleMaterialTmp]
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialTmp]
(
[StyleMaterialID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Style__22FC33BF] DEFAULT (newid()),
[BatchQueueJobID] [uniqueidentifier] NULL,
[StyleID] [uniqueidentifier] NULL,
[MaterialID] [uniqueidentifier] NULL,
[BBUsage] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Qty] [decimal] (18, 2) NULL,
[MaterialSizeID] [uniqueidentifier] NULL,
[Artwork] [int] NULL,
[Colorway] [int] NULL,
[Placement] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueStyleMaterialTmp] ADD CONSTRAINT [PK_pBatchQueueStyleMaterialTmp] PRIMARY KEY CLUSTERED ([StyleMaterialID])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialColorTmp]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueStyleMaterialColorTmp]
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialColorTmp]
(
[StyleMaterialColorID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Style__29A9314E] DEFAULT (newid()),
[BatchQueueJobID] [uniqueidentifier] NULL,
[ColorCode] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ColorName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MaterialColorID] [uniqueidentifier] NULL,
[StyleMaterialID] [uniqueidentifier] NULL,
[ColorPaletteID] [uniqueidentifier] NULL,
[Reviewed] [int] NULL,
[StyleColorItemID] [uniqueidentifier] NULL,
[StyleID] [uniqueidentifier] NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueStyleMaterialColorTmp] ADD CONSTRAINT [PK_pBatchQueueStyleMaterialColorTmp] PRIMARY KEY CLUSTERED ([StyleMaterialColorID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueType]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueType]
GO


CREATE TABLE [dbo].[pBatchQueueType]
(
[BatchQueueTypeID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__4CF26D8B] DEFAULT (newsequentialid()),
[BatchQueueTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueTypeDesc] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueTypeURL] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueTypeIcon] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL CONSTRAINT [DF__pBatchQue__Activ__4DE691C4] DEFAULT ((1))
)

GO


ALTER TABLE [dbo].[pBatchQueueType] ADD CONSTRAINT [PK_pBatchQueueType] PRIMARY KEY CLUSTERED ([BatchQueueTypeID])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePageDep]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueuePageDep]
GO


CREATE TABLE [dbo].[pBatchQueuePageDep]
(
[BatchQueuePageDepID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__37032C6C] DEFAULT (newsequentialid()),
[BatchQueuePageID] [uniqueidentifier] NULL,
[BatchQueuePageRelationID] [uniqueidentifier] NULL
)

GO


ALTER TABLE [dbo].[pBatchQueuePageDep] ADD CONSTRAINT [PK_pBatchQueuePageDep] PRIMARY KEY CLUSTERED ([BatchQueuePageDepID])
go 


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialCoreItemTmp]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueStyleMaterialCoreItemTmp]
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialCoreItemTmp]
(
[BatchQueueStyleMaterialCoreItemTmpID] [uniqueidentifier] NOT NULL,
[BatchQueueJobID] [uniqueidentifier] NULL,
[StyleID] [uniqueidentifier] NULL,
[MaterialCoreItemID] [uniqueidentifier] NULL
)

GO
ALTER TABLE [dbo].[pBatchQueueStyleMaterialCoreItemTmp] ADD CONSTRAINT [PK_pBatchQueueStyleMaterialCoreItemTmp] PRIMARY KEY CLUSTERED ([BatchQueueStyleMaterialCoreItemTmpID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialCoreColorTmp]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueStyleMaterialCoreColorTmp]
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialCoreColorTmp]
(
[StyleMaterialCoreColorID] [uniqueidentifier] NOT NULL,
[BatchQueueJobID] [uniqueidentifier] NULL,
[ColorCode] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ColorName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MaterialCoreColorID] [uniqueidentifier] NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueStyleMaterialCoreColorTmp] ADD CONSTRAINT [PK_pBatchQueueStyleMaterialCoreColorTmp] PRIMARY KEY CLUSTERED ([StyleMaterialCoreColorID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueForm]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueForm]
GO

CREATE TABLE [dbo].[pBatchQueueForm]
(
[BatchQueueFormID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__66B23F8E] DEFAULT (newsequentialid()),
[BatchQueuePageID] [uniqueidentifier] NULL,
[BatchQueueFormName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueFormSeq] [int] NULL,
[BatchQueueFormPkName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueFormSql] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueFormSPX] [varchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BatchQueueFormXml] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO

ALTER TABLE [dbo].[pBatchQueueForm] ADD CONSTRAINT [PK_pBatchQueueForm] PRIMARY KEY CLUSTERED ([BatchQueueFormID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleWorkflow]') AND type in (N'U'))
	DROP TABLE [dbo].[pBatchQueueStyleWorkflow]
GO


CREATE TABLE [dbo].[pBatchQueueStyleWorkflow]
(
[BatchQueueStyleWorkflowID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__pBatchQue__Batch__7090AF83] DEFAULT (newsequentialid()),
[BatchQueueID] [uniqueidentifier] NULL,
[WorkflowID] [uniqueidentifier] NULL,
[Workflow] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO


ALTER TABLE [dbo].[pBatchQueueStyleWorkflow] ADD CONSTRAINT [PK__pBatchQu__AA6185FE7278F7F5] PRIMARY KEY CLUSTERED ([BatchQueueStyleWorkflowID])
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] ADD
CONSTRAINT [FK__pBatchQue__Batch__2D24BC77] FOREIGN KEY ([BatchQueueJobID]) REFERENCES [dbo].[pBatchQueueJob] ([BatchQueueJobID]) ON DELETE CASCADE
GO




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBatchQFolderItems]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessBatchQFolderItems]
GO

CREATE TABLE [dbo].[sAccessBatchQFolderItems]
(
[AccessBatchQFolderItemID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__sAccessBa__Acces__5A4C68A9] DEFAULT (newid()),
[AccessBatchQId] [uniqueidentifier] NOT NULL,
[BatchQTypeId] [uniqueidentifier] NOT NULL,
[AccessRoleId] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__5B408CE2] DEFAULT ((0)),
[AccessView] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__5C34B11B] DEFAULT ((0)),
[AccessCreate] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__5D28D554] DEFAULT ((0)),
[AccessModify] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__5E1CF98D] DEFAULT ((0)),
[AccessRemove] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__5F111DC6] DEFAULT ((0)),
[AccessDelete] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__600541FF] DEFAULT ((0)),
[AccessPrint] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__60F96638] DEFAULT ((0)),
[BatchQueueID] [uniqueidentifier] NOT NULL,
[TeamId] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[GroupID] [uniqueidentifier] NOT NULL
)

GO

ALTER TABLE [dbo].[sAccessBatchQFolderItems] ADD CONSTRAINT [PK_sAccessBatchQFolderItems] PRIMARY KEY CLUSTERED ([AccessBatchQFolderItemID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBatchQFolder]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessBatchQFolder]
GO

CREATE TABLE [dbo].[sAccessBatchQFolder]
(
[AccessBatchQId] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__sAccessBa__Acces__39DF9917] DEFAULT (newid()),
[BatchQTypeId] [uniqueidentifier] NOT NULL,
[BatchQTypeDesc] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessRoleId] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__3AD3BD50] DEFAULT ((0)),
[AccessView] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__3BC7E189] DEFAULT ((0)),
[AccessCreate] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__3CBC05C2] DEFAULT ((0)),
[AccessRemove] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__3DB029FB] DEFAULT ((0)),
[AccessModify] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__3EA44E34] DEFAULT ((0)),
[AccessDelete] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__3F98726D] DEFAULT ((0)),
[AccessPrint] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__408C96A6] DEFAULT ((0)),
[GroupID] [uniqueidentifier] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[TeamID] [uniqueidentifier] NOT NULL
)

GO


ALTER TABLE [dbo].[sAccessBatchQFolder] ADD CONSTRAINT [PK_sAccessBatchQFolder] PRIMARY KEY CLUSTERED ([AccessBatchQId])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupBatchQueueFolder]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessGroupBatchQueueFolder]
GO

CREATE TABLE [dbo].[sAccessGroupBatchQueueFolder]
(
[AccessBatchQueueId] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__sAccessGr__Acces__43690351] DEFAULT (newid()),
[BatchQueueTypeID] [uniqueidentifier] NOT NULL,
[AccessRoleId] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__445D278A] DEFAULT ((0)),
[AccessView] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__45514BC3] DEFAULT ((0)),
[AccessCreate] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__46456FFC] DEFAULT ((0)),
[AccessModify] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__47399435] DEFAULT ((0)),
[AccessDelete] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__482DB86E] DEFAULT ((0)),
[AccessPrint] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__4921DCA7] DEFAULT ((0)),
[GroupID] [uniqueidentifier] NOT NULL,
[TeamID] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[AccessRemove] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__4A1600E0] DEFAULT ((0))
)

GO


ALTER TABLE [dbo].[sAccessGroupBatchQueueFolder] ADD CONSTRAINT [PK_sAccessGroupBatchQueueFolder] PRIMARY KEY CLUSTERED ([AccessBatchQueueId])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBatchQItems]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessBatchQItems]
GO


CREATE TABLE [dbo].[sAccessBatchQItems]
(
[AccessBatchQItemID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__sAccessBa__Acces__50C2FE6F] DEFAULT (newid()),
[AccessBatchQId] [uniqueidentifier] NOT NULL,
[BatchQTypeId] [uniqueidentifier] NOT NULL,
[AccessRoleId] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__51B722A8] DEFAULT ((0)),
[AccessView] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__52AB46E1] DEFAULT ((0)),
[AccessCreate] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__539F6B1A] DEFAULT ((0)),
[AccessRemove] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__54938F53] DEFAULT ((0)),
[AccessModify] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__5587B38C] DEFAULT ((0)),
[AccessDelete] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__567BD7C5] DEFAULT ((0)),
[AccessPrint] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__576FFBFE] DEFAULT ((0)),
[GroupID] [uniqueidentifier] NOT NULL,
[BatchQueueID] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)

GO


ALTER TABLE [dbo].[sAccessBatchQItems] ADD CONSTRAINT [PK_sAccessBatchQItems] PRIMARY KEY CLUSTERED ([AccessBatchQItemID])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupBatchQueue]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessGroupBatchQueue]
GO

CREATE TABLE [dbo].[sAccessGroupBatchQueue]
(
[AccessBatchQueueId] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__sAccessGr__Acces__75F22119] DEFAULT (newid()),
[BatchQueueTypeID] [uniqueidentifier] NOT NULL,
[AccessRoleId] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__76E64552] DEFAULT ((0)),
[AccessView] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__77DA698B] DEFAULT ((0)),
[AccessCreate] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__78CE8DC4] DEFAULT ((0)),
[AccessModify] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__79C2B1FD] DEFAULT ((0)),
[AccessDelete] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__7AB6D636] DEFAULT ((0)),
[AccessPrint] [int] NOT NULL CONSTRAINT [DF__sAccessGr__Acces__7BAAFA6F] DEFAULT ((0)),
[GroupID] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)

GO


ALTER TABLE [dbo].[sAccessGroupBatchQueue] ADD CONSTRAINT [PK_sAccessGroupBatchQueue] PRIMARY KEY CLUSTERED ([AccessBatchQueueId])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessBatchQueue]') AND type in (N'U'))
	DROP TABLE [dbo].[sAccessBatchQueue]
GO

CREATE TABLE [dbo].[sAccessBatchQueue]
(
[AccessBatchQueueId] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF__sAccessBa__Acces__61EB286C] DEFAULT (newid()),
[BatchQueueTypeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__sAccessBa__Batch__62DF4CA5] DEFAULT (newid()),
[AccessRoleId] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__63D370DE] DEFAULT ((0)),
[AccessView] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__64C79517] DEFAULT ((0)),
[AccessCreate] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__65BBB950] DEFAULT ((0)),
[AccessModify] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__66AFDD89] DEFAULT ((0)),
[AccessDelete] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__67A401C2] DEFAULT ((0)),
[AccessPrint] [int] NOT NULL CONSTRAINT [DF__sAccessBa__Acces__689825FB] DEFAULT ((0)),
[TeamId] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)

GO


ALTER TABLE [dbo].[sAccessBatchQueue] ADD CONSTRAINT [PK_sAccessBatchQueue] PRIMARY KEY CLUSTERED ([AccessBatchQueueId])
GO


DELETE FROM pBatchQueueJobStatus

-- Add 4 rows to [dbo].[pBatchQueueJobStatus]
INSERT INTO [dbo].[pBatchQueueJobStatus] ([BatchQueueJobStatusID], [STATUS], [BatchQueueJobStatus], [BatchQueueJobStatusIcon]) VALUES ('00000000-0000-0000-0000-000000000000', N'Defining task', N'Jobs Pending', N'icon_ball_yellow.gif')
INSERT INTO [dbo].[pBatchQueueJobStatus] ([BatchQueueJobStatusID], [STATUS], [BatchQueueJobStatus], [BatchQueueJobStatusIcon]) VALUES ('10000000-0000-0000-0000-000000000000', N'In process', N'Jobs in Progress', N'icon_aball_blue.gif')
INSERT INTO [dbo].[pBatchQueueJobStatus] ([BatchQueueJobStatusID], [STATUS], [BatchQueueJobStatus], [BatchQueueJobStatusIcon]) VALUES ('20000000-0000-0000-0000-000000000000', N'Task completed', N'Jobs Completed', N'icon_ball_green.gif')
INSERT INTO [dbo].[pBatchQueueJobStatus] ([BatchQueueJobStatusID], [STATUS], [BatchQueueJobStatus], [BatchQueueJobStatusIcon]) VALUES ('30000000-0000-0000-0000-000000000000', N'Error found, task not completed', N'Jobs with error', N'icon_ball_red.gif')


DELETE FROM pBatchQueuePageType
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('99a5e4e3-dd70-e011-9039-8ef3dccb61b6', N'Find Season & Year', N'Select season and year', 'SeasonYearID', 'SeasonYear_Search.xml', NULL, 'BatchQ_SeasonYear_Default.xml', 'BatchQ_SeasonYear_Default.xml', 'BatchQ_Grid.aspx', 'S', 1, 'spx_BatchQGrid_SeasonYear_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('d0c913c0-7d8c-e011-81e9-005056c00008', N'Select a single material', N'Please select a single material', 'MaterialID', 'BatchQ_Material_SingleSeasonal_Search.xml', NULL, 'BatchQ_Material_SingleSeasonal_Default.xml', 'BatchQ_Material_SingleSeasonal_Selected.xml', 'BatchQ_Grid.aspx', 'S', 1, 'spx_BatchQGrid_SELECT', NULL, NULL, NULL, NULL, NULL, N'spx_BatchQJob_AddStyleMaterial_Logic_INSERT', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('44e5e4e3-dd70-e011-9039-8ef3dccb61b3', N'Select multiple styles', N'Please select multiple styles with one season', 'StyleID', 'BatchQ_StyleOneSeasonal_Search.xml', NULL, 'BatchQ_StyleOneSeasonal_Default.xml', 'BatchQ_StyleOneSeasonal_Selected.xml', 'BatchQ_Grid.aspx', 'M', 50, 'spx_BatchQGrid_MaterialAdd_Style_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, N'BatchQ_StyleOneSeasonal_Image_Default.xml', N'Thumbnail', N'BatchQ_StyleOneSeasonal_Thumbnail.xml', NULL)
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('e1c913c0-7d8c-e011-81e9-005056c00008', N'Batch Queue StyleMaterials', N'Batch Queue StyleMaterials', 'StyleMaterialID', NULL, 'BatchQ_Material_Default.xml', 'BatchQ_StyleMaterial_Default.xml', NULL, 'BatchQ_AddMaterial_Review.aspx', 'M', 0, 'spx_BatchQGrid_StyleMaterials_Review_SELECT', N'spx_BatchQJob_AddStyleMaterial_EXECUTE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'BatchQ_StyleMaterial_Color.xml')
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('d2c913c0-7d8c-e011-81e9-005056c00008', N'Select Usage', N'Please select a single usage', 'CustomID', 'BatchQ_Material_Usage_Search.xml', NULL, 'BatchQ_Material_Usage_Default.xml', 'BatchQ_Material_Usage_Selected.xml', 'BatchQ_Grid.aspx', 'S', 1, 'spx_BatchQGrid_Usage_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)


DELETE FROM pBatchQueueStyleWorkflow
INSERT INTO [dbo].[pBatchQueueStyleWorkflow] ([BatchQueueStyleWorkflowID], [BatchQueueID], [WorkflowID], [Workflow]) VALUES ('9306758b-9ea1-e011-a99a-005056c00008', '90000000-0000-0000-0000-000000000014', '40000000-0000-0000-0000-000000000006', N'Design Detail')
INSERT INTO [dbo].[pBatchQueueStyleWorkflow] ([BatchQueueStyleWorkflowID], [BatchQueueID], [WorkflowID], [Workflow]) VALUES ('353c78a4-9ea1-e011-a99a-005056c00008', '90000000-0000-0000-0000-000000000014', '40000000-0000-0000-0000-000000000005', N'Development Spec')
INSERT INTO [dbo].[pBatchQueueStyleWorkflow] ([BatchQueueStyleWorkflowID], [BatchQueueID], [WorkflowID], [Workflow]) VALUES ('12e64cc9-9ea1-e011-a99a-005056c00008', '90000000-0000-0000-0000-000000000014', '40000000-0000-0000-0000-000000000000', N'Design Image')

DELETE FROM pBatchQueueType
INSERT INTO [dbo].[pBatchQueueType] ([BatchQueueTypeID], [BatchQueueTypeName], [BatchQueueTypeDesc], [BatchQueueTypeURL], [BatchQueueTypeIcon], [CUser], [CDate], [MUser], [MDate], [Active]) VALUES ('f459c2f2-657a-e011-9847-005056c00008', N'Material Folder', NULL, NULL, 'icon_folder_table.gif', NULL, NULL, NULL, NULL, 1)
INSERT INTO [dbo].[pBatchQueueType] ([BatchQueueTypeID], [BatchQueueTypeName], [BatchQueueTypeDesc], [BatchQueueTypeURL], [BatchQueueTypeIcon], [CUser], [CDate], [MUser], [MDate], [Active]) VALUES ('f459c2f2-657a-e011-9848-005056c00008', N'Style Folder', NULL, NULL, 'icon_folder_table.gif', NULL, NULL, NULL, NULL, 1)


DELETE from pBatchQueue
INSERT INTO [dbo].[pBatchQueue] ([BatchQueueID], [BatchQueueTypeID], [BatchQueueName], [BatchQueueDesc], [BatchQueueUrl], [BatchQueueIcon], [CUser], [CDate], [MUser], [MDate], [BatchQueuePageHistoryUrl]) VALUES ('90000000-0000-0000-0000-000000000003', 'f459c2f2-657a-e011-9848-005056c00008', N'Mass Add Materials to Style', 'Batch Queue Mass Add Materials to Styles', 'BatchQ_Page.aspx', 'icon_tables_stacks.gif', NULL, NULL, NULL, NULL, N'BatchQ_AddMaterial_Review.aspx')


DELETE FROM pBatchQueuePage
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('7c3d653a-1288-e011-81e9-005056c00008', '99a5e4e3-dd70-e011-9039-8ef3dccb61b6', '90000000-0000-0000-0000-000000000003', '0000', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('7d3d653a-1288-e011-81e9-005056c00008', 'd0c913c0-7d8c-e011-81e9-005056c00008', '90000000-0000-0000-0000-000000000003', '0001', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('4acb8240-1288-e011-81e9-005056c00008', '44e5e4e3-dd70-e011-9039-8ef3dccb61b3', '90000000-0000-0000-0000-000000000003', '0003', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('5acb8240-1288-e011-81e9-005056c00008', 'e1c913c0-7d8c-e011-81e9-005056c00008', '90000000-0000-0000-0000-000000000003', '0004', NULL, NULL, NULL, NULL)


DELETE FROM pBatchQueuePageDep
INSERT INTO [dbo].[pBatchQueuePageDep] ([BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) VALUES ('eb1b7beb-1988-e011-81e9-005056c00008', '7d3d653a-1288-e011-81e9-005056c00008', '7c3d653a-1288-e011-81e9-005056c00008')
INSERT INTO [dbo].[pBatchQueuePageDep] ([BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) VALUES ('4fded4f3-1988-e011-81e9-005056c00008', '4acb8240-1288-e011-81e9-005056c00008', '7c3d653a-1288-e011-81e9-005056c00008')




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleColorway_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleColorway_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleColorway_SEL]
AS
SELECT     StyleColorID, StyleID, StyleColorNo, StyleColorName
FROM         dbo.pStyleColorway
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleSeasonal_SEL]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.pStyleHeader.StyleID, dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField15, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField11, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, 
                      dbo.pStyleHeader.CustomField34, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, 
                      dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40
FROM         dbo.pStyleHeader INNER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID INNER JOIN
                      dbo.pStyleColorwaySeasonYear ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID INNER JOIN
                      dbo.pStyleColorway ON dbo.pStyleColorwaySeasonYear.StyleColorwayID = dbo.pStyleColorway.StyleColorID
WHERE     (dbo.pStyleColorwaySeasonYear.StyleColorStatus = 0) OR
                      (dbo.pStyleColorwaySeasonYear.StyleColorStatus = 100)
ORDER BY dbo.pStyleHeader.StyleNo
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]
AS
SELECT DISTINCT 
	  TOP (100) PERCENT pStyleHeader.StyleID, pStyleSeasonYear.SeasonYearID, pStyleHeader.StyleNo, pStyleHeader.Description, 
	  pStyleHeader.StyleCategory, pStyleHeader.SizeClass, pStyleHeader.SizeRange, pStyleHeader.MaterialNo, pStyleHeader.MaterialName, 
	  pStyleHeader.CustomField1, pStyleHeader.CustomField2, pStyleHeader.CustomField3, pStyleHeader.CustomField4, pStyleHeader.CustomField5,
	  pStyleHeader.CustomField6, pStyleHeader.CustomField7, pStyleHeader.CustomField8, pStyleHeader.CustomField15, 
	  pStyleHeader.CustomField14, pStyleHeader.CustomField13, pStyleHeader.CustomField12, pStyleHeader.CustomField11, 
	  pStyleHeader.CustomField10, pStyleHeader.CustomField9, pStyleHeader.CustomField16, pStyleHeader.CustomField30, 
	  pStyleHeader.CustomField29, pStyleHeader.CustomField28, pStyleHeader.CustomField27, pStyleHeader.CustomField26, 
	  pStyleHeader.CustomField25, pStyleHeader.CustomField24, pStyleHeader.CustomField23, pStyleHeader.CustomField22, 
	  pStyleHeader.CustomField21, pStyleHeader.CustomField20, pStyleHeader.CustomField19, pStyleHeader.CustomField18, 
	  pStyleHeader.CustomField17, pStyleHeader.CustomField31, pStyleHeader.CustomField32, pStyleHeader.CustomField33, 
	  pStyleHeader.CustomField34, pStyleHeader.CustomField35, pStyleHeader.CustomField36, pStyleHeader.CustomField37, 
	  pStyleHeader.CustomField38, pStyleHeader.CustomField39, pStyleHeader.CustomField40, pStyleMaterials.StyleMaterialID, 
	  pStyleMaterials.MaterialID
	FROM pStyleHeader INNER JOIN
	  pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN
	  pStyleColorwaySeasonYear ON pStyleSeasonYear.StyleSeasonYearID = pStyleColorwaySeasonYear.StyleSeasonYearID INNER JOIN
	  pStyleColorway ON pStyleColorwaySeasonYear.StyleColorwayID = pStyleColorway.StyleColorID INNER JOIN
	  pStyleMaterials ON pStyleHeader.StyleID = pStyleMaterials.StyleID
	WHERE (pStyleColorwaySeasonYear.StyleColorStatus = 0) OR (pStyleColorwaySeasonYear.StyleColorStatus = 100)
ORDER BY pStyleHeader.StyleNo
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMaterialSeasonal]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal]
AS 

SELECT a.MaterialID , b.StyleID, c.SeasonYearID, b.StyleNo, b.Description, b.SizeClass, b.SizeRange
FROM dbo.pMaterial a
	CROSS JOIN dbo.pStyleHeader b
	CROSS JOIN dbo.pSeasonYear c
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]
AS
SELECT pMaterialColor.MaterialColorID, pMaterialColor.MaterialID, pMaterialColor.MaterialColorImageID, pMaterialColor.MaterialColorImageVersion, 
      pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, pMaterialColor.ColorID, pMaterialColor.ColorCode, pMaterialColor.ColorNo, 
      pMaterialColor.ColorName, pStyleColorwayItem.StyleColorItemID, pStyleColorwayItem.StyleColorID, pStyleColorwayItem.StyleMaterialID, 
      bBatchQueueMaterialReplaceStyle.StyleID, bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceID, 
      bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceStyleID, bBatchQueueMaterialReplace.MaterialFindID, 
      bBatchQueueMaterialReplace.MaterialReplaceID, bBatchQueueMaterialReplace.SeasonYearID
FROM  pMaterialColor INNER JOIN
      pStyleColorwayItem ON pMaterialColor.MaterialColorID = pStyleColorwayItem.MaterialColorID INNER JOIN
      pStyleColorway ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
      pStyleColorwaySeasonYear ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID INNER JOIN
      pStyleSeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
      bBatchQueueMaterialReplaceStyle ON pStyleSeasonYear.StyleID = bBatchQueueMaterialReplaceStyle.StyleID AND 
      pStyleSeasonYear.SeasonYearID = bBatchQueueMaterialReplaceStyle.SeasonYearID INNER JOIN
      bBatchQueueMaterialReplace ON 
      bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceID = bBatchQueueMaterialReplace.BatchQueueMaterialReplaceID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQueue_MaterialReplace_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQueue_MaterialReplace_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQueue_MaterialReplace_SEL]
AS
SELECT     MaterialFind.MaterialNo + ' - ' + MaterialFind.MaterialName AS MaterialFind, 
                      pMaterialReplace.MaterialNo + ' -  ' + pMaterialReplace.MaterialName AS MaterialReplace, dbo.pSeasonYear.Season, dbo.pSeasonYear.Year, 
                      dbo.bBatchQueueMaterialReplace.TeamID, dbo.bBatchQueueMaterialReplace.BatchQueueMaterialReplaceID, dbo.bBatchQueueMaterialReplace.BatchQueueTypeID, 
                      dbo.bBatchQueueMaterialReplace.MaterialFindID, dbo.bBatchQueueMaterialReplace.MaterialReplaceID, dbo.bBatchQueueMaterialReplace.SeasonYearID, 
                      dbo.bBatchQueueMaterialReplace.CUser, dbo.bBatchQueueMaterialReplace.CDate, dbo.bBatchQueueMaterialReplace.MUser, 
                      dbo.bBatchQueueMaterialReplace.MDate
FROM         dbo.pMaterial AS MaterialFind INNER JOIN
                      dbo.bBatchQueueMaterialReplace ON MaterialFind.MaterialID = dbo.bBatchQueueMaterialReplace.MaterialFindID INNER JOIN
                      dbo.pMaterial AS pMaterialReplace ON dbo.bBatchQueueMaterialReplace.MaterialReplaceID = pMaterialReplace.MaterialID INNER JOIN
                      dbo.pSeasonYear ON dbo.bBatchQueueMaterialReplace.SeasonYearID = dbo.pSeasonYear.SeasonYearID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQPage_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQPage_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQPage_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pBatchQueuePage.BatchQueuePageID, dbo.pBatchQueuePage.BatchQueuePageTypeID, dbo.pBatchQueuePage.BatchQueuePageOrder, 
                      dbo.pBatchQueuePageType.BatchQueuePageUrl, dbo.pBatchQueuePageType.BatchQueuePageTypeName, dbo.pBatchQueuePageType.BatchQueuePageTypeDesc, 
                      dbo.pBatchQueuePage.BatchQueueID
FROM         dbo.pBatchQueuePage INNER JOIN
                      dbo.pBatchQueuePageType ON dbo.pBatchQueuePage.BatchQueuePageTypeID = dbo.pBatchQueuePageType.BatchQueuePageTypeID
ORDER BY dbo.pBatchQueuePage.BatchQueuePageOrder
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQJob_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQJob_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQJob_SEL]
AS

SELECT DISTINCT TOP (100) PERCENT  foo.* FROM ( 
	SELECT     
		a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
		a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted, 
		b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
		b.BatchQueueIcon, c.BatchQueuePageID, c.BatchQueuePageTypeID, 
		c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.Status, a.Description, b.BatchQueuePageHistoryUrl
	FROM dbo.pBatchQueueJob a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON a.BatchQueueID = b.BatchQueueID 
		INNER JOIN dbo.pBatchQueuePage c WITH(NOLOCK) ON b.BatchQueueID = c.BatchQueueID 
		INNER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON c.BatchQueuePageTypeID = d.BatchQueuePageTypeID
		LEFT OUTER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID
	WHERE  c.BatchQueuePageOrder = '0000'
		AND a.BatchQueueJobStatusID <> '20000000-0000-0000-0000-000000000000'

	UNION 

	SELECT 	
		a.BatchQueueJobID, a.BatchQueueID, a.BatchQueueJobDate, 
		a.BatchQueueJobTeamID, a.BatchQueueJobStatusID, a.BatchQueueJobCompleted, 
		b.BatchQueueTypeID, b.BatchQueueName, b.BatchQueueDesc, b.BatchQueueUrl, 
		b.BatchQueueIcon, c.BatchQueuePageID, c.BatchQueuePageTypeID, 
		c.BatchQueuePageOrder, d.BatchQueuePageUrl, e.Status, a.Description, b.BatchQueuePageHistoryUrl
	FROM pBatchQueueJob a 
		INNER JOIN dbo.pBatchQueuePage c ON a.BatchQueueID = c.BatchQueueID
		INNER JOIN ( 
			SELECT BatchQueueID, MAX(BatchQueuePageOrder) AS BatchQueuePageOrder
			FROM dbo.pBatchQueuePage 
			GROUP BY BatchQueueID
			) AS foo ON foo.BatchQueueID = c.BatchQueueID 
				AND foo.BatchQueuePageOrder = c.BatchQueuePageOrder
		INNER JOIN dbo.pBatchQueue b WITH(NOLOCK) ON b.BatchQueueID = a.BatchQueueID 
		LEFT OUTER JOIN dbo.pBatchQueuePageType d WITH(NOLOCK) ON d.BatchQueuePageTypeID = c.BatchQueuePageTypeID
		INNER JOIN dbo.pBatchQueueJobStatus e WITH(NOLOCK) ON e.BatchQueueJobStatusID = a.BatchQueueJobStatusID	
	WHERE a.BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
) AS foo 
	INNER JOIN  sAccessBatchQFolderItems a ON a.BatchQueueID =  foo.BatchQueueID 
		AND a.TeamId = foo.BatchQueueJobTeamID 
WHERE a.AccessRoleId = 3 
ORDER BY foo.BatchQueueJobDate DESC

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_SeasonYear_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_SeasonYear_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_SeasonYear_SEL]
AS
SELECT     TOP (100) PERCENT SeasonYearID, Season + ' ' + Year AS SeasonYear, Year, Season
FROM         dbo.pSeasonYear
ORDER BY Year DESC, Season
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialStyleSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialStyleSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialStyleSeasonal_SEL]
AS
SELECT DISTINCT 
  pMaterial.MaterialID, pMaterial.TempID, pMaterial.TempNo, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 
  pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, pMaterial.MaterialType, 
  pMaterial.MaterialNo, pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, pMaterial.E, pMaterial.F, 
  pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, 
  pMaterial.P, pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, pMaterial.W, pMaterial.X, 
  pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
  pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.ImageType1, pMaterial.height, pMaterial.width, 
  pMaterial.CDate, pMaterial.CUser, pMaterial.MDate, pMaterial.MUser, pMaterial.MChange, pMaterial.DChange, pMaterial.Action, 
  pMaterial.Status, pMaterial.Active, pMaterial.MultiDimension, pMaterial.UOM, pMaterial.MaterialCode, pMaterial.MaterialCodeNo, 
  pMaterialColorSeasonYear.SeasonYearID
FROM pMaterial INNER JOIN
  pMaterialColorSeasonYear ON pMaterial.MaterialID = pMaterialColorSeasonYear.MaterialID
AND EXISTS (SELECT MaterialID FROM pStyleMaterials WHERE MaterialID = pMaterial.MaterialID)
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSelected_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialSelected_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialSelected_SEL]
AS
SELECT     MaterialID, TempID, TempNo, MaterialImageID, MaterialImageVersion, MaterialImageDetailID, MaterialImageDetailVersion, NoColorMatch, SupplierID, MaterialType, 
                      MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, VendorPrice, VolumePrice, VolumePriceMinimum, 
                      VendorProductionMin, VendorProductionLeadTime, ImageType1, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, Status, Active, 
                      MultiDimension, UOM, MaterialCode, MaterialCodeNo
FROM         dbo.pMaterial
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialSeasonal_SEL]
AS
SELECT DISTINCT 
                      dbo.pMaterial.MaterialID, dbo.pMaterial.TempID, dbo.pMaterial.TempNo, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, 
                      dbo.pMaterial.MaterialImageDetailID, dbo.pMaterial.MaterialImageDetailVersion, dbo.pMaterial.NoColorMatch, dbo.pMaterial.SupplierID, dbo.pMaterial.MaterialType, 
                      dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.A, dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, 
                      dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, dbo.pMaterial.K, dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, 
                      dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, 
                      dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.Source, dbo.pMaterial.VendorPrice, dbo.pMaterial.VolumePrice, dbo.pMaterial.VolumePriceMinimum, 
                      dbo.pMaterial.VendorProductionMin, dbo.pMaterial.VendorProductionLeadTime, dbo.pMaterial.ImageType1, dbo.pMaterial.height, dbo.pMaterial.width, 
                      dbo.pMaterial.CDate, dbo.pMaterial.CUser, dbo.pMaterial.MDate, dbo.pMaterial.MUser, dbo.pMaterial.MChange, dbo.pMaterial.DChange, dbo.pMaterial.Action, 
                      dbo.pMaterial.Status, dbo.pMaterial.Active, dbo.pMaterial.MultiDimension, dbo.pMaterial.UOM, dbo.pMaterial.MaterialCode, dbo.pMaterial.MaterialCodeNo, 
                      dbo.pMaterialSeasonYear.SeasonYearID
FROM dbo.pMaterial WITH(NOLOCK)
	INNER JOIN	pMaterialSeasonYear WITH(NOLOCK) ON pMaterialSeasonYear.MaterialID =  dbo.pMaterial.MaterialID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialCoreItem_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialCoreItem_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialCoreItem_SEL]
AS
SELECT  dbo.pMaterialCoreItem.MaterialCoreItemID, dbo.pMaterialCoreItem.MaterialCoreID,
		dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.MaterialType,  dbo.pMaterial.A, 
                      dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, 
                      dbo.pMaterial.K, dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, 
                      dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, dbo.pMaterial.Y, dbo.pMaterial.Z, 
                      dbo.pMaterialCoreItem.UOM, 
                      dbo.pMaterialCoreItem.Qty, dbo.pMaterialCoreItem.MaterialPrice, dbo.pMaterialCoreItem.Ext, dbo.pMaterialCoreItem.MaterialSize, dbo.pMaterialCoreItem.Placement, 
                      dbo.pMaterialCoreItem.Artwork, dbo.pMaterialCoreItem.License, dbo.pMaterialCoreItem.Colorway, dbo.pMaterial.MaterialCode, dbo.pMaterial.MaterialCodeNo
FROM         dbo.pMaterial INNER JOIN
                      dbo.pMaterialCoreItem ON dbo.pMaterial.MaterialID = dbo.pMaterialCoreItem.MaterialID
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialCoreColor_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialCoreColor_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialCoreColor_SEL]
AS

SELECT  a.MaterialCoreColorID, MaterialCoreID, b.ColorCode, b.ColorName
FROM dbo.pMaterialCoreColor a 
	INNER JOIN dbo.pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialCore_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialCore_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialCore_SEL]
AS

SELECT MaterialCoreID, MaterialCoreName, MaterialCoreDescription, CUser, CDate, MUser, MDate, Active, Sort
FROM dbo.pMaterialCore WITH(NOLOCK)
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorPalette_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_ColorPalette_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_ColorPalette_SEL]
AS
SELECT     
	'<img src=''../System/Control/ColorStream.ashx?S=25&CFID=' + CAST(ISNULL(a.ColorFolderID, 
	'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(a.ColorPaletteID, 
    '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS ColorImagePath, 
    a.ColorPaletteID, a.ColorFolderID, 
    a.ColorCode, a.ColorName, a.ColorPaletteCustom1,  a.ColorPaletteCustom4
FROM dbo.pColorPalette a
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorFolder_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_ColorFolder_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_ColorFolder_SEL]
AS

	SELECT * FROM dbo.pColorFolder
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialColor_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialColor_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialColor_SEL] 
AS

SELECT a.MaterialColorID, a.SeasonYearID, a.MaterialID , c.ColorName 
FROM pMaterialColorSeasonYear a WITH(NOLOCK)
	INNER JOIN dbo.pMaterialColor b WITH(NOLOCK) ON a.MaterialColorID = b.MaterialColorID 
	INNER JOIN dbo.pColorPalette c WITH(NOLOCK) ON c.ColorPaletteID =  b.ColorPaletteID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_Image_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_Image_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_Image_SEL]
AS
SELECT     
	ImageID, 
	'<img src=''../System/Control/ImageStream.ashx?S=50&IID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') 
	AS VARCHAR(40)) + '&V=' + CAST(ISNULL(Version, 1) AS VARCHAR(5)) + '''>' AS ImagePath, 
	'../System/Control/ImageStream.ashx?S=150&IID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') 
	AS VARCHAR(40)) + '&V=' + CAST(ISNULL(Version, 1) AS VARCHAR(5))  AS DataListImagePath,
	Version, ImageNo, ImageDescription, 
	b.ImageType AS ImageTypeName,
	b.ImageTypeID, ImageFile, 
	ImageFileType, ImageSize, ImageSubFolder1, ImageSubFolder2, ImageSubFolder3, ImageSubFolder4, ImageSubFolder5, ImageSubFolder6, 
    ImageSubFolder7, ImageSubFolder8, ImageSubFolder9, ImageSubFolder10, ImageSubFolder11, ImageSubFolder12, ImageSubFolder13
FROM pImage a WITH(NOLOCK)
	LEFT OUTER JOIN  pImageType b WITH(NOLOCK) ON a.ImageSubFolder1 = b.ImageType
	LEFT OUTER JOIN iCustom2 c WITH(NOLOCK) ON a.ImageSubFolder3 = c.Custom
	LEFT OUTER JOIN aCustom3 d  WITH(NOLOCK) ON a.ImageSubFolder4 = d.Custom
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialColorSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_MaterialColorSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialColorSeasonal_SEL]
AS 


SELECT b.MaterialID, b.SeasonYearID, d.ComponentDescription AS MaterialType,
	c.MaterialName, c.MaterialNo, c.Active, c.CUser, c.CDate
FROM (
SELECT DISTINCT materialID, SeasonYearID 
FROM pMaterialColorSeasonYear a WITH(NOLOCK)
) AS foo 
INNER JOIN pMaterialSeasonyear b WITH(NOLOCK) ON foo.MaterialID = b.MaterialID
		AND b.SeasonyearID =  foo.SeasonYearID
INNER JOIN dbo.pMaterial c WITH(NOLOCK) ON c.MaterialID = b.MaterialID
INNER JOIN dbo.pComponentType d WITH(NOLOCK) ON C.MaterialType =  d.ComponentTypeID
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.pStyleHeader.StyleID, dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.StyleCategory, dbo.pStyleCategory.StyleCategory AS 'ProductCategoryName',
                       dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField15, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField11, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, 
                      dbo.pStyleHeader.CustomField34, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, 
                      dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40, dbo.pStyleHeader.StyleType, 
                      '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) + '" \>' AS ImagePath, 
                      '../System/Control/ImageStream.ashx?S=150&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) AS DataListImagePath,
                          --(SELECT     dbo.pStyleColorway.SAPCODE + ', '
                          --  FROM          dbo.pStyleHeader pSH(NOLOCK) LEFT OUTER JOIN
                          --                         dbo.pStyleColorway(NOLOCK) ON pSH.StyleID = dbo.pStyleColorway.StyleID
                          --  WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) SAPCode,
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH(NOLOCK) LEFT OUTER JOIN
                                                   dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner(NOLOCK) ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) TradePartnerName,
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor(NOLOCK) ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) VendorName, /*dbo.pStyleColorway.SAPCODE, */ dbo.pSeasonYear.Season, 
                      dbo.pSeasonYear.Year, dbo.pLinePlanStyleAttributeItem.AttributeName
FROM         dbo.pStyleHeader(NOLOCK) INNER JOIN
                      dbo.pStyleSeasonYear(NOLOCK) ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pStyleColorwaySeasonYear(NOLOCK) ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleCategory(NOLOCK) ON dbo.pStyleCategory.StyleCategoryId = dbo.pStyleHeader.StyleCategory LEFT OUTER JOIN
                      --dbo.pStyleColorway(NOLOCK) ON dbo.pStyleColorwaySeasonyear.StyleColorWayID = dbo.pStyleColorway.StyleColorID INNER JOIN
                      dbo.pSeasonyear(NOLOCK) ON dbo.pStyleSeasonyear.SeasonYearID = dbo.pSeasonyear.SeasonYearID LEFT OUTER JOIN
                      dbo.pLinePlanItem(NOLOCK) ON dbo.pLinePlanItem.LinePlanItemID = pStyleSeasonYear.LinePlanITEMID LEFT OUTER JOIN
                      dbo.pLinePlanStyleAttributeItem(NOLOCK) ON dbo.pLinePlanStyleAttributeItem.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID
WHERE     EXISTS
                          (SELECT     StyleID
                            FROM          dbo.pStyleSeasonYear AS pStyleSeasonYear_1
                            GROUP BY StyleID
                            HAVING      (COUNT(*) = 1) AND (StyleID = dbo.pStyleHeader.StyleID))
ORDER BY dbo.pStyleHeader.StyleNo
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMultiSeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleMultiSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleMultiSeasonal_SEL]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.pStyleHeader.StyleID, dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.StyleCategory, dbo.pStyleCategory.StyleCategory AS 'ProductCategoryName',
                       dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField15, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField11, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, 
                      dbo.pStyleHeader.CustomField34, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, 
                      dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40, dbo.pStyleHeader.StyleType, 
                      '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) + '" \>' AS ImagePath, 
                      '../System/Control/ImageStream.ashx?S=150&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) AS DataListImagePath,
                          --(SELECT     dbo.pStyleColorway.SAPCODE + ', '
                          --  FROM          dbo.pStyleHeader pSH(NOLOCK) LEFT OUTER JOIN
                          --                         dbo.pStyleColorway(NOLOCK) ON pSH.StyleID = dbo.pStyleColorway.StyleID
                          --  WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) SAPCode,
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH(NOLOCK) LEFT OUTER JOIN
                                                   dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner(NOLOCK) ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) TradePartnerName,
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor(NOLOCK) ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) VendorName, /*dbo.pStyleColorway.SAPCODE, */ dbo.pSeasonYear.Season, 
                      dbo.pSeasonYear.Year, dbo.pLinePlanStyleAttributeItem.AttributeName
FROM         dbo.pStyleHeader(NOLOCK) INNER JOIN
                      dbo.pStyleSeasonYear(NOLOCK) ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pStyleColorwaySeasonYear(NOLOCK) ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleCategory(NOLOCK) ON dbo.pStyleCategory.StyleCategoryId = dbo.pStyleHeader.StyleCategory LEFT OUTER JOIN
                      --dbo.pStyleColorway(NOLOCK) ON dbo.pStyleColorwaySeasonyear.StyleColorWayID = dbo.pStyleColorway.StyleColorID INNER JOIN
                      dbo.pSeasonyear(NOLOCK) ON dbo.pStyleSeasonyear.SeasonYearID = dbo.pSeasonyear.SeasonYearID LEFT OUTER JOIN
                      dbo.pLinePlanItem(NOLOCK) ON dbo.pLinePlanItem.LinePlanItemID = pStyleSeasonYear.LinePlanITEMID LEFT OUTER JOIN
                      dbo.pLinePlanStyleAttributeItem(NOLOCK) ON dbo.pLinePlanStyleAttributeItem.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID
ORDER BY dbo.pStyleHeader.StyleNo
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
AS
SELECT 
	a.StyleID, a.StyleNo, a.Description, a.CustomField14, a.MaterialName, 
	a.CustomField2, a.CustomField3, a.CustomField4, a.StyleType, a.SizeClass, a.SizeRange, 
	d .Season, d .Year, g.AttributeName, a.StyleCategory, e.StyleCategory AS 'ProductCategoryName',
	b.StyleSeasonyearID, b.SeasonYearID,
	
                            
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) AS TradePartnerName,
                            
                            
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) AS VendorName
                            
                            
FROM         pStyleHeader a 
	INNER JOIN pStyleSeasonYear b ON a.StyleID = b.StyleID 
	INNER JOIN pSeasonYear d ON d .SeasonyearID = b.SeasonYearID 
	LEFT OUTER JOIN dbo.pLinePlanItem f ON f.LinePlanItemID = b.LinePlanItemID 
	LEFT OUTER JOIN pLinePlanStyleAttributeItem g ON g.LinePlanStyleAttributeItemID = f.LinePlanStyleAttributeItemID 
	LEFT OUTER JOIN dbo.pStyleCategory e ON e.StyleCategoryId = a.StyleCategory
GO



DELETE FROM cDesktopFolder WHERE DeskFolderId = 16 

IF NOT  EXISTS ( SELECT * FROM cDesktopFolder WHERE DeskFolderId = 18)
	INSERT INTO dbo.cDesktopFolder( DeskFolderId ,DeskFolderName ,DeskFolderUrl ,DeskSubFolder ,DeskGroupFolderUrl)
	VALUES  ( 18, 'BatchQ Folder', 'Control_User_BatchQ.aspx' , 0, 'Control_Group_BatchQ.aspx')



UPDATE sDeskTop SET 
	DeskMenu = '../BatchQ/BatchQ_Menu.aspx' ,
	DeskMain = '../BatchQ/BatchQ_Main.aspx?' 
WHERE DeskTopID = 26




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessBatchQFolder_SELECT]') AND type in (N'P'))
    DROP PROCEDURE spx_AccessBatchQFolder_SELECT
GO
CREATE PROCEDURE [dbo].[spx_AccessBatchQFolder_SELECT] (     
	@GroupID uniqueidentifier    
)    
AS     

	SELECT *    
	FROM  sAccessBatchQFolder    
	WHERE sAccessBatchQFolder.GroupID = @GroupID    
	ORDER BY sAccessBatchQFolder.BatchQTypeDesc  
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBatchQFolder_SELECT]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_AccessBatchQFolder_SELECT
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessBatchQFolder_SELECT] (   
	@GroupID uniqueidentifier  
)  
AS   
  
  
SELECT a.BatchQueueTypeID, a.BatchQueueTypeName,   
 b.AccessBatchQueueId,  b.AccessRoleId, b.AccessView, b.AccessCreate,   
 b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove,   
 b.GroupID, b.CUser, b.CDate,  b.MUser,   
 b.MDate
FROM  pBatchQueueType a WITH (NOLOCK) INNER JOIN   dbo.sAccessGroupBatchQueueFolder  b WITH (NOLOCK) ON a.BatchQueueTypeID = b.BatchQueueTypeID  
WHERE b.GroupID = @GroupID  
ORDER BY a.BatchQueueTypeName   



GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE]') AND type in (N'P'))
    DROP PROCEDURE spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE
GO


CREATE PROCEDURE [dbo].[spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE] (  
@BatchQTypeID UNIQUEIDENTIFIER,    
@GroupID uniqueidentifier ,    
@FullName as nvarchar (200) ,    
@CDate  as DateTime  
)    
AS    
DECLARE @TeamID uniqueidentifier    
DECLARE @DeskFolderID INT    
    
-- GET USERS IN THE GROUP     
    
DECLARE cursor_users CURSOR FOR     
SELECT TeamID FROM uUserGroup WITH (NOLOCK) WHERE GroupID = @GroupID    
    
OPEN cursor_users    
    
FETCH NEXT FROM cursor_users INTO @TeamID    
    
    
WHILE @@FETCH_STATUS = 0     
BEGIN    
    
 --SELECT USUARIO = @TeamID    
    
     
 --IF @FolderName = 'BatchQ Folder'      
 BEGIN    
    
  /********************************************************************************************************************************************************************/    
  -- BatchQ FOLDER    
  DELETE FROM sAccessBatchQFolderItems where TeamID = @TeamID AND  BatchQTypeId = @BatchQTypeID     
    
  INSERT INTO sAccessBatchQFolderItems (AccessBatchQId, BatchQTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessRemove, AccessDelete , AccessPrint , BatchQueueID,  TeamId, CUser, CDate, MUser, MDate, GroupID   )    
  SELECT  AccessBatchQId,  BatchQTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,     
  MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , BatchQueueID, @TeamID as TeamId ,    
  @FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate , GroupID    
  FROM sAccessBatchQItems WITH (NOLOCK)    
  WHERE GroupID IN (     
   SELECT  a.GroupID     
   FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)    
   WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID     
   AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 18    
  )     
 AND sAccessBatchQItems.BatchQTypeId = @BatchQTypeID  
  GROUP BY  BatchQueueID, AccessBatchQId, BatchQTypeId, GroupID      
    
    
  SET @DeskFolderID  =  18    
  IF ( SELECT count(*) FROM sAccessBatchQFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0      
  BEGIN     
   IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0     
    UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID      
   ELSE     
    INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )    
    VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )    
  END    
  ELSE    
    
   DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId     
 END    
        
     
     
 FETCH NEXT FROM cursor_users INTO @TeamID    
END     
    
    
CLOSE cursor_users    
DEALLOCATE cursor_users    
    
    
    
/****************************************************************************************************************************************************************************************************************************************/    
-- CHECK FOR USER WITHOUT A GROUP     
DECLARE cursor_users2 CURSOR FOR     
SELECT  TeamID from Users  WITH (NOLOCK) WHERE TeamID not in (  select  DISTINCT TeamID  from uUserGroup WITH (NOLOCK) )     
    
    
OPEN cursor_users2    
FETCH NEXT FROM cursor_users2 INTO @TeamID    
    
WHILE @@FETCH_STATUS = 0     
BEGIN    
     
 DELETE FROM sAccessBatchQFolder where TeamID = @TeamID      
    
    
 FETCH NEXT FROM cursor_users2 INTO @TeamID    
    
END     
    
CLOSE cursor_users2    
DEALLOCATE cursor_users2    
  
  

go


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT
GO


CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT] (        
	@AccessBatchQId uniqueidentifier,       
	@AccessRoleId int,      
	@BatchQTypeID UNIQUEIDENTIFIER,      
	@GroupID uniqueidentifier,     
	@TeamID uniqueidentifier,     
	@CreatedBy nvarchar(200),        
	@CreatedDate datetime        
)        
AS        
        
DECLARE @I as int        
DECLARE @Row_Count int        
DECLARE @BatchQueueTypeIDVal UNIQUEIDENTIFIER        
      
DECLARE @I_WF as int        
DECLARE @Row_Count_WF int        
DECLARE @BatchQueueIDVal uniqueidentifier       
       
DECLARE @DeskAccessId int        
DECLARE @DeskTableName varchar(100)        
DECLARE @DeskTableKey varchar(50)        
        
        


CREATE TABLE #TempGroupAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  BatchQueueTypeID UNIQUEIDENTIFIER NOT NULL,        
  GroupID uniqueidentifier         
)         

        
         
INSERT INTO #TempGroupAccess( BatchQueueTypeID) 
SELECT BatchQueueTypeID FROM pBatchQueueType        
         
         
SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)        
SET @I = 1        
        
WHILE @I <= @Row_Count         
BEGIN        
	SELECT @BatchQueueTypeIDVal = BatchQueueTypeID 
	FROM #TempGroupAccess WHERE ID = @I        
   
	IF NOT EXISTS (SELECT * FROM sAccessGroupBatchQueueFolder WITH (NOLOCK) 
		WHERE BatchQueueTypeId = @BatchQueueTypeIDVal  AND GroupID = @GroupID ) 
	BEGIN        
		INSERT INTO sAccessGroupBatchQueueFolder( BatchQueueTypeID, GroupID, CUser, CDate, MUser, MDate)        
		VALUES (@BatchQueueTypeIDVal, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)         
	END        
            
   SET @I = @I + 1        
END        

--** Select the batchQue types  (Material or Style folder)      
SELECT * FROM #tempGroupAccess        
       
       
CREATE TABLE #TempWorkflowAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  BatchQueueID uniqueidentifier        
)         


--** Select the batchQue types (Material find replace, add mat, add color.... ) 
INSERT INTO #TempWorkflowAccess(BatchQueueID) 
SELECT BatchQueueID 
FROM pBatchQueue      
WHERE BatchQueueTypeID =    @BatchQTypeID      

         
SET @Row_Count_WF = (SELECT COUNT(*) FROM #TempWorkflowAccess)        
SET @I_WF = 1        
        
WHILE @I_WF <= @Row_Count_WF         
BEGIN        
        
	SELECT @BatchQueueIDVal = BatchQueueID FROM #TempWorkflowAccess WHERE ID = @I_WF        
	IF NOT EXISTS (SELECT * FROM sAccessBatchQItems WITH (NOLOCK) 
		WHERE BatchQTypeId = @BatchQTypeID  AND GroupID = @GroupID AND BatchQueueID = @BatchQueueIDVal)
	BEGIN        
		INSERT INTO sAccessBatchQItems        
			( AccessBatchQId, AccessRoleId, BatchQTypeID, GroupID, BatchQueueID, CUser, CDate, MUser, MDate)        
		VALUES (@AccessBatchQId, @AccessRoleId, @BatchQTypeID, @GroupID, @BatchQueueIDVal, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)         
	END        
            
	SET @I_WF = @I_WF + 1        
END        
        
SELECT * FROM #TempWorkflowAccess        
    
    
------------New Changes------------------    
DECLARE @I_WF_2 as int        
DECLARE @Row_Count_WF_2 int        
DECLARE @BatchQueueFolderIDVal uniqueidentifier    
     
CREATE TABLE #TempWorkflowFolderAccess (        
  Id int IDENTITY (1, 1) NOT NULL ,         
  BatchQueueID uniqueidentifier        
)         
         
        
INSERT INTO #TempWorkflowFolderAccess(BatchQueueID) 
SELECT BatchQueueID FROM pBatchQueue     
WHERE BatchQueueTypeID =    @BatchQTypeID 
         
         
SET @Row_Count_WF_2 = (SELECT COUNT(*) FROM #TempWorkflowFolderAccess)        
SET @I_WF_2 = 1        
        
WHILE @I_WF_2 <= @Row_Count_WF_2         
BEGIN        
        
	SELECT @BatchQueueFolderIDVal = BatchQueueID FROM #TempWorkflowFolderAccess WHERE ID = @I_WF_2        
	IF NOT EXISTS (SELECT * FROM sAccessBatchQFolderItems WITH (NOLOCK) WHERE BatchQTypeId = @BatchQTypeID  AND GroupID = @GroupID AND BatchQueueID = @BatchQueueFolderIDVal) 
	BEGIN        
		INSERT INTO sAccessBatchQFolderItems        
			( AccessBatchQId, AccessRoleId, BatchQTypeId, GroupID, BatchQueueID, CUser, CDate, MUser, MDate, TeamID)        
		VALUES (@AccessBatchQId, @AccessRoleId, @BatchQTypeID, @GroupID, @BatchQueueFolderIDVal, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID )
	END        
            
	SET @I_WF_2 = @I_WF_2 + 1        
END        
        
SELECT * FROM #TempWorkflowFolderAccess      
    
    
        
 
go
	
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBatchQFolder_UPDATE_ALL]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_AccessBatchQFolder_UPDATE_ALL
GO
  
CREATE PROCEDURE [dbo].[spx_Group_AccessBatchQFolder_UPDATE_ALL]  (    
	@AccessRoleId int  ,     
	@AccessView int ,     
	@AccessCreate int ,     
	@AccessModify int,     
	@AccessRemove int ,     
	@AccessDelete int ,     
	@AccessPrint int ,     
	@GroupID uniqueidentifier ,   
	@TeamID uniqueidentifier ,    
	@MUser nvarchar (200),     
	@MDate  datetime ,     
	@AccessBatchQId uniqueidentifier     
)    
AS     
  

DECLARE @BatchQTypeID UNIQUEIDENTIFIER 
SET   @BatchQTypeID = (SELECT BatchQueueTypeId FROM sAccessGroupBatchQueueFolder WHERE AccessBatchQueueId = @AccessBatchQId)
  
EXEC spx_Group_DesktopAccessBatchQueueItemFolderCheck_INSERT @AccessBatchQId ,  @AccessRoleId, @BatchQTypeID ,  @GroupID , @TeamID , @MUser ,   @MDate   
  
 
UPDATE sAccessGroupBatchQueueFolder      
	SET AccessRoleId = @AccessRoleId,     
	AccessView = @AccessView,      
	AccessCreate = @AccessCreate,      
	AccessModify = @AccessModify,     
	AccessRemove = @AccessRemove,     
	AccessDelete = @AccessDelete,      
	AccessPrint = @AccessPrint,     
	GroupID = @GroupID,     
	MUser = @MUser,      
	MDate = @MDate      
WHERE AccessBatchQueueId = @AccessBatchQId  
  
UPDATE sAccessBatchQItems      
 SET AccessRoleId = @AccessRoleId,     
 AccessView = @AccessView,      
 AccessCreate = @AccessCreate,      
 AccessModify = @AccessModify,     
 AccessRemove = @AccessRemove,     
 AccessDelete = @AccessDelete,      
 AccessPrint = @AccessPrint,     
 MUser = @MUser,      
 MDate = @MDate      
 WHERE BatchQTypeId = @BatchQTypeID AND GroupID = @GroupID  
  
exec spx_BatchQueueItems_AccessFolderUserPermissions_UPDATE @BatchQTypeID, @GroupID , @MUser , @MDate   

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBatchQueue_SELECT]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_AccessBatchQueue_SELECT
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessBatchQueue_SELECT] (
@GroupID uniqueidentifier
)
AS 

SELECT a.BatchQueueTypeID, b.BatchQueueTypeDescription, a.AccessBatchQueueId, 
       a.AccessRoleId, a.AccessView, a.AccessCreate, 
       a.AccessModify, a.AccessDelete, a.AccessPrint, 
       a.GroupID, a.CUser, a.CDate, a.MUser, a.MDate, b.BatchQueueSort 
FROM  bBatchQueueType b WITH (NOLOCK) INNER JOIN sAccessGroupBatchQueue a WITH (NOLOCK) ON a.BatchQueueTypeID = b.BatchQueueTypeID
WHERE a.GroupID = @GroupID 
ORDER BY b.BatchQueueSort, b.BatchQueueTypeDescription

go


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBatchQueueFolder_UPDATE]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_AccessBatchQueueFolder_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessBatchQueueFolder_UPDATE]  (  
	@AccessRoleId int  ,   
	@AccessView int ,   
	@AccessCreate int ,   
	@AccessModify int,   
	@AccessRemove int ,   
	@AccessDelete int ,   
	@AccessPrint int ,   
	@GroupID uniqueidentifier ,   
	@MUser nvarchar (200),   
	@MDate  datetime ,   
	@AccessBatchQId uniqueidentifier   
)  
AS   
  
UPDATE sAccessGroupBatchQueueFolder    
	SET AccessRoleId = @AccessRoleId,   
	AccessView = @AccessView,    
	AccessCreate = @AccessCreate,    
	AccessModify = @AccessModify,   
	AccessRemove = @AccessRemove,   
	AccessDelete = @AccessDelete,    
	AccessPrint = @AccessPrint,   
	GroupID = @GroupID,   
	MUser = @MUser,    
	MDate = @MDate    
WHERE AccessBatchQueueId = @AccessBatchQId

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBatchQCheck_INSERT]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_DesktopAccessBatchQCheck_INSERT
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQCheck_INSERT] (  
@GroupID uniqueidentifier,   
@CreatedBy nvarchar(200),  
@CreatedDate datetime,  
@TeamID uniqueidentifier   
)  
AS  
  
DECLARE @I as int  
DECLARE @Row_Count int  
DECLARE @BatchQueueTypeID uniqueidentifier   
DECLARE @DeskAccessId int  
DECLARE @DeskTableName varchar(100)  
DECLARE @DeskTableKey varchar(50)  
  
  
 BEGIN  
 CREATE TABLE #TempGroupAccess (  
  Id int IDENTITY (1, 1) NOT NULL ,   
  BatchQueueTypeID uniqueidentifier NOT NULL,  
  GroupID uniqueidentifier   
 )   
 END  
  
 BEGIN  
   
 INSERT INTO #TempGroupAccess( BatchQueueTypeID) SELECT BatchQueueTypeID FROM pBatchQueueType  
   
   
 SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)  
   
 SET @I = 1  
  
 WHILE @I <= @Row_Count   
  BEGIN  
  
   SELECT @BatchQueueTypeID = BatchQueueTypeID FROM #TempGroupAccess WHERE ID = @I  
   IF (SELECT COUNT(*) FROM sAccessGroupBatchQueueFolder WITH (NOLOCK) WHERE BatchQueueTypeID = @BatchQueueTypeID  AND GroupID = @GroupID ) = 0  
   BEGIN  
    INSERT INTO sAccessGroupBatchQueueFolder  
     ( BatchQueueTypeID, GroupID, CUser, CDate, MUser, MDate, TeamID)  
    SELECT BatchQueueTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate ,  @TeamID  
    FROM  #TempGroupAccess WHERE Id = @I  
   END  
      
   SET @I = @I + 1  
  END  
  
  SELECT * FROM #tempGroupAccess  
  
 END  
  
  
go



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessBatchQueueCheck_INSERT]') AND type in (N'P'))
    DROP PROCEDURE spx_Group_DesktopAccessBatchQueueCheck_INSERT
GO


CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessBatchQueueCheck_INSERT] (
@GroupID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @BatchQueueTypeID uniqueidentifier 

BEGIN
CREATE TABLE #TempGroupAccess (
	Id int IDENTITY (1, 1) NOT NULL , 
	BatchQueueTypeID uniqueidentifier NOT NULL
) 
END

BEGIN
	INSERT INTO #TempGroupAccess(BatchQueueTypeID) SELECT BatchQueueTypeID FROM bBatchQueueType

	SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)
	SET @I = 1

	WHILE @I <= @Row_Count 
	BEGIN
		SELECT @BatchQueueTypeID = BatchQueueTypeID FROM #TempGroupAccess WHERE ID = @I

		IF (SELECT COUNT(*) FROM sAccessGroupBatchQueue WITH (NOLOCK) WHERE BatchQueueTypeId = @BatchQueueTypeID AND GroupID = @GroupID) = 0
		BEGIN
			INSERT INTO sAccessGroupBatchQueue(BatchQueueTypeId, GroupID, CUser, CDate, MUser, MDate)
			SELECT BatchQueueTypeId, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
			FROM #TempGroupAccess WHERE Id = @I
		END

		SET @I = @I + 1
	END

	SELECT * FROM #tempGroupAccess
END



go



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Item_AccessBatchQFolder_SELECT]') AND type in (N'P'))
    DROP PROCEDURE spx_Item_AccessBatchQFolder_SELECT
GO

  
CREATE  PROCEDURE [dbo].[spx_Item_AccessBatchQFolder_SELECT] (     
@GroupID uniqueidentifier,  
@BatchQueueTypeID UNIQUEIDENTIFIER    
)    
AS     
    
    
SELECT a.BatchQueueDesc, a.BatchQueueID, a.BatchQueueName,    
 b.AccessBatchQItemID, b.AccessBatchQId,  b.AccessRoleId, b.AccessView, b.AccessCreate,     
 b.AccessModify, b.AccessDelete, b.AccessPrint, b.AccessRemove,     
 b.GroupID, b.CUser, b.CDate,  b.MUser,     
 b.MDate    
FROM  pBatchQueue a WITH (NOLOCK) INNER JOIN   sAccessBatchQItems  b WITH (NOLOCK) ON a.BatchQueueID = b.BatchQueueID    
WHERE b.GroupID = @GroupID  AND b.BatchQTypeId = @BatchQueueTypeID   
ORDER BY a.BatchQueueName   
  

go


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Item_AccessBatchQFolder_UPDATE]') AND type in (N'P'))
    DROP PROCEDURE spx_Item_AccessBatchQFolder_UPDATE
GO


CREATE PROCEDURE [dbo].[spx_Item_AccessBatchQFolder_UPDATE]  (    
@AccessRoleId int  ,     
@AccessView int ,     
@AccessCreate int ,     
@AccessModify int,     
@AccessRemove int ,     
@AccessDelete int ,     
@AccessPrint int ,   
@MUser nvarchar (200),     
@MDate  datetime ,     
@AccessBatchQItemID uniqueidentifier     
)    
AS     
    
 UPDATE sAccessBatchQItems      
 SET AccessRoleId = @AccessRoleId,     
 AccessView = @AccessView,      
 AccessCreate = @AccessCreate,      
 AccessModify = @AccessModify,     
 AccessRemove = @AccessRemove,     
 AccessDelete = @AccessDelete,      
 AccessPrint = @AccessPrint,     
 MUser = @MUser,      
 MDate = @MDate      
 WHERE AccessBatchQItemID = @AccessBatchQItemID  
  

go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessBatchQFolder_SELECT]') AND type in (N'P'))
    DROP PROCEDURE spx_User_AccessBatchQFolder_SELECT
GO

CREATE PROCEDURE [dbo].[spx_User_AccessBatchQFolder_SELECT](
@teamId UNIQUEIDENTIFIER
)  
AS   
  
  
SELECT pBatchQueueType.BatchQueueTypeID, pBatchQueueType.BatchQueueTypeName,   
 sAccessBatchQFolder.AccessBatchQId,   
 sAccessBatchQFolder.AccessRoleId, sAccessBatchQFolder.AccessView, sAccessBatchQFolder.AccessCreate,   
 sAccessBatchQFolder.AccessModify, sAccessBatchQFolder.AccessDelete, sAccessBatchQFolder.AccessPrint,   
 sAccessBatchQFolder.TeamId, sAccessBatchQFolder.CUser, sAccessBatchQFolder.CDate, sAccessBatchQFolder.MUser,   
 sAccessBatchQFolder.MDate  
FROM  pBatchQueueType WITH (NOLOCK) INNER JOIN  
    sAccessBatchQFolder WITH (NOLOCK) ON pBatchQueueType.BatchQueueTypeID = sAccessBatchQFolder.BatchQTypeID  
WHERE sAccessBatchQFolder.TeamId = @teamId  
ORDER BY pBatchQueueType.BatchQueueTypeName  
  
go 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessBatchQueue_SELECT]') AND type in (N'P'))
    DROP PROCEDURE spx_User_AccessBatchQueue_SELECT
GO

CREATE PROCEDURE [dbo].[spx_User_AccessBatchQueue_SELECT](
	@teamId uniqueidentifier
)
AS 

SELECT a.BatchQueueTypeID, b.BatchQueueTypeDescription, a.AccessBatchQueueId, 
       a.AccessRoleId, a.AccessView, a.AccessCreate, 
       a.AccessModify, a.AccessDelete, a.AccessPrint, 
       a.TeamId, a.CUser, a.CDate, a.MUser, a.MDate 
FROM  bBatchQueueType b WITH (NOLOCK) INNER JOIN sAccessBatchQueue a WITH (NOLOCK) ON a.BatchQueueTypeID = b.BatchQueueTypeID
WHERE a.TeamId = @teamId
ORDER BY b.BatchQueueSort, b.BatchQueueTypeDescription



go 
  
  
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessBatchQFolderCheck_INSERT]') AND type in (N'P'))
    DROP PROCEDURE spx_User_DesktopAccessBatchQFolderCheck_INSERT
GO

CREATE  PROCEDURE [dbo].[spx_User_DesktopAccessBatchQFolderCheck_INSERT]  
(  
@GroupID uniqueidentifier,
@TeamId uniqueidentifier,  
@CreatedBy nvarchar(200),  
@CreatedDate datetime  
)  
AS  
  
DECLARE @I as int  
DECLARE @Row_Count int  
DECLARE @BatchQueueTypeID UNIQUEIDENTIFIER   
DECLARE @DeskAccessId int  
DECLARE @DeskTableName varchar(100)  
DECLARE @DeskTableKey varchar(50)  
  
  
 BEGIN  
 CREATE TABLE #TempUserAccess (  
  Id int IDENTITY (1, 1) NOT NULL ,   
  BatchQueueTypeID UNIQUEIDENTIFIER NOT NULL,    
  TeamId uniqueidentifier  
 )   
 END  
  
 BEGIN  
   
 INSERT INTO #TempUserAccess( BatchQueueTypeID ) SELECT BatchQueueTypeID FROM pBatchQueueType WITH (NOLOCK)  
   
   
 SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)  
   
 SET @I = 1  
  
 WHILE @I <= @Row_Count   
  BEGIN  
  
   SELECT @BatchQueueTypeID = BatchQueueTypeID FROM #TempUserAccess WHERE ID = @I  
   IF (SELECT COUNT(*) FROM sAccessBatchQFolder WITH (NOLOCK) WHERE BatchQTypeId = @BatchQueueTypeID  AND TeamId = @TeamId) = 0  
   BEGIN  
    INSERT INTO sAccessBatchQFolder  
     ( BatchQTypeId, TeamId, CUser, CDate, MUser, MDate, GroupID)  
    SELECT BatchQueueTypeID, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate,  @GroupID  
    FROM  #TempUserAccess WHERE Id = @I  
   END  
      
   SET @I = @I + 1  
  END  
  
  SELECT * FROM #tempUserAccess  
  
 END  
  
  
  
go


  
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessBatchQueueCheck_INSERT]') AND type in (N'P'))
    DROP PROCEDURE spx_User_DesktopAccessBatchQueueCheck_INSERT
GO




CREATE PROCEDURE [dbo].[spx_User_DesktopAccessBatchQueueCheck_INSERT]
(
@TeamId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @BatchQueueTypeId uniqueidentifier
DECLARE @DeskAccessId int
DECLARE @DeskTableName varchar(100)
DECLARE @DeskTableKey varchar(50)

BEGIN
	CREATE TABLE #TempUserAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		BatchQueueTypeId uniqueidentifier NOT NULL,
		TeamId uniqueidentifier
	) 
END

BEGIN
	INSERT INTO #TempUserAccess(BatchQueueTypeId) SELECT BatchQueueTypeId FROM bBatchQueueType WITH (NOLOCK)

	SET @Row_Count = (SELECT COUNT(*) FROM #TempUserAccess)

	SET @I = 1

	WHILE @I <= @Row_Count 
	BEGIN
		SELECT @BatchQueueTypeId = BatchQueueTypeId FROM #TempUserAccess WHERE ID = @I
		IF (SELECT COUNT(*) FROM sAccessBatchQueue WITH (NOLOCK) WHERE BatchQueueTypeId = @BatchQueueTypeId AND TeamId = @TeamId) = 0
		BEGIN
			INSERT INTO sAccessBatchQueue (BatchQueueTypeId, TeamId, CUser, CDate, MUser, MDate)
			SELECT BatchQueueTypeId, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
			FROM #TempUserAccess WHERE Id = @I
		END

		SET @I = @I + 1
	END

	SELECT * FROM #tempUserAccess
END



GO




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_AddStyleMaterial_Logic_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQJob_AddStyleMaterial_Logic_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_AddStyleMaterial_Logic_INSERT](
	@BatchQueuePagePkName varchar(200),
	@BatchQueuePagePkID uniqueidentifier, 
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueId uniqueidentifier,
	@CUser NVarChar(200),
	@CDate datetime
)
AS 


--** @BatchQueuePagePkID  holds MaterialID 

--** Regular insert 
EXEC spx_BatchQJobItem_INSERT
	@BatchQueuePagePkName = @BatchQueuePagePkName,
	@BatchQueuePagePkID = @BatchQueuePagePkID ,
	@BatchQueuePageID = @BatchQueuePageID,
	@BatchQueueJobId = @BatchQueueJobId,
	@BatchQueueJobItemId = @BatchQueueJobItemId,
	@BatchQueueId = @BatchQueueId,
	@CUser = @CUser,
	@CDate = @CDate

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_MaterialAdd_Style_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_MaterialAdd_Style_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_MaterialAdd_Style_SELECT] (
	@BatchQueuePagePkName VARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable VARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	,
	@ReturnSQLString INT = 0
)AS 


DECLARE 
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@SeasonYearID UNIQUEIDENTIFIER,
	@SQL NVARCHAR(MAX)

--** Get Seasonyear
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID  FROM ' + @syBatchQueueJobTable + ' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT



--** Find table/view submited in parameters
DECLARE 
	@tmpBatchQueueGridSql NVARCHAR(MAX),
	@ROWID INT ,
	@tmpTable NVARCHAR(200),
	@nPosWhere INT,
	@Where NVARCHAR(MAX)

SET @tmpBatchQueueGridSql = RTRIM(LTRIM(UPPER(@BatchQueueGridSql)))

SELECT IDENTITY(INT ,1,1) AS RowID, * INTO #tmp FROM dbo.split(@tmpBatchQueueGridSql,' ')  
SELECT @ROWID = ROWID FROM #tmp WHERE  RTRIM(LTRIM(items)) = 'FROM'
SELECT TOP 1 @tmpTable = items FROM #tmp  WHERE ROWID = @ROWID + 1 
DROP TABLE #tmp


SET @nPosWhere = CHARINDEX(' WHERE ',@tmpBatchQueueGridSql )
IF @nPosWhere > 0 
	SET @Where = SUBSTRING(@tmpBatchQueueGridSql , @nPosWhere +  7, LEN (@tmpBatchQueueGridSql))


IF @SeasonYearID IS NULL 
BEGIN 

	SET  @SQL = 'SELECT * FROM ' + @tmpTable + ' WHERE 1 = 2'

END 
ELSE
BEGIN 


	SET @SQL = '
	SELECT DISTINCT ' +  @tmpTable  +  '.* FROM (
		SELECT a.StyleID
		FROM dbo.pStyleSeasonYear a WITH(NOLOCK)
			INNER JOIN dbo.pStyleSeasonYear c WITH(NOLOCK) ON a.StyleID =  c.StyleID
		WHERE a.SeasonYearID = ''' + CAST(@SeasonYearID AS NVARCHAR(40))  + ''' 
		GROUP BY a.StyleID 
		HAVING COUNT(*)  = 1
	) AS foo
		LEFT OUTER JOIN ' + @BatchQueueJobTable + '  c ON foo.StyleID = c.StyleID
		INNER JOIN ' + @tmpTable + '  ON '  + @tmpTable + '.StyleID =  foo.StyleID
	WHERE c.StyleID IS NULL 

	'



	IF @Where IS NOT NULL 
		SET @SQL = @SQL + ' AND ' +  @Where
		
		
	--** Get user id, check access
	DECLARE @TeamID UNIQUEIDENTIFIER
	SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
	IF @TeamID IS NOT NULL
	BEGIN
		SET @SQL = @SQL + ' AND StyleType IN (SELECT StyleTypeID FROM sAccessStyleFolder WHERE ( AccessRoleId =3 OR AccessModify = 1 )  
		AND TeamId = ''' + CAST(@TeamID AS NVARCHAR(40)) + ''' ) '
	END 


END 


IF @ReturnSQLString  = 0 
	EXEC sp_executesql @SQL 
ELSE 
	SELECT @SQL AS sqlString




GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterials_Review_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterials_Review_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterials_Review_SELECT](
	@BatchQueuePagePkName VARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable VARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MaterialID  UNIQUEIDENTIFIER


--** Get MaterialID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT



IF @MaterialID IS NOT NULL 
BEGIN 

	--** Get Styles 
	CREATE TABLE  #style(
		StyleID UNIQUEIDENTIFIER
	)

	SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
	FROM pBatchQueueJobItem WITH(NOLOCK)
	WHERE BatchQueueJobId = @BatchQueueJobId
		AND BatchQueueJobSeq = 3

	SET @sySQL = 'INSERT INTO #style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
	EXECUTE sp_executesql @sySQL


	--** Remove styles not selected
	DELETE FROM pBatchQueueStyleMaterialTmp
	WHERE BatchQueueJobId = @BatchQueueJobId
	AND StyleID NOT IN  ( SELECT StyleID FROM #style)

	--** Add styles selected
	INSERT INTO  pBatchQueueStyleMaterialTmp
	( StyleMaterialID , BatchQueueJobId, StyleID, MaterialID, Colorway ) 
	SELECT NEWID(), @BatchQueueJobId, StyleID, @MaterialID,  1   
	FROM #style 
	WHERE StyleID NOT IN (
		SELECT StyleID FROM pBatchQueueStyleMaterialTmp WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
	) 	

	DROP TABLE #style

	SELECT a.*, b.StyleNo, b.Description , b.CustomField14
	FROM pBatchQueueStyleMaterialTmp a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID


END
ELSE 
	SELECT a.*, b.StyleNo, b.Description , b.CustomField14
	FROM pBatchQueueStyleMaterialTmp a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID 
	WHERE 1 = 2 


GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'TF'))
	DROP FUNCTION [dbo].[Split]
GO

CREATE FUNCTION dbo.Split(@String varchar(8000), @Delimiter char(1))       
returns @temptable TABLE (items varchar(8000))       
as       
begin       
    declare @idx int       
    declare @slice varchar(8000)       

    select @idx = 1       
        if len(@String)<1 or @String is null  return       

    while @idx!= 0       
    begin       
        set @idx = charindex(@Delimiter,@String)       
        if @idx!=0       
            set @slice = left(@String,@idx - 1)       
        else       
            set @slice = @String       

        if(len(@slice)>0)  
            insert into @temptable(Items) values(@slice)       

        set @String = right(@String,len(@String) - @idx)       
        if len(@String) = 0 break       
    end   
return       
end  
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialColors_Review_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialColors_Review_SELECT]

GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialColors_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@syBatchQueueJobTable  NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MaterialID  UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@BatchQueueID UNIQUEIDENTIFIER,
	@MaterialColorID UNIQUEIDENTIFIER
	

SELECT @BatchQueueID = BatchQueueID 
FROM pBatchQueueJob
WHERE BatchQueueJobID = @BatchQueueJobID

--** Get SeasonYearID
SELECT @syBatchQueueJobTable = BatchQueueJobTable
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 1

SET @sySQL = 'SELECT  @pSeasonYearID = SeasonYearID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pSeasonYearID = @SeasonYearID OUTPUT


--** Get MaterialID
SELECT @syBatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 2

SET @sySQL = 'SELECT  @pMaterialID = MaterialID FROM ' + @syBatchQueueJobTable + 
	' WITH(NOLOCK) WHERE BatchQueueJobId = '''  + CAST(@BatchQueueJobId  AS NVARCHAR(40)) + ''' '
SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
EXECUTE	sp_executesql @sySQL, @ParmDefinition,
	@pMaterialID = @MaterialID OUTPUT



IF @BatchQueueID = '90000000-0000-0000-0000-000000000003'
BEGIN 


	IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL 
	BEGIN 

		--** Get Styles 
		CREATE TABLE  #style(
			StyleID UNIQUEIDENTIFIER
		)

		SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
		FROM pBatchQueueJobItem WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
			AND BatchQueueJobSeq = 3


		SET @sySQL = 'INSERT INTO #style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
		EXECUTE sp_executesql @sySQL


		CREATE TABLE #color (
			ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
			ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
		)
		
		--** Get all styleColors
		
		INSERT INTO #color (ColorCode, ColorName)
		SELECT DISTINCT d.ColorCode, d.ColorName
		FROM #style a
			INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
			INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
			INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
			INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
		WHERE c.SeasonYearID = @SeasonYearID
			AND LEN(ISNULL(d.ColorCode,'') ) > 0 
			AND LEN(ISNULL(d.ColorName,'')) > 0


		DROP TABLE  #style


		--** Remove colors
		DELETE FROM pBatchQueueStyleMaterialColorTmp
		WHERE BatchQueueJobId = @BatchQueueJobId
		AND ColorCode + '//' + ColorName NOT IN  ( 
			SELECT ColorCode + '//' + ColorName FROM #color
		)

		--** Add colors
		INSERT INTO  pBatchQueueStyleMaterialColorTmp
		( StyleMaterialColorID , BatchQueueJobId, ColorCode, ColorName) 
		SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
		FROM #color
		WHERE ColorCode  + '//' + ColorName NOT IN (
			SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
			WHERE BatchQueueJobId = @BatchQueueJobId
		) 	

		DROP TABLE #color
		
		
		--** Check if there is onlyl 1 color available
		IF ( SELECT COUNT(*) FROM dbo.pMaterialColorSeasonYear 
		WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  ) = 1
		BEGIN
		
			SET @MaterialColorID = NULL
			
			SELECT @MaterialColorID = MaterialColorID 
			FROM dbo.pMaterialColorSeasonYear WITH(NOLOCK)
			WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  
		
			UPDATE pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = @MaterialColorID, Reviewed = 1
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND ISNULL(Reviewed,0) = 0 
	
		END
		ELSE 
			--** Default color pitching
			UPDATE dbo.pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = e.MaterialColorID
			FROM pBatchQueueStyleMaterialColorTmp a
				INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
				INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
					AND e.MaterialID = @MaterialID
				INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
					AND b.SeasonyearID = @SeasonyearID 
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND a.MaterialColorID IS NULL
				AND ISNULL(a.Reviewed,0) = 0
		
		
		SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE a.BatchQueueJobID = @BatchQueueJobID


	END
	ELSE 
		SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE 1 = 2 

END 
ELSE
BEGIN


	IF @SeasonYearID IS NOT NULL AND @MaterialID IS NOT NULL 
	BEGIN 

		--** Get Styles 
		CREATE TABLE  #tm890style(
			StyleID UNIQUEIDENTIFIER
		)

		SELECT @syBatchQueueJobTable =  BatchQueueJobTable  
		FROM pBatchQueueJobItem WITH(NOLOCK)
		WHERE BatchQueueJobId = @BatchQueueJobId
			AND BatchQueueJobSeq = 3


		SET @sySQL = 'INSERT INTO #tm890style (StyleID) SELECT StyleID  FROM ' + @syBatchQueueJobTable 
		EXECUTE sp_executesql @sySQL


		CREATE TABLE #tmp263color (
			ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS ,
			ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS 
		)
		
		--** Get all styleColors
		
		INSERT INTO #tmp263color (ColorCode, ColorName)
		SELECT DISTINCT d.ColorCode, d.ColorName
		FROM #tm890style a
			INNER JOIN dbo.pStyleColorwaySeasonYear b ON a.StyleID = b.StyleID 
			INNER JOIN dbo.pStyleSeasonYear c ON b.StyleSeasonYearID = c.StyleSeasonYearID 
			INNER JOIN dbo.pStyleColorway e ON e.StyleColorID =  b.StyleColorwayID
			INNER JOIN dbo.pColorPalette d ON d.ColorPaletteID = e.ColorPaletteID
		WHERE c.SeasonYearID = @SeasonYearID
			AND LEN(ISNULL(d.ColorCode,'') ) > 0 
			AND LEN(ISNULL(d.ColorName,'')) > 0


		DROP TABLE  #tm890style


		--** Remove colors
		DELETE FROM pBatchQueueStyleMaterialColorTmp
		WHERE BatchQueueJobId = @BatchQueueJobId
		AND ColorCode + '//' + ColorName NOT IN  ( 
			SELECT ColorCode + '//' + ColorName FROM #tmp263color
		)

		--** Add colors
		INSERT INTO  pBatchQueueStyleMaterialColorTmp
		( StyleMaterialColorID , BatchQueueJobId, ColorCode, ColorName) 
		SELECT NEWID(), @BatchQueueJobId, ColorCode, ColorName
		FROM #tmp263color
		WHERE ColorCode  + '//' + ColorName NOT IN (
			SELECT ColorCode + '//' +  ColorName  FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
			WHERE BatchQueueJobId = @BatchQueueJobId
		) 	

		DROP TABLE #tmp263color
		
		
		--** Check if there is onlyl 1 color available
		IF ( SELECT COUNT(*) FROM dbo.pMaterialColorSeasonYear 
		WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  ) = 1
		BEGIN
		
			SET @MaterialColorID = NULL
			
			SELECT @MaterialColorID = MaterialColorID 
			FROM dbo.pMaterialColorSeasonYear WITH(NOLOCK)
			WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID  
		
			UPDATE pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = @MaterialColorID, Reviewed = 1
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND ISNULL(Reviewed,0) = 0 
	
		END
		ELSE 
			--** Default color pitching
			UPDATE dbo.pBatchQueueStyleMaterialColorTmp
			SET MaterialColorID = e.MaterialColorID
			FROM pBatchQueueStyleMaterialColorTmp a
				INNER JOIN dbo.pColorPalette c ON c.ColorCode = a.ColorCode 
				INNER JOIN pMaterialcolor e ON e.ColorPaletteID =  c.ColorPaletteID 
					AND e.MaterialID = @MaterialID
				INNER JOIN dbo.pMaterialColorSeasonYear b ON b.MaterialColorID = e.MaterialColorID
					AND b.SeasonyearID = @SeasonyearID 
			WHERE BatchQueueJobId = @BatchQueueJobId
				AND a.MaterialColorID IS NULL
				AND ISNULL(a.Reviewed,0) = 0
		
		
		SELECT a.*, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE a.BatchQueueJobID = @BatchQueueJobID		
			

	END
	ELSE 
		SELECT a.*, NULL AS StyleNo, @SeasonYearID AS  SeasonYearID, @MaterialID  AS MaterialID
		FROM pBatchQueueStyleMaterialColorTmp a WITH(NOLOCK)
		WHERE 1 = 2 


END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_AddStyleMaterial_EXECUTE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQJob_AddStyleMaterial_EXECUTE]

GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_AddStyleMaterial_EXECUTE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS

DECLARE @BatchQueueID UNIQUEIDENTIFIER
SELECT @BatchQueueID = BatchQueueID FROM pBatchQueueJob WITH(NOLOCK) WHERE BatchQueueJobID  = @BatchQueueJobID 

UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '10000000-0000-0000-0000-000000000000'
WHERE BatchQueueJobID  = @BatchQueueJobID 



--** Insert job to the service queue
DECLARE 
	@ServiceDate DATETIME,
	@pBatchQueueJobID NVARCHAR(70),
	@pMDate NVARCHAR(100)
	
SET @ServiceDate = getdate()
SET @pBatchQueueJobID = ' @BatchQueueJobID = ''' +  CAST (@BatchQueueJobID AS NVARCHAR(50)) + ''' '
SET @pMDate = ' @MDate = ''' +  CONVERT( NVARCHAR(40) , @MDate  , 20 ) + ''' '

DECLARE @ServiceQueueSql1 nvarchar(4000)
SET @ServiceQueueSql1 = 'dbo.spx_BatchQJob_AddStyleMaterial_EXECUTE_QUEUE ' + 
@pBatchQueueJobID  + ',' + 
@pMDate 

exec spx_ServiceQueue_INSERT @ServiceQueueSql = @ServiceQueueSql1, @ServiceQueuePriority = 1, @ServiceQueueDate = @ServiceDate


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_AddStyleMaterial_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQJob_AddStyleMaterial_EXECUTE_QUEUE]
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_AddStyleMaterial_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS

DECLARE 
	@error INT,
	@syBatchQueueJobTable NVARCHAR(200),
	@sySQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@MainMaterial INT
	
	
SET @error = 0 



BEGIN TRAN 

	BEGIN TRY 

		DECLARE 
			@MUser NVARCHAR(200),
			@NewStyleMaterialID UNIQUEIDENTIFIER,
			@StyleID UNIQUEIDENTIFIER,
			@MaterialID UNIQUEIDENTIFIER,
			@ROWID INT,
			@TOTAL INT,
			@TeamID  UNIQUEIDENTIFIER
		

		SELECT @MUser = ISNULL(b.UserName,'') + ' '  +  ISNULL(b.LastName,''),
			@TeamID = b.TeamID
		FROM dbo.pBatchQueueJob a
			INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID = b.TeamID
		WHERE BatchQueueJobID = @BatchQueueJobID

		CREATE TABLE #bq_sm(
			ROWID INT IDENTITY(1,1),
			StyleMaterialID UNIQUEIDENTIFIER
		)


		INSERT INTO #bq_sm(StyleMaterialID)
		SELECT StyleMaterialID 
		FROM dbo.pBatchQueueStyleMaterialTmp WITH(NOLOCK)
		WHERE BatchQueueJobID = @BatchQueueJobID


		SELECT @TOTAL = COUNT(*) FROM #bq_sm 
		SET @ROWID = 1 

		WHILE @ROWID <=  @TOTAL
		BEGIN

		
			SELECT @NewStyleMaterialID = StyleMaterialID FROM #bq_sm
			WHERE ROWID =  @ROWID
			
			SELECT @StyleID = StyleID, @MaterialID = MaterialID
			FROM pBatchQueueStyleMaterialTmp WITH(NOLOCK)
			WHERE StyleMaterialID = @NewStyleMaterialID
			
			
			EXEC spx_StyleMaterialTemp_INSERT 
				@MainMaterial =  0, 
				@StyleID = @StyleID, 
				@StyleMaterialID  = @NewStyleMaterialID, 
				@StyleSet = 1, 
				@MaterialID = @MaterialID, 
				@CreatedBy = @MUser, 
				@CreatedDate = @MDate,
				@TradePartnerVendorID = NULL
			
			-- Values from batch table	
			UPDATE pStyleMaterialTemp  
			SET
				Qty =  b.Qty,
				MaterialSizeID = b.MaterialSizeID,
				Artwork = ISNULL(b.Artwork,0),
				Colorway =  ISNULL(b.Colorway,0),
				Placement = b.Placement,
				BatchQJobID = @BatchQueueJobID
			FROM pStyleMaterialTemp a	
				INNER JOIN pBatchQueueStyleMaterialTmp b ON a.StyleMaterialID = b.StyleMaterialID 
			WHERE b.StyleMaterialID = @NewStyleMaterialID
			

			EXECUTE spx_StyleMaterialPending_Linked_INSERT 
				@StyleMaterialID = @NewStyleMaterialID,    
				@StyleID = @StyleID, 
				@StyleSet = 1, 
				@CreatedDate = @MDate, 
				@CreatedBy = @MUser,
				@ChangeTransID =NULL,
				@ChangeTransUserID  = NULL

			SET @ROWID = @ROWID + 1 
		END 

		DROP TABLE #bq_sm


		--** UpdateColorways

		CREATE TABLE #sm2(
			ROWID INT IDENTITY(1,1),
			StyleMaterialID UNIQUEIDENTIFIER,
			MainMaterial INT
		)
		
		INSERT INTO #sm2(StyleMaterialID, MainMaterial)
		SELECT StyleMaterialID, MainMaterial
		FROM dbo.pStyleMaterials WITH(NOLOCK) 
		WHERE BatchQJobID = @BatchQueueJobID
		
		DECLARE 
			@ColorRowID INT ,
			@ColorTotal INT ,
			@MaterialColorID UNIQUEIDENTIFIER,
			@ColorName  NVARCHAR(200),
			@ColorCode  NVARCHAR(200)

			
		CREATE TABLE #bq_color(
			ROWID INT IDENTITY(1,1),
			ColorCode NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
			ColorName NVARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
			MaterialColorID UNIQUEIDENTIFIER
		)



		INSERT INTO #bq_color(ColorCode, ColorName, MaterialColorID)
		SELECT ColorCode, ColorName, MaterialColorID
		FROM pBatchQueueStyleMaterialColorTmp WITH(NOLOCK)
		WHERE BatchQueueJobID = @BatchQueueJobID
			AND MaterialColorID IS NOT NULL 


		SELECT @TOTAL = COUNT(*) FROM #sm2 
		SELECT @ColorTotal  =  COUNT(*) FROM #bq_color
		SET @ROWID = 1 

		WHILE @ROWID <= @TOTAL
		BEGIN 
			SELECT @NewStyleMaterialID = StyleMaterialID , @MainMaterial = MainMaterial
			FROM #sm2 WHERE ROWID = @ROWID
			
			SET @ColorRowID = 1 
			
			WHILE @ColorRowID <= @ColorTotal 
			BEGIN
				SELECT @MaterialColorID = MaterialColorID, @ColorCode = ColorCode,
					@ColorName = ColorName 
				FROM #bq_color WHERE ROWID = @ColorRowID
			
				UPDATE pStyleColorwayItem 
				SET MaterialColorID = @MaterialColorID
				FROM pStyleColorwayItem a
					INNER JOIN dbo.pStyleColorway b ON a.StyleColorID = b.StyleColorID	
					INNER JOIN dbo.pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
				WHERE StyleMaterialID  = @NewStyleMaterialID
					AND ISNULL(c.ColorCode,'') = @ColorCode
					AND ISNULL(c.ColorName,'') = @ColorName
					
				SET @ColorRowID = @ColorRowID  + 1 
			END  -- While Colors
			
			SET @ROWID = @ROWID + 1 
		END		

		--** Call StyleMaterials Logic Update 
		CREATE TABLE #bq_addM98936(
			ROWID INT IDENTITY(1,1),
			StyleID UNIQUEIDENTIFIER
		)
		
		INSERT INTO #bq_addM98936(StyleID)
		SELECT DISTINCT StyleID 
		FROM dbo.pStyleMaterials WITH(NOLOCK) 
		WHERE BatchQJobID = @BatchQueueJobID		
		
		SET @ROWID = 1 
		SELECT @TOTAL = COUNT(*) FROM #bq_addM98936
		
		WHILE @ROWID <= @TOTAL
		BEGIN 
			SELECT @StyleID = StyleID FROM #bq_addM98936 WHERE ROWID = @ROWID
		
			EXECUTE spx_StyleMaterialLogic_UPDATE 
				@StyleID = @StyleID,
				@StyleSet = '1',
				@MDate = @MDate,
				@MUser = @MUser
				
			SET @ROWID = @ROWID + 1 
		END 
		

		DROP TABLE #sm2
		DROP TABLE #bq_color
		DROP TABLE #bq_addM98936

END TRY
BEGIN CATCH 
	set @error = 1 
END CATCH 

IF @error = 0
BEGIN
	COMMIT TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID

END
ELSE	
BEGIN
	ROLLBACK TRAN
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '30000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID
	
END


go


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02024'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02024', GetDate())

END	  
GO