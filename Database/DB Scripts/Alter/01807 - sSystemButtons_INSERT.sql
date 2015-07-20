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

INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('add_new_type.gif', 'add new type', 'icon_new.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_new_subcategory.gif', 'add new subcategory', 'icon_new.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_category.gif', 'add new category', 'icon_add.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_show_hidden_categories.gif', 'show inactive nodes', 'icon_delete1.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_operation.gif', 'add operation', 'icon_add.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_macro.gif', 'add macro', 'icon_add.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_and_new.gif', 'add and new', 'icon_add.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_new_operation.gif', 'new operation', 'icon_new.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_new_macro.gif', 'new macro', 'icon_new.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_new_template.gif', 'new template', 'icon_new.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_copy_template.gif', 'copy template', 'icon_copy.gif')

GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01807'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01807', GetDate())
END

GO