IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SampleWorkflowID')
	ALTER TABLE pStyleDetailGridControl ADD SampleWorkflowID NVARCHAR(5)

GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SPXSampleRequestMaterialTemplateInsert')
	ALTER TABLE pStyleDetailGridControl ADD SPXSampleRequestMaterialTemplateInsert NVARCHAR(200)

GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SPXSampleRequestMaterialTempItemDelete')
	ALTER TABLE pStyleDetailGridControl ADD SPXSampleRequestMaterialTempItemDelete NVARCHAR(200)

GO 


IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleWorkflow'
    AND  COLUMN_NAME = 'AllowCustomGrid')
	ALTER TABLE dbo.pSampleWorkflow ADD AllowCustomGrid INT

GO 



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleGCCTemplateItem]') AND type = N'U')
	DROP TABLE [dbo].pSampleGCCTemplateItem
GO

CREATE TABLE [dbo].[pSampleGCCTemplateItem](
	[TemplateDetailGridItemID] [uniqueidentifier] NOT NULL,
	[TemplateDetailGridID] [uniqueidentifier] NULL,
	[TemplateDetailCustom1] [nvarchar](200) NULL,
	[TemplateDetailCustom2] [nvarchar](200) NULL,
	[TemplateDetailCustom3] [nvarchar](200) NULL,
	[TemplateDetailCustom4] [nvarchar](200) NULL,
	[TemplateDetailCustom5] [nvarchar](200) NULL,
	[TemplateDetailCustom6] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pSampleGCCTemplateItem] PRIMARY KEY CLUSTERED 
(
	[TemplateDetailGridItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestGCCWorkflow]') AND type = N'U')
	DROP TABLE [dbo].[pSampleRequestGCCWorkflow]
GO


CREATE TABLE [dbo].[pSampleRequestGCCWorkflow](
	[SampleRequestGCCWorkflowID] [uniqueidentifier] NOT NULL,
	[SampleRequestSubmitID] [uniqueidentifier] NULL,
	[SampleRequestSubmitVendorID] [uniqueidentifier] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] INT DEFAULT 0,
	[Custom6] [nvarchar](200) NULL,
	[Sort] [varchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSampleRequestTestingWorkflow] PRIMARY KEY CLUSTERED 
(
	[SampleRequestGCCWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleGCCTemplate]') AND type = N'U')
	DROP TABLE [dbo].[pSampleGCCTemplate]
GO

CREATE TABLE [dbo].[pSampleGCCTemplate](
	[TemplateDetailGridId] [uniqueidentifier] NOT NULL,
	[TemplateDetailGridName] [nvarchar](200) NULL,
	[TemplateDetailGridDescription] [nvarchar](4000) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Sort] [nvarchar](5) NULL,
	[Active] [int] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleGCCTemplateItem] ADD  CONSTRAINT [DF_pSampleGCCTemplateItem_TemplateDetailGridItemID]  DEFAULT (newid()) FOR [TemplateDetailGridItemID]
GO

ALTER TABLE [dbo].[pSampleRequestGCCWorkflow] ADD  CONSTRAINT [DF_pSampleRequestTestingWorkflow_SampleRequestGCCWorkflowID]  DEFAULT (newid()) FOR [SampleRequestGCCWorkflowID]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSchemaSubmit_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].spx_SampleRequestWorkflowSchemaSubmit_SELECT
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowSchemaSubmit_SELECT](
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@Submit INT
)
AS

DECLARE @LastSubmit INT 

SELECT @LastSubmit = ISNULL(MAX(Submit),0) 
FROM pSampleRequestSubmit WITH(NOLOCK)
WHERE SampleRequestTradeID  = @SampleRequestTradeID
AND SampleWorkflowID = @SampleWorkflowID


