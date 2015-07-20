/*
   Monday, April 26, 20105:42:24 PM
   User: 
   Server: YSDPSQL
   Database: plmOn
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[da-DK]', N'Tmp_da_DK_46', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[de-DE]', N'Tmp_de_DE_47', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[en-US]', N'Tmp_en_US_48', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[en-GB]', N'Tmp_en_GB_49', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[en-CA]', N'Tmp_en_CA_50', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[fr-FR]', N'Tmp_fr_FR_51', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[fr-CA]', N'Tmp_fr_CA_52', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[es-ES]', N'Tmp_es_ES_53', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[es-MX]', N'Tmp_es_MX_54', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[hi-IN]', N'Tmp_hi_IN_55', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[it-IT]', N'Tmp_it_IT_56', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[ja-JA]', N'Tmp_ja_JA_57', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[ko-KR]', N'Tmp_ko_KR_58', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[nl-NL]', N'Tmp_nl_NL_59', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[pl-PL]', N'Tmp_pl_PL_60', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[pt-PT]', N'Tmp_pt_PT_61', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[pt-BR]', N'Tmp_pt_BR_62', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[ru-RU]', N'Tmp_ru_RU_63', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[sv-FI]', N'Tmp_sv_FI_64', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[sv-SE]', N'Tmp_sv_SE_65', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[tr-TR]', N'Tmp_tr_TR_66', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[zh-CHS]', N'Tmp_zh_CHS_67', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.[zh-CHT]', N'Tmp_zh_CHT_68', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_da_DK_46', N'da_DK', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_de_DE_47', N'de_DE', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_en_US_48', N'en_US', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_en_GB_49', N'en_GB', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_en_CA_50', N'en_CA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_fr_FR_51', N'fr_FR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_fr_CA_52', N'fr_CA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_es_ES_53', N'es_ES', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_es_MX_54', N'es_MX', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_hi_IN_55', N'hi_IN', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_it_IT_56', N'it_IT', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_ja_JA_57', N'ja_JA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_ko_KR_58', N'ko_KR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_nl_NL_59', N'nl_NL', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_pl_PL_60', N'pl_PL', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_pt_PT_61', N'pt_PT', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_pt_BR_62', N'pt_BR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_ru_RU_63', N'ru_RU', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_sv_FI_64', N'sv_FI', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_sv_SE_65', N'sv_SE', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_tr_TR_66', N'tr_TR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_zh_CHS_67', N'zh_CHS', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemButtons.Tmp_zh_CHT_68', N'zh_CHT', 'COLUMN' 
GO
COMMIT

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '079', GetDate())
GO

