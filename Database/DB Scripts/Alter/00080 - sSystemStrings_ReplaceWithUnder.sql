/*
   Monday, April 26, 20105:25:52 PM
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
EXECUTE sp_rename N'dbo.sSystemStrings.[da-DK]', N'Tmp_da_DK', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[de-DE]', N'Tmp_de_DE_1', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[en-US]', N'Tmp_en_US_2', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[en-GB]', N'Tmp_en_GB_3', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[en-CA]', N'Tmp_en_CA_4', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[fr-FR]', N'Tmp_fr_FR_5', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[fr-CA]', N'Tmp_fr_CA_6', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[es-ES]', N'Tmp_es_ES_7', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[es-MX]', N'Tmp_es_MX_8', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[hi-IN]', N'Tmp_hi_IN_9', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[it-IT]', N'Tmp_it_IT_10', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[ja-JA]', N'Tmp_ja_JA_11', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[ko-KR]', N'Tmp_ko_KR_12', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[nl-NL]', N'Tmp_nl_NL_13', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[pl-PL]', N'Tmp_pl_PL_14', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[pt-PT]', N'Tmp_pt_PT_15', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[pt-BR]', N'Tmp_pt_BR_16', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[ru-RU]', N'Tmp_ru_RU_17', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[sv-FI]', N'Tmp_sv_FI_18', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[sv-SE]', N'Tmp_sv_SE_19', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[tr-TR]', N'Tmp_tr_TR_20', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[zh-CHS]', N'Tmp_zh_CHS_21', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.[zh-CHT]', N'Tmp_zh_CHT_22', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_da_DK', N'da_DK', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_de_DE_1', N'de_DE', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_en_US_2', N'en_US', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_en_GB_3', N'en_GB', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_en_CA_4', N'en_CA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_fr_FR_5', N'fr_FR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_fr_CA_6', N'fr_CA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_es_ES_7', N'es_ES', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_es_MX_8', N'es_MX', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_hi_IN_9', N'hi_IN', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_it_IT_10', N'it_IT', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_ja_JA_11', N'ja_JA', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_ko_KR_12', N'ko_KR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_nl_NL_13', N'nl_NL', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_pl_PL_14', N'pl_PL', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_pt_PT_15', N'pt_PT', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_pt_BR_16', N'pt_BR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_ru_RU_17', N'ru_RU', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_sv_FI_18', N'sv_FI', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_sv_SE_19', N'sv_SE', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_tr_TR_20', N'tr_TR', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_zh_CHS_21', N'zh_CHS', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.sSystemStrings.Tmp_zh_CHT_22', N'zh_CHT', 'COLUMN' 
GO
COMMIT

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '080', GetDate())
GO