SELECT a.*, b.SummaryXML, b.EditXML, b.MaterialXML,	@LastSubmit AS LastSubmit, ISNULL(c.AllowCustomGrid,0) AS AllowCustomGrid
FROM pSampleRequestSubmit a WITH(NOLOCK)
	INNER JOIN pSampleRequestWorkflowStatusSchema b WITH(NOLOCK) ON b.SampleWorkflowID = a.SampleWorkflowID AND b.StatusID = a.Status
	INNER JOIN dbo.pSampleWorkflow c WITH(NOLOCK) ON C.SampleWorkflowID = a.SampleWorkflowID
WHERE a.SampleRequestTradeID  = @SampleRequestTradeID
	AND a.SampleWorkflowID = @SampleWorkflowID
	AND a.Submit = @Submit 
	
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateItem_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateItem_DELETE]
GO
CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateItem_DELETE](
	@ItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS 


	DELETE FROM pSampleRequestGCCWorkflow
	WHERE SampleRequestGCCWorkflowID = @ItemID
	 


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateItem_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateItem_SELECT]
GO

CREATE procedure [dbo].[spx_SampleRequestMaterialTemplateItem_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS 

	SELECT * FROM pSampleRequestGCCWorkflow
	WHERE SampleRequestSubmitID =  @SampleRequestSubmitID 



GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTempItem_DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTempItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTempItem_DELETE](
	@ItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@MDate DATETIME
)

AS 


	DELETE FROM pSampleRequestGCCWorkflow
	WHERE  SampleRequestGCCWorkflowID  = @ItemID

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplate_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)

AS 

DECLARE 
	@SampleWorkflowID  NVARCHAR(5),
	@ControlPanelID INT ,
	@ControlPanelTableName NVARCHAR(200),
	@SQL NVARCHAR(MAX)
	
	
SELECT @SampleWorkflowID  = a.SampleWorkflowID
FROM pSampleRequestSubmit a WITH(NOLOCK)
WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID

SELECT TOP 1  @ControlPanelID = b.ControlPanelID
FROM pStyleDetailGridControl a
	INNER JOIN dbo.pControlPanel b ON a.ControlPanelID =  b.ControlPanelID
WHERE a.SampleWorkflowID  = @SampleWorkflowID 


SELECT @ControlPanelTableName = ControlPanelTableName
FROM pControlPanel 
WHERE ControlPanelID = @ControlPanelID

SET @SQL = 'SELECT * FROM ' + @ControlPanelTableName 

EXEC sp_executesql @SQL

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplate_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_INSERT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@TemplateID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER
)
AS 


INSERT INTO pSampleRequestGCCWorkflow (
	SampleRequestGCCWorkflowID, SampleRequestSubmitID, 
	Custom1, Custom2,
	Custom3, Custom4,
	Custom5, Custom6) 

SELECT NEWID() AS SampleRequestGCCWorkflowID, @SampleRequestSubmitID, 
	TemplateDetailCustom1, TemplateDetailCustom2,
	TemplateDetailCustom3, TemplateDetailCustom4,
	TemplateDetailCustom5, TemplateDetailCustom6
FROM pSampleGCCTemplateItem
WHERE TemplateDetailGridID = @TemplateID



GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplateSchema_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@SampleWorkflowID  NVARCHAR(5)
	
SELECT @SampleWorkflowID  = a.SampleWorkflowID
FROM pSampleRequestSubmit a WITH(NOLOCK)
WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID


SELECT TOP 1  b.ControlPanelSchema AS SchemaGridDefault, a.ControlPanelItemSchema AS SchemaTemplateItemGrid
FROM pStyleDetailGridControl a
	INNER JOIN dbo.pControlPanel b ON a.ControlPanelID =  b.ControlPanelID
WHERE a.SampleWorkflowID  = @SampleWorkflowID 



GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleGCCTemplateItem_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleGCCTemplateItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleGCCTemplateItem_INSERT](
	@TemplateDetailGridID uniqueidentifier,
	@CreatedBy nvarchar(200),
	@CreatedDate datetime,
	@NoRow int
)
AS 

