IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[xCustom100]') AND type = N'U')
	DROP TABLE dbo.xCustom100
GO

CREATE TABLE [dbo].[xCustom100](
	[CustomID] [int] NOT NULL,
	[Custom] [nvarchar](200) NULL,
 CONSTRAINT [PK_xCustom100] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



INSERT INTO xCustom100(CustomID,  Custom)
VALUES ( 1 , 'Factory' )


INSERT INTO xCustom100(CustomID, Custom)
VALUES ( 2, 'Laboratory' )

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestGCCWorkflow]') AND type = N'U')
	DROP TABLE dbo.pSampleRequestGCCWorkflow
GO

CREATE TABLE [dbo].[pSampleRequestGCCWorkflow](
	[SampleRequestGCCWorkflowID] [uniqueidentifier] NOT NULL,
	[SampleRequestSubmitID] [uniqueidentifier] NULL,
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
	[SampleRequestSubmitVendorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSampleRequestTestingWorkflow] PRIMARY KEY CLUSTERED 
(
	[SampleRequestGCCWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pSampleRequestGCCWorkflow] ADD  CONSTRAINT [DF_pSampleRequestTestingWorkflow_SampleRequestGCCWorkflowID]  DEFAULT (newid()) FOR [SampleRequestGCCWorkflowID]
GO





	
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SampleRequestSubmitGroupSearch')
	ALTER TABLE dbo.pStyleDetailGridControl ADD SampleRequestSubmitGroupSearch NVARCHAR(200)
GO 
	
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SampleRequestSubmitGroupDefault')
	ALTER TABLE dbo.pStyleDetailGridControl ADD SampleRequestSubmitGroupDefault NVARCHAR(200)
GO 


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleWorkflow'
    AND  COLUMN_NAME = 'AllowCustomGrid')
	ALTER TABLE dbo.pSampleWorkflow DROP COLUMN AllowCustomGrid 
GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleRequestGCCWorkflow'
    AND  COLUMN_NAME = 'SampleRequestSubmitVendorID')
	ALTER TABLE dbo.pSampleRequestGCCWorkflow ADD SampleRequestSubmitVendorID UNIQUEIDENTIFIER
GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'uTradePartnerVendor'
    AND  COLUMN_NAME = 'Laboratory')
	ALTER TABLE dbo.uTradePartnerVendor ADD Laboratory INT 
GO 


IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SPXSampleRequestSubmitGroupInsert')
	ALTER TABLE pStyleDetailGridControl ADD SPXSampleRequestSubmitGroupInsert  NVARCHAR(200)
GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailGridControl'
    AND  COLUMN_NAME = 'SampleRequestSubmitGroupXML')
	ALTER TABLE pStyleDetailGridControl ADD SampleRequestSubmitGroupXML NVARCHAR(200)
GO 

UPDATE pStyleDetailGridControl SET 
	SampleRequestSubmitGroupSearch = 'SampleRequestSubmitItem_M_20A_VendorSearch.xml',
	SampleRequestSubmitGroupDefault = 'SampleRequestSubmitItem_M_20A_VendorDefault.xml',
	SPXSampleRequestSubmitGroupInsert = 'spx_SampleWorkflowSubmitVendors_INSERT',
	SampleRequestSubmitGroupXML = 'SampleRequestSubmitItem_M_20A_VendorHeader.xml'
WHERE WorkflowID = '90000000-0000-0000-0000-000000000A20'

UPDATE pSampleWorkflow SET Active ='yes', GroupID = 'X' WHERE  SampleWorkflowID = '20A'


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitVendor]') AND type = N'U')
	DROP TABLE dbo.pSampleRequestSubmitVendor
GO

CREATE TABLE [dbo].[pSampleRequestSubmitVendor](
	[SampleRequestSubmitVendorID] [uniqueidentifier] NOT NULL,
	[SampleRequestSubmitID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[VendorType] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pSampleRequestSubmitVendor] PRIMARY KEY CLUSTERED 
(
	[SampleRequestSubmitVendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestSubmitVendor] ADD  CONSTRAINT [DF_pSampleRequestSubmitVendor_SampleRequestSubmitVendorID]  DEFAULT (newid()) FOR [SampleRequestSubmitVendorID]
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


SELECT a.*, b.SummaryXML, b.EditXML, b.MaterialXML,	@LastSubmit AS LastSubmit
FROM pSampleRequestSubmit a WITH(NOLOCK)
	INNER JOIN pSampleRequestWorkflowStatusSchema b WITH(NOLOCK) ON b.SampleWorkflowID = a.SampleWorkflowID AND b.StatusID = a.Status
	INNER JOIN dbo.pSampleWorkflow c WITH(NOLOCK) ON C.SampleWorkflowID = a.SampleWorkflowID
WHERE a.SampleRequestTradeID  = @SampleRequestTradeID
	AND a.SampleWorkflowID = @SampleWorkflowID
	AND a.Submit = @Submit 
	
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowSchema_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowSchema_SELECT]
GO

CREATE PROCEDURE dbo.spx_SampleRequestWorkflowSchema_SELECT(
	@SampleRequestWorkflowID UNIQUEIDENTIFIER
)
AS 


SELECT TOP 1 b.Submit, b.SampleRequestSubmitID, d.MaterialXML
FROM pSampleRequestWorkflow a
	INNER JOIN dbo.pSampleRequestSubmit b ON a.SampleRequestWorkflowID   = b.SampleRequestWorkflowID
	INNER JOIN dbo.pSampleWorkflow c ON c.SampleWorkflowID = b.SampleWorkflowID
	INNER JOIN pSampleRequestWorkflowStatusSchema d  ON d.StatusID = b.Status 
		AND d.SampleWorkflowID = c.SampleWorkflowID
WHERE a.SampleRequestWorkflowID = @SampleRequestWorkflowID
ORDER BY b.Submit desc


GO




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitVendors_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].spx_SampleWorkflowSubmitVendors_SELECT
GO

