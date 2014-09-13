/****** Object:  StoredProcedure [dbo].[spx_StylePOM_Select]    Script Date: 10/04/2012 14:55:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StylePOM_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StylePOM_Select]
GO

/****** Object:  StoredProcedure [dbo].[spx_StylePOM_Select]    Script Date: 10/04/2012 14:55:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StylePOM_Select]
(
	@AmlMeasHdrID UNIQUEIDENTIFIER,
	@SizeCol INT
)
AS 

        SELECT p.AMLMeasPOMId, p.IsLength, p.IsWidth, p.SortId, p.POM_Row, p.Refcode, p.Description, COALESCE(TolPlus,0) as TolPlus, COALESCE(TolMinus,0) as TolMinus,
        i.Incr, p.BeforeTreat, p.ShrinkX, p.ShrinkY, p.FabricType, p.CADModelId from pamlmeaspom p, pamlmeasigc i where p.amlmeashdrid=i.amlmeashdrid
        and p.AMLMeasPOMId=i.AMLMeasPOMId and p.POM_Row=i.POM_Row and
        p.amlmeashdrid = @AmlMeasHdrID and i.sizecol = @SizeCol
        order by p.sortid, p.refcode, p.Description, p.pom_row


GO



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04105', GetDate())
GO

