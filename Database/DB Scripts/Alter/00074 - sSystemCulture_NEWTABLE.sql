


/****** Object:  Table [dbo].[sSystemCulture]    Script Date: 04/21/2010 11:50:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemCulture]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemCulture]
GO

CREATE TABLE [dbo].[sSystemCulture](
	[CultureIndentifierID] [varchar](6) NOT NULL,
	[CultureName] [varchar](6) NULL,
	[CultureCountry] [varchar](200) NULL,
	[CultureLanguage] [varchar](200) NULL,
	[Active] [int] NOT NULL CONSTRAINT [DF_sSystemCulture_Active]  DEFAULT ((1)),
	[Unicode] [int] NULL CONSTRAINT [DF_sSystemCulture_Unicode]  DEFAULT ((0)),
 CONSTRAINT [PK_sSystemCulture] PRIMARY KEY CLUSTERED 
(
	[CultureIndentifierID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0004', 'zh-CNS', 'Chinese (Simplified)',	'Chinese', 1, 1)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0406', 'da-DK', 'Denmark', 'Danish', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0407', 'de-DE', 'Germany', 'German', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0409', 'en-US', 'United Stated', 'English', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x040C', 'fr-FR', 'France', 'French', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0410', 'it-IT', 'Italy', 'Italian', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0411', 'ja-JA', 'Japan', 'Japanese', 1, 1)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0412', 'ko-KR', 'Korean', 'Korean', 1, 1)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0413', 'nl_NL', 'The Netherlands', 'Dutch', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0415', 'pl_PL', 'Poland', 'Polish', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0416', 'pt-BR', 'Brazil', 'Portuguese', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0419', 'ru-RU', 'Russia', 'Russian', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x041D', 'sv-SE', 'Sweden', 'Swedish', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x041F', 'tr-TR', 'Turkey', 'Turkish', 1, 1)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0439', 'hi-IN', 'India', 'Hindi', 1, 1)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0809', 'en-GB', 'United Kingdom', 'English', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x080A', 'es-MX', 'Mexico', 'Spanish', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0816', 'pt-PT', 'Portugal', 'Portuguese', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x081D', 'sv-FI', 'Finland', 'Swedish', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0C0A', 'es-ES', 'Spain', 'Spanish', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x0C0C', 'fr-CA', 'Canada', 'French', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x1009', 'en-CA', 'Canada', 'English', 1, 0)
INSERT INTO sSystemCulture([CultureIndentifierID],[CultureName],[CultureCountry],[CultureLanguage],[Active],[Unicode])
VALUES ('0x7C04', 'zh-CHT', 'Chinese (Traditional)', 'Chinese', 1, 1)

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '074', GetDate())
GO