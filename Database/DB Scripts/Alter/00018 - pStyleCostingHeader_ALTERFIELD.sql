--
-- Wednesday, March 10, 201010:14:09 PM
-- User: 
-- Server: YSDPSQL
-- Database: plmOn
-- Application: 
--

IF EXISTS (SELECT Name from sysobjects WHERE Name like 'DF_pStyleCostingHeader_StyleCostingHeaderID')
   BEGIN
        ALTER TABLE pStyleCostingHeader DROP CONSTRAINT DF_pStyleCostingHeader_StyleCostingHeaderID
   END
GO

CREATE TABLE Tmp_pStyleCostingHeader
	(
	StyleCostingHeaderID uniqueidentifier NOT NULL ROWGUIDCOL,
	StyleSeasonYearID uniqueidentifier NULL,
	StyleID uniqueidentifier NOT NULL,
	StyleCostingTypeID int NULL,
	StyleQuotaDutyID uniqueidentifier NULL,
	StyleCostingDate datetime NULL,
	StyleCostingStatus nvarchar(200) NULL,
	StyleCostingCustomField1 money NULL,
	StyleCostingCustomField2 money NULL,
	StyleCostingCustomField3 decimal(18, 4) NULL,
	StyleCostingCustomField4 decimal(18, 0) NULL,
	StyleCostingCustomField5 decimal(18, 3) NULL,
	StyleCostingCustomField6 decimal(18, 3) NULL,
	StyleCostingCustomField7 decimal(18, 2) NULL,
	StyleCostingCustomField8 decimal(18, 2) NULL,
	StyleCostingCustomField9 decimal(18, 2) NULL,
	StyleCostingCustomField10 decimal(18, 3) NULL,
	StyleCostingCustomField11 decimal(18, 3) NULL,
	StyleCostingCustomField12 decimal(18, 3) NULL,
	StyleCostingCustomField13 decimal(18, 3) NULL,
	StyleCostingCustomField14 decimal(18, 3) NULL,
	StyleCostingCustomField15 decimal(18, 3) NULL,
	StyleCostingCustomField16 varchar(50) NULL,
	StyleCostingCustomField17 datetime NULL,
	StyleCostingCustomField18 decimal(18, 3) NULL,
	StyleCostingCustomField19 decimal(18, 3) NULL,
	StyleCostingCustomField20 decimal(18, 3) NULL,
	StyleCostingCustomField21 decimal(18, 3) NULL,
	StyleCostingCustomField22 decimal(18, 3) NULL,
	StyleCostingCustomField23 decimal(18, 3) NULL,
	StyleCostingCustomField24 decimal(18, 3) NULL,
	StyleCostingCustomField25 varchar(50) NULL,
	StyleCostingCustomField26 varchar(50) NULL,
	StyleCostingCustomField27 varchar(50) NULL,
	StyleCostingCustomField28 varchar(50) NULL,
	StyleCostingCustomField29 varchar(50) NULL,
	StyleCostingCustomField30 varchar(50) NULL,
	CUser nvarchar(200) NULL,
	CDate datetime NULL,
	MUser nvarchar(200) NULL,
	MDate datetime NULL,
	Active bit NULL,
	StyleCostingCustomField31 varchar(50) NULL,
	StyleCostingCustomField32 varchar(50) NULL,
	StyleCostingCustomField33 varchar(50) NULL,
	StyleCostingCustomField34 varchar(50) NULL,
	StyleCostingCustomField35 varchar(50) NULL,
	UnitsPlan int NULL,
	UnitsActual int NULL
	)  ON [PRIMARY]
GO

ALTER TABLE Tmp_pStyleCostingHeader ADD CONSTRAINT
	DF_pStyleCostingHeader_StyleCostingHeaderID DEFAULT (newid()) FOR StyleCostingHeaderID
GO

IF EXISTS(SELECT * FROM pStyleCostingHeader)
	 EXEC('INSERT INTO Tmp_pStyleCostingHeader (StyleCostingHeaderID, StyleSeasonYearID, StyleID, StyleCostingTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, CUser, CDate, MUser, MDate, Active, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, UnitsPlan, UnitsActual)
		SELECT StyleCostingHeaderID, StyleSeasonYearID, StyleID, StyleCostingTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, CUser, CDate, MUser, MDate, Active, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, UnitsPlan, UnitsActual FROM pStyleCostingHeader WITH (HOLDLOCK TABLOCKX)')
GO

DROP TABLE pStyleCostingHeader
GO

EXECUTE sp_rename N'Tmp_pStyleCostingHeader', N'pStyleCostingHeader', 'OBJECT' 
GO

ALTER TABLE pStyleCostingHeader ADD CONSTRAINT
	PK_pStyleCostingHeader_1 PRIMARY KEY CLUSTERED 
	(StyleCostingHeaderID) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '018', GetDate())
GO

