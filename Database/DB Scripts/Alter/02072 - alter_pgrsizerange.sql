IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSizeRange' and COLUMN_NAME = N'Size20')
	BEGIN 
		ALTER TABLE pSizeRange	ADD Size20 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size21 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size22 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size23 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size24 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size25 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size26 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size27 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size28 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size29 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size30 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size31 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size32 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size33 nvarchar(9) NULL		
		ALTER TABLE pSizeRange	ADD Size34 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size35 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size36 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size37 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size38 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size39 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size40 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size41 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size42 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size43 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size44 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size45 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size46 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size47 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size48 nvarchar(9) NULL
		ALTER TABLE pSizeRange	ADD Size49 nvarchar(9) NULL		
		ALTER TABLE pSizeRange	ADD Sel20 bit NULL
		ALTER TABLE pSizeRange ADD Sel21 bit NULL
		ALTER TABLE pSizeRange ADD Sel22 bit NULL
		ALTER TABLE pSizeRange ADD Sel23 bit NULL
		ALTER TABLE pSizeRange ADD Sel24 bit NULL
		ALTER TABLE pSizeRange ADD Sel25 bit NULL
		ALTER TABLE pSizeRange ADD Sel26 bit NULL
		ALTER TABLE pSizeRange ADD Sel27 bit NULL
		ALTER TABLE pSizeRange ADD Sel28 bit NULL
		ALTER TABLE pSizeRange ADD Sel29 bit NULL
		ALTER TABLE pSizeRange ADD Sel30 bit NULL
		ALTER TABLE pSizeRange ADD Sel31 bit NULL
		ALTER TABLE pSizeRange ADD Sel32 bit NULL
		ALTER TABLE pSizeRange ADD Sel33 bit NULL
		ALTER TABLE pSizeRange ADD Sel34 bit NULL
		ALTER TABLE pSizeRange ADD Sel35 bit NULL
		ALTER TABLE pSizeRange ADD Sel36 bit NULL
		ALTER TABLE pSizeRange ADD Sel37 bit NULL
		ALTER TABLE pSizeRange ADD Sel38 bit NULL
		ALTER TABLE pSizeRange ADD Sel39 bit NULL
		ALTER TABLE pSizeRange ADD Sel40 bit NULL
		ALTER TABLE pSizeRange ADD Sel41 bit NULL
		ALTER TABLE pSizeRange ADD Sel42 bit NULL
		ALTER TABLE pSizeRange ADD Sel43 bit NULL
		ALTER TABLE pSizeRange ADD Sel44 bit NULL
		ALTER TABLE pSizeRange ADD Sel45 bit NULL
		ALTER TABLE pSizeRange ADD Sel46 bit NULL
		ALTER TABLE pSizeRange ADD Sel47 bit NULL
		ALTER TABLE pSizeRange ADD Sel48 bit NULL
		ALTER TABLE pSizeRange ADD Sel49 bit NULL		
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel20  DEFAULT ((0)) FOR Sel20
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel21  DEFAULT ((0)) FOR Sel21
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel22  DEFAULT ((0)) FOR Sel22
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel23  DEFAULT ((0)) FOR Sel23
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel24  DEFAULT ((0)) FOR Sel24
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel25  DEFAULT ((0)) FOR Sel25
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel26  DEFAULT ((0)) FOR Sel26
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel27  DEFAULT ((0)) FOR Sel27
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel28  DEFAULT ((0)) FOR Sel28
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel29  DEFAULT ((0)) FOR Sel29
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel30  DEFAULT ((0)) FOR Sel30
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel31  DEFAULT ((0)) FOR Sel31
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel32  DEFAULT ((0)) FOR Sel32
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel33  DEFAULT ((0)) FOR Sel33
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel34  DEFAULT ((0)) FOR Sel34
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel35  DEFAULT ((0)) FOR Sel35
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel36  DEFAULT ((0)) FOR Sel36
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel37  DEFAULT ((0)) FOR Sel37
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel38  DEFAULT ((0)) FOR Sel38
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel39  DEFAULT ((0)) FOR Sel39
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel40  DEFAULT ((0)) FOR Sel40
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel41  DEFAULT ((0)) FOR Sel41
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel42  DEFAULT ((0)) FOR Sel42
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel43  DEFAULT ((0)) FOR Sel43
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel44  DEFAULT ((0)) FOR Sel44
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel45  DEFAULT ((0)) FOR Sel45
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel46  DEFAULT ((0)) FOR Sel46
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel47  DEFAULT ((0)) FOR Sel47
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel48  DEFAULT ((0)) FOR Sel48
		ALTER TABLE dbo.pSizeRange ADD  CONSTRAINT DF_pSizeRange_Sel49  DEFAULT ((0)) FOR Sel49

END

Go



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02072'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02072', GetDate())
	END
GO