DECLARE @Max as INT 
DECLARE @Len AS INT 
DECLARE @Sort AS  NVARCHAR (4)

SELECT @Max = MAX (Cast(Sort AS INT  )) 
FROM pSampleGCCTemplateItem WITH (NOLOCK)  
WHERE TemplateDetailGridID = @TemplateDetailGridID

IF @Max IS NULL 
	SET @Max  = 1
ELSE
	SET @Max = @Max + 1 


declare @Rows int 
SET @Rows = @NoRow
WHILE @Rows > 0 
BEGIN

	SET @Len = LEN ( CAST ( @Max AS NVARCHAR ( 4 ) ) )  
	SELECT @Sort = REPLICATE ('0', 4 - @Len ) + CAST ( @Max AS NVARCHAR (  4 ) )

	INSERT INTO pSampleGCCTemplateItem  (TemplateDetailGridID, CUser, CDate, Sort ) 
	VALUES (@TemplateDetailGridID, @CreatedBy, @CreatedDate , @Sort )
	
	SET @Rows = @Rows -1
	SET @Max  = @Max  + 1 

END


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflow_MaterialGrid_Logic_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestWorkflow_MaterialGrid_Logic_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflow_MaterialGrid_Logic_SELECT](
	@SQL NVARCHAR(MAX),
	@SampleRequestSubmitID  UNIQUEIDENTIFIER
)
AS

--DECLARE @AllowCustomGrid INT 
--SELECT @AllowCustomGrid = ISNULL(AllowCustomGrid,0)
--FROM pSampleRequestSubmit a WITH(NOLOCK)
--	INNER	JOIN  dbo.pSampleWorkflow b WITH(NOLOCK) ON a.SampleWorkflowID =  b.SampleWorkflowID
--WHERE SampleRequestSubmitID  = 	@SampleRequestSubmitID 


EXECUTE sp_executesql  @SQL

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSchema_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSchema_SELECT]
GO

CREATE PROCEDURE dbo.spx_SampleRequestWorkflowSchema_SELECT(
	@SampleRequestWorkflowID UNIQUEIDENTIFIER
)
AS 


SELECT TOP 1 b.Submit, b.SampleRequestSubmitID, c.AllowCustomGrid, d.MaterialXML
FROM pSampleRequestWorkflow a
	INNER JOIN dbo.pSampleRequestSubmit b ON a.SampleRequestWorkflowID   = b.SampleRequestWorkflowID
	INNER JOIN dbo.pSampleWorkflow c ON c.SampleWorkflowID = b.SampleWorkflowID
	INNER JOIN pSampleRequestWorkflowStatusSchema d  ON d.StatusID = b.Status 
		AND d.SampleWorkflowID = c.SampleWorkflowID
WHERE a.SampleRequestWorkflowID = @SampleRequestWorkflowID
ORDER BY b.Submit desc


go


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestGCCWorkflow_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SampleRequestGCCWorkflow_SEL]
GO

CREATE VIEW [dbo].[vwx_SampleRequestGCCWorkflow_SEL]
AS 

	SELECT a.SampleRequestGCCWorkflowID, a.SampleRequestSubmitID, a.Custom1, a.Custom2, a.Custom3, a.Custom4, ISNULL(a.Custom5,0) AS Custom5,
		a.Custom6, a.Sort, a.MDate, a.MUser, a.CUser, a.CDate, a.SampleRequestSubmitVendorID,
		c.TradePartnerVendorID, b.Submit, b.SampleWorkflowID, b.SampleRequestTradeID
	FROM pSampleRequestGCCWorkflow a	
	INNER JOIN  pSampleRequestSubmit b ON a.SampleRequestSubmitID =  b.SampleRequestSubmitID
	INNER JOIN dbo.pSampleRequestTrade c ON c.SampleRequestTradeID =  b.SampleRequestTradeID


GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterial_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
AS

