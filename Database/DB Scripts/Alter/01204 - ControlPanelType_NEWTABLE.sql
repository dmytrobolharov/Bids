IF NOT EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'pControlPanel' and COLUMN_NAME = N'ControlPanelTypeID')
BEGIN
    ALTER TABLE pControlPanel ADD ControlPanelTypeID uniqueidentifier NULL
END
GO


CREATE TABLE [dbo].[pControlPanelType](
	[ControlPanelTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ControlPanelTypeName] [nvarchar](200) NULL,
	[ControlPanelTypeDescription] [nvarchar](4000) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Sort] [varchar](5) NULL,
 CONSTRAINT [PK_pControlPanelType] PRIMARY KEY CLUSTERED 
(
	[ControlPanelTypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pControlPanelType] ADD  CONSTRAINT [DF_pControlPanelType_ControlPanelTypeID]  DEFAULT (newsequentialid()) FOR [ControlPanelTypeID]
GO

ALTER TABLE [dbo].[pControlPanelType] ADD  CONSTRAINT [DF_pControlPanelType_Active]  DEFAULT ((1)) FOR [Active]
GO

GO



IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_ControlPanelType_DELETE') 
DROP PROCEDURE spx_ControlPanelType_DELETE
GO

CREATE PROCEDURE [dbo].[spx_ControlPanelType_DELETE]
(
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@ControlPanelTypeID uniqueidentifier
)

AS 

UPDATE pControlPanel SET ControlPanelTypeID = NULL WHERE ControlPanelTypeID = @ControlPanelTypeID
DELETE pControlPanelType WHERE ControlPanelTypeID = @ControlPanelTypeID
	
GO


IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_ControlPanelType_INSERT') 
DROP PROCEDURE spx_ControlPanelType_INSERT
GO

CREATE PROCEDURE [dbo].[spx_ControlPanelType_INSERT]
(
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@NoRow int
)

AS 

declare @Rows int 
SET @Rows = @NoRow
WHILE @Rows > 0 
BEGIN
	INSERT INTO pControlPanelType (CUser, CDate) VALUES (@CreatedBy, @CreatedDate)
    SET @Rows = @Rows -1
END

	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01204', GetDate())
GO
