IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMALLSizeRange_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMALLSizeRange_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMALLSizeRange_Select] (
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT 
)

AS 	

CREATE TABLE #tempPOM (
	 sizeRowid int NOT NULL IDENTITY (0, 1)				 
	 ,Sizerangeid nvarchar(50)
	 ,amlmeashdrid	nvarchar(50)				 
	 ,SizeRange nvarchar(50)				 				 	 
)
	 
	 		 
insert into #tempPOM (Sizerangeid, amlmeashdrid, SizeRange)
select Sizerangeid, amlmeashdrid, SizeRange from pAMLMeasHdr
where styleid=@StyleID and StyleSet=@StyleSet

insert into #tempPOM (Sizerangeid, amlmeashdrid, SizeRange)
select CustomId, '00000000-0000-0000-0000-000000000000', SizeRangeCode from pSizeRange where
SizeRangeCode in (select   COALESCE(SizeRange,'') from pStyleHeader where styleid=@StyleID and StyleSet=@StyleSet)
and CustomId not in ( select Sizerangeid from pAMLMeasHdr
where styleid=@StyleID and StyleSet=@StyleSet)

select Sizerangeid, amlmeashdrid, SizeRange,
Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7,Size8, Size9, Size10, 
Size11, Size12, Size13, Size14, Size15,Size16, Size17,Size18, Size19, Size20,
Size21, Size22, Size23, Size24, Size25, Size26, Size27,Size28, Size29, Size30, 
Size31, Size32, Size33, Size34, Size35,Size36, Size37,Size38, Size39, Size40,
Size41, Size42, Size43, Size44, Size45, Size46, Size47,Size48, Size49
from pSizeRange ,  #tempPOM 
where CustomId=Sizerangeid order by SizeRange

drop table #tempPOM 

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03045'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03045', GetDate())     

END	  
  
GO