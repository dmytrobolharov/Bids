IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColors_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerColors_SELECT](@MaterialTradePartnerID uniqueidentifier,
@SearchCond nvarchar(MAX) ='')
AS 

DECLARE @strsql as nvarchar(max)

SELECT a.MaterialTradePartnerColorID , a.MaterialPRICE,
d.ColorCode, d.ColorName , a.MaterialTradeColor1, a.MaterialTradeColor2, a.MaterialTradeColor3, 
CASE ISNUMERIC(a.MaterialTradeColor4) WHEN 1 THEN CAST(a.MaterialTradeColor4 as DECIMAL(18, 2)) ELSE 0 END as MaterialTradeColor4, 
a.MaterialTradeColor5, a.MaterialTradeColor6, 
CASE ISNUMERIC(a.MaterialTradeColor7) WHEN 1 THEN CAST(a.MaterialTradeColor7 as DECIMAL(18, 2)) ELSE 0 END as MaterialTradeColor7, 
CASE ISNUMERIC(a.MaterialTradeColor8) WHEN 1 THEN CAST(a.MaterialTradeColor8 as DECIMAL(18, 2)) ELSE 0 END as MaterialTradeColor8,
a.MaterialTradeColor9, a.MaterialTradeColor10,
a.MaterialTradeColor11, a.MaterialTradeColor12, a.MaterialTradeColor13,
a.MaterialTradeColor14, a.MaterialTradeColor15, a.MaterialTradeColor16,
a.MaterialTradeColor17, 
CASE ISNUMERIC(a.MaterialTradeColor18) WHEN 1 THEN CAST(a.MaterialTradeColor18 as DECIMAL(18, 2)) ELSE 0 END as MaterialTradeColor18, 
a.MaterialTradeColor19,
a.ColorName + '/ ' +  ISNULL(b.MaterialSize, '*NA') AS MaterialColor , c.SeasonYearID,

CASE 
	WHEN b.MaterialSizeID IS NULL THEN  '*NA' 
	ELSE b.MaterialSize
END AS MaterialSize, 
Case  
	WHEN a.MaterialColorImageID IS NULL  THEN 
		'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
		<IMG src=''' + '../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(a.ColorFolderID AS VARCHAR(40)) + 
		'&CPID=' + CAST(a.ColorPaletteID AS VARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
	 ELSE  
		'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
		<IMG src=''' + '../System/Control/ImageStream.ashx?S=16&V=' + CAST(a.MaterialColorImageVersion AS VARCHAR(40)) + 
		'&IID=' + CAST(a.MaterialColorImageID AS VARCHAR(40)) + ''' border=0 ALT=''Open''></TD></TR></TABLE>'
END AS ColorImagePath

 into #tmptbl FROM pMaterialTradePartnerColor a  
INNER JOIN pMaterialTradePartner c on a.MaterialTradePartnerID = c.MaterialTradePartnerID
INNER JOIN pColorPalette d ON d.ColorPaletteID = a.ColorPaletteID 
LEFT OUTER JOIN pMaterialSize b ON a.MaterialSizeID =  b.MaterialSizeID
WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID
ORDER BY a.ColorName, b.MaterialSize

SET @strsql = 'SELECT * FROM #tmptbl '

if @SearchCond is not  null 
if LTRIM(RTRIM(@SearchCond)) <> ''
begin
SET @strsql =  @strsql +  @SearchCond 
end
exec sp_executesql @strsql

drop table #tmptbl


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06208', GetDate())
GO