CREATE PROCEDURE dbo.spx_SampleWorkflowSubmitVendors_SELECT(
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS


	SELECT a.SampleRequestSubmitVendorID, 
		CASE
			WHEN  LEN(ISNULL(a.VendorType,'')) = 0 THEN  'Lab-' + b.VendorName
			ELSE a.VendorType + '-' + b.VendorName
		END AS VendorName
	FROM pSampleRequestSubmitVendor a
		INNER JOIN dbo.uTradePartnerVendor b ON a.TradePartnerVendorID = b.TradePartnerVendorID
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	ORDER BY a.VendorType

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

SELECT TOP 1  b.ControlPanelSchema AS SchemaGridDefault, a.ControlPanelItemSchema AS SchemaTemplateItemGrid,
	a.SampleRequestSubmitGroupSearch, a.SampleRequestSubmitGroupDefault, a.SPXSampleRequestSubmitGroupInsert,
	a.SampleRequestSubmitGroupXML
FROM pStyleDetailGridControl a
	INNER JOIN dbo.pControlPanel b ON a.ControlPanelID =  b.ControlPanelID
WHERE a.SampleWorkflowID  = @SampleWorkflowID 


GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitGCCWorkflow_Vendor_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SampleRequestSubmitGCCWorkflow_Vendor_SEL]
GO

CREATE VIEW dbo.vwx_SampleRequestSubmitGCCWorkflow_Vendor_SEL
AS

	SELECT TradePartnerVendorID, b.Custom AS VendorType , VendorName, VendorCode  
	FROM dbo.uTradePartnerVendor a
		INNER JOIN dbo.xCustom100 b  ON a.Laboratory = b.CustomID


GO 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitVendors_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.spx_SampleWorkflowSubmitVendors_INSERT
GO

CREATE PROCEDURE dbo.spx_SampleWorkflowSubmitVendors_INSERT(
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@ItemID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@Where NVARCHAR(MAX)
)
AS


IF NOT EXISTS( SELECT * FROM pSampleRequestSubmitVendor WHERE SampleRequestSubmitID =  @SampleRequestSubmitID
	AND TradePartnerVendorID = @ItemID) 
BEGIN

	DECLARE @VendorType NVARCHAR(200)
	
	SELECT @VendorType = b.Custom
	FROM dbo.uTradePartnerVendor a 
		INNER JOIN dbo.xCustom100 b ON a.Laboratory = b.CustomID
	WHERE TradePartnerVendorID = @ItemID

	INSERT INTO pSampleRequestSubmitVendor (SampleRequestSubmitVendorID , SampleRequestSubmitID,
		TradePartnerVendorID, VendorType, CUser, CDate ) 
	VALUES ( NEWID(), @SampleRequestSubmitID,
		@ItemID, @VendorType , @CUser, @CDate )
		
END 

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplate_INSERT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.spx_SampleRequestMaterialTemplate_INSERT
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestMaterialTemplate_INSERT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@SampleRequestSubmitGroupID UNIQUEIDENTIFIER,
	@TemplateID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER
)
AS 

INSERT INTO pSampleRequestGCCWorkflow (
	SampleRequestGCCWorkflowID, SampleRequestSubmitID, SampleRequestSubmitVendorID ,
	Custom1, Custom2,
	Custom3, Custom4,
	Custom5, Custom6) 

SELECT NEWID() AS SampleRequestGCCWorkflowID, @SampleRequestSubmitID, @SampleRequestSubmitGroupID,
	TemplateDetailCustom1, TemplateDetailCustom2,
	TemplateDetailCustom3, TemplateDetailCustom4,
	TemplateDetailCustom5, TemplateDetailCustom6
FROM pSampleGCCTemplateItem
WHERE TemplateDetailGridID = @TemplateID


go


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestMaterialTemplateItem_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.spx_SampleRequestMaterialTemplateItem_SELECT
GO

CREATE procedure [dbo].[spx_SampleRequestMaterialTemplateItem_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@SampleRequestSubmitGroupID UNIQUEIDENTIFIER
)
AS 

	SELECT * 
	FROM pSampleRequestGCCWorkflow WITH(NOLOCK)
	WHERE SampleRequestSubmitID =  @SampleRequestSubmitID 
		AND SampleRequestSubmitVendorID = @SampleRequestSubmitGroupID


GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitGCC_VendorHeader_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SampleRequestSubmitGCC_VendorHeader_SEL]
GO


CREATE VIEW dbo.vwx_SampleRequestSubmitGCC_VendorHeader_SEL
AS 

SELECT a.SampleRequestSubmitVendorID AS SampleRequestSubmitGroupID,  b.*
FROM dbo.pSampleRequestSubmitVendor a
	INNER JOIN dbo.uTradePartnerVendor b ON a.TradePartnerVendorID =  b.TradePartnerVendorID 


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02002'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02002', GetDate())     

END	  
GO  
