ALTER TABLE sSystemButtons ALTER COLUMN DesignString NVARCHAR(50) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN da_DK NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN de_DE NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN en_US NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN en_GB NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN en_CA NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN fr_FR NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN fr_CA NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN es_ES NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN es_MX NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN hi_IN NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN it_IT NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN ja_JA NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN ko_KR NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN nl_NL NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN pl_PL NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN pt_PT NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN pt_BR NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN ru_RU NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN sv_FI NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN sv_SE NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN tr_TR NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN zh_CHS NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN zh_CHT NVARCHAR(30) null
GO
ALTER TABLE sSystemButtons ALTER COLUMN el_GR NVARCHAR(30) null
GO
if exists( select * from INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = 'sSystemButtons'
              AND COLUMN_NAME = 'SystemButtonID'
              AND COLUMN_DEFAULT = '(newsequentialid())')
begin
      ALTER TABLE dbo.sSystemButtons
        DROP CONSTRAINT DF_sSystemButtons_SystemButtonID
end 
GO

ALTER TABLE dbo.sSystemButtons ADD CONSTRAINT
      DF_sSystemButtons_SystemButtonID DEFAULT (newsequentialid()) FOR SystemButtonID
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01943'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01943', GetDate())

END
GO