SELECT a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID, 
  b.MaterialNo  + ' - ' + b.MaterialName  as Material, a.Status, a.Submit,c.TradePartnerVendorID,
  a.StyleMaterialID, a.StyleColorID,a.StyleSourcingID, f.ColorCode, f.ColorName, g.StyleColorName as Colorway,
  a.MUser, a.MDate, b.MaterialImageID, b.MaterialImageVersion
FROM pSampleRequestMaterial a
	INNER JOIN pSampleRequestTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID
	INNER JOIN pMaterial b On a.MaterialID =  b.MaterialID 
	INNER JOIN pStyleColorwayItem d ON d.StyleMaterialID = a.StyleMaterialID and d.StyleColorID = a.StyleColorID
	INNER JOIN pStyleColorway g on g.StyleColorID =  d.StyleColorID 
	
	LEFT OUTER JOIN pMaterialColor  e ON e.MaterialColorID  =  d.MaterialColorID 
	LEFT OUTER JOIN pColorPalette f on f.ColorPaletteID =  e.ColorPaletteID


GO






UPDATE pSampleWorkflow SET Active ='yes', AllowCustomGrid = 1  WHERE  SampleWorkflowID = '20A'
UPDATE  pSampleRequestWorkflowStatusSchema SET MaterialXML = 'SampleRequestSubmitItem_M_20A_Comment.xml'  WHERE SampleWorkflowID = '20A'

DELETE FROM pControlPanel WHERE ControlPanelID = 100

INSERT INTO dbo.pControlPanel( 
	ControlPanelID ,ControlPanelName ,ControlPanelDescription ,ControlPanelOrder ,ControlPanelIdSchema ,ControlPanelSchema ,
    ControlPanelSearchSchema ,ControlPanelTableName ,ControlPanelUrl ,ControlPanelEditSchema ,SPXLogicInsert ,
    SPXLogicUpdate ,ControlPanelTypeID ,ControlPanelRepId)
VALUES(
	100, 'Sample GCC Template', 'Sample GCC', 100,	NULL, 'Control_SampleGCC_Default.xml', 
	'Control_SampleGCC_Search.xml','pSampleGCCTemplate', 'Control_DetailGrid_Custom_List.aspx?CPID=100', NULL, NULL,
	NULL, '4BF85575-3877-E011-8802-000C29807141', '565AD1F1-18B7-488B-8539-9004E3D617CA' )
	
DELETE FROM pStyleDetailGridControl WHERE ControlPanelID = 100

INSERT INTO [dbo].[pStyleDetailGridControl] (
	[StyleDetailGridControlID], [WorkflowID], [ControlPanelID], [SchemaFile], [SPXInsert], 
	[SPXTemplateInsert], [SPXCopyInsert], [SPXControlGridItemInsert], [ControlPanelItemSchema], [SampleWorkflowID], 
	[SPXSampleRequestMaterialTemplateInsert], [SPXSampleRequestMaterialTempItemDelete]) 
VALUES (
	'994e5033-25e2-4016-b47e-43cea6103b7a', '90000000-0000-0000-0000-000000000a20', 100, N'', N'spx_SampleGCCTemplate_INSERT', 
	N'', N'', N'spx_SampleGCCTemplateItem_INSERT', N'Control_SampleGCCItem_Default.xml', N'20A', 
	N'spx_SampleRequestMaterialTemplate_INSERT', N'spx_SampleRequestMaterialTempItem_DELETE')


GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[xCustom101]') AND type = N'U')
	DROP TABLE [dbo].xCustom101
GO

CREATE TABLE [dbo].[xCustom101](
	[CustomID] [int] NOT NULL,
	[Custom] [nvarchar](50) NULL,
 CONSTRAINT [PK_xCustom101] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO xCustom101 VALUES ( 0, '') 
INSERT INTO xCustom101 VALUES ( 1, 'Pass') 
INSERT INTO xCustom101 VALUES ( 2, 'Fail') 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02001'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02001', GetDate())     

END	  
  
GO