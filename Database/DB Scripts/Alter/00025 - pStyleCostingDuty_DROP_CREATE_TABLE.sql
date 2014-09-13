


/****** Object:  Table [dbo].[pStyleCostingDuty]    Script Date: 03/17/2010 01:50:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'pStyleCostingDuty') AND type in (N'U'))
DROP TABLE pStyleCostingDuty
GO

CREATE TABLE pStyleCostingDuty(
	[CustomID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pStyleCostingDuty_DutyId]  DEFAULT (newid()),
	[CustomKey] [nvarchar](5) NULL CONSTRAINT [DF_pStyleCostingDuty_CustomKey]  DEFAULT (N'IDENTITY(1,1)'),
	[DutyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pStyleCostingDuty_DutyId_1]  DEFAULT (newid()),
	[DutyFiber] [nvarchar](255) NULL,
	[DutyItem] [nvarchar](255) NULL,
	[DutyCategory] [nvarchar](255) NULL,
	[DutyPerc] [decimal](18, 3) NULL,
	[DutySurcharge] [decimal](18, 3) NULL,
	[DutyCountry] [nvarchar](255) NULL,
	[DutyMaterialType] [nvarchar](255) NULL,
	[DutyGender] [nvarchar](255) NULL,
	[DutyCustom1] [nvarchar](255) NULL,
	[DutyCustom2] [nvarchar](255) NULL,
	[Active] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomSort] [nvarchar](50) NULL,
	[TempNo] [nvarchar](50) NULL,
	[TempID] [nvarchar](50) NULL,
	[Custom] [nvarchar](255) NULL,
 CONSTRAINT [PK_pStyleCostingDuty] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '025', GetDate())
GO

