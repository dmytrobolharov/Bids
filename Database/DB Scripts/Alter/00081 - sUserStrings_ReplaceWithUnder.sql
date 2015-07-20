/*
   Monday, April 26, 20105:29:46 PM
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
EXECUTE sp_rename N'dbo.sUserStrings.[da-DK]', N'Tmp_da_DK_23', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[de-DE]', N'Tmp_de_DE_24', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[en-US]', N'Tmp_en_US_25', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[en-GB]', N'Tmp_en_GB_26', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[en-CA]', N'Tmp_en_CA_27', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[fr-FR]', N'Tmp_fr_FR_28', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[fr-CA]', N'Tmp_fr_CA_29', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[es-ES]', N'Tmp_es_ES_30', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[es-MX]', N'Tmp_es_MX_31', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[hi-IN]', N'Tmp_hi_IN_32', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[it-IT]', N'Tmp_it_IT_33', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[ja-JA]', N'Tmp_ja_JA_34', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[ko-KR]', N'Tmp_ko_KR_35', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[nl-NL]', N'Tmp_nl_NL_36', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[pl-PL]', N'Tmp_pl_PL_37', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[pt-PT]', N'Tmp_pt_PT_38', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[pt-BR]', N'Tmp_pt_BR_39', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[ru-RU]', N'Tmp_ru_RU_40', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[sv-FI]', N'Tmp_sv_FI_41', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[sv-SE]', N'Tmp_sv_SE_42', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[tr-TR]', N'Tmp_tr_TR_43', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[zh-CHS]', N'Tmp_zh_CHS_44', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.[zh-CHT]', N'Tmp_zh_CHT_45', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_da_DK_23', N'da_DK', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_de_DE_24', N'de_DE', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_en_US_25', N'en_US', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_en_GB_26', N'en_GB', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_en_CA_27', N'en_CA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_fr_FR_28', N'fr_FR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_fr_CA_29', N'fr_CA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_es_ES_30', N'es_ES', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_es_MX_31', N'es_MX', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_hi_IN_32', N'hi_IN', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_it_IT_33', N'it_IT', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_ja_JA_34', N'ja_JA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_ko_KR_35', N'ko_KR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_nl_NL_36', N'nl_NL', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_pl_PL_37', N'pl_PL', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_pt_PT_38', N'pt_PT', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_pt_BR_39', N'pt_BR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_ru_RU_40', N'ru_RU', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_sv_FI_41', N'sv_FI', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_sv_SE_42', N'sv_SE', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_tr_TR_43', N'tr_TR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_zh_CHS_44', N'zh_CHS', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sUserStrings.Tmp_zh_CHT_45', N'zh_CHT', 'COLUMN' 
GO
COMMIT

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '081', GetDate())
GO
