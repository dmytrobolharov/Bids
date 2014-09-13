IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRemovalReason]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialRemovalReason]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pMaterialRemovalReason](
	[RemovalReasonID] [uniqueidentifier] NOT NULL,
	[RemovalReasonCode] [int] NULL,
	[RemovalReason] [nvarchar](500) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pMaterialRemovalReason] PRIMARY KEY CLUSTERED 
(
	[RemovalReasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO pMaterialRemovalReason VALUES( NEWID(), 2, 'Customer Cancel', NULL, NULL, NULL, NULL, 1)
INSERT INTO pMaterialRemovalReason VALUES( NEWID(), 1, 'Internal Cancel', NULL, NULL, NULL, NULL, 1)
INSERT INTO pMaterialRemovalReason VALUES( NEWID(), 3, 'Duplicate Material', NULL, NULL, NULL, NULL, 1)
INSERT INTO pMaterialRemovalReason VALUES( NEWID(), 4, 'Other', NULL, NULL, NULL, NULL, 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07967', GetDate())
GO