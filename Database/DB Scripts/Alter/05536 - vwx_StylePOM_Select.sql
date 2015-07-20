/****** Object:  View [dbo].[vwx_StylePOM_Select]    Script Date: 03/22/2013 15:01:48 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StylePOM_Select]'))
DROP VIEW [dbo].[vwx_StylePOM_Select]
GO
/****** Object:  View [dbo].[vwx_StylePOM_Select]    Script Date: 03/22/2013 15:01:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

General - Rajul Radadia - April 10, 2013

*/
CREATE VIEW [dbo].[vwx_StylePOM_Select]
AS
SELECT 	p.AMLMeasPOMId,
		p.AMLMeasHdrId,
		p.GRPOMCompanyId,
		p.POMGuidId,
		p.POMAlternatesId,
		p.POM_Row,
		p.Refcode,
		p.Description,				
		COALESCE(p.TolPlus,0) as TolPlus, 
		COALESCE(p.TolMinus,0) as TolMinus,
		COALESCE(p.TolPlusConv,0) as TolPlusConv, 
		COALESCE(p.TolMinusConv,0) as TolMinusConv,
		p.Flag4QA,
		p.SortId,
		p.ImageId,
		p.How2MeasText,		
		p.IsLinked,
		p.Critical,		
		p.How2MeasName,
		p.FabricType,
		p.IsLength, 
		p.IsWidth,
		p.ShrinkX, 
		p.ShrinkY,
		p.CADModelId,
		p.BeforeTreat,
		i.AMLMeasIGCId,
		i.SizeCol,
        COALESCE(i.Incr,0) as Incr,
		COALESCE(i.Grade,0) as Grade,
		COALESCE(i.ConvGrade,0) as ConvGrade
FROM 	pAMLMeasPOM p, 
		pAMLMeasIGC i 
WHERE 	p.amlmeashdrid=i.amlmeashdrid AND 
		p.AMLMeasPOMId=i.AMLMeasPOMId AND 
		p.POM_Row=i.POM_Row

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05536', GetDate())
GO