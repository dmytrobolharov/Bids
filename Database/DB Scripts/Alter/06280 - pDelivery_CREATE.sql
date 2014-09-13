IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'DF_pDelivery_DeliveryID') AND type = 'D')
ALTER TABLE dbo.pDelivery DROP CONSTRAINT DF_pDelivery_DeliveryID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.pDelivery') AND type in (N'U'))
DROP TABLE dbo.pDelivery
GO

CREATE TABLE dbo.pDelivery (
	DeliveryID UNIQUEIDENTIFIER NOT NULL
	, DeliveryCode NVARCHAR(10) NULL
	, DeliveryName NVARCHAR(200) NULL
	, DeliverySort NVARCHAR(5) NULL
	, Active INT NULL
	, CUser NVARCHAR(200) NULL
	, CDate DATETIME NULL
	, MUser NVARCHAR(200) NULL
	, MDate DATETIME NULL
	, CONSTRAINT PK_pDelivery PRIMARY KEY CLUSTERED (DeliveryID ASC) WITH (
		PAD_INDEX = OFF
		, STATISTICS_NORECOMPUTE = OFF
		, IGNORE_DUP_KEY = OFF
		, ALLOW_ROW_LOCKS = ON
		, ALLOW_PAGE_LOCKS = ON
		) ON [PRIMARY]
	) ON [PRIMARY]

GO

ALTER TABLE dbo.pDelivery ADD CONSTRAINT DF_pDelivery_DeliveryID DEFAULT (NEWID()) FOR DeliveryID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06280', GetDate())
GO
