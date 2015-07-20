UPDATE pGRClassRange
   SET SizeClassGuidId = (SELECT SizeClassGuidId 
                           from pGRSizeClassCompany
                          WHERE SizeClassCompanyId = pGRClassRange.SizeClassCompanyId)
WHERE SizeClassGuidId is NULL
go

DECLARE @SizeRangeId uniqueidentifier
DECLARE @SizeClassGuidId uniqueidentifier
DECLARE Cursor1 INSENSITIVE CURSOR
            FOR select distinct psd.SizeRangeId, pgc.SizeClassGuidId
                 from pGRSizeRangeDetail psd, pGRClassRange pgc
                where psd.SizeRangeId in (select sizerangeguidid from pGRSizeRange where SizeClassGuidIdXX is null)
                  and psd.ClassRangeId <> '00000000-0000-0000-0000-000000000000'
                  and psd.ClassRangeId = pgc.ClassRangeId
            FOR READ ONLY
            
OPEN Cursor1

FETCH NEXT FROM Cursor1 INTO @SizeRangeId,@SizeClassGuidId

      
WHILE @@FETCH_STATUS = 0
BEGIN  
      UPDATE pGRSizeRange 
         set SizeClassGuidIdXX = @SizeClassGuidId
      WHERE SizeRangeGuidId = @SizeRangeId
      
      FETCH NEXT FROM Cursor1 INTO @SizeRangeId,@SizeClassGuidId
END     
CLOSE Cursor1
DEALLOCATE CURSOR1
go

update pGRAlternates
set CompanyGuidID = '00000000-0000-0000-0000-000000000000'
where CompanyGuidID is null
go

UPDATE pGRProductClassImage
   SET SizeClassGuidId = (select SizeClassGuidId 
                           from pGRSizeClassCompany
                           WHERE SizeClassCompanyId = pGRProductClassImage.SizeClassCompanyId )
GO

UPDATE pGRGradeRule
  set POMAlternatesIdXX = (SELECT POMAlternatesId
                             FROM pGRPOMCompany
                           WHERE POMCompanyId = pGRGradeRule.POMCompanyId)
WHERE POMAlternatesIdXX IS NULL
GO

update pGRGradeRule
   set SizeRangeGuidId = (select SizeRangeGuidId 
                        from pGRClassRange
                        where ClassRangeId =  pGRGradeRule.ClassRangeId)
where SizeRangeGuidId is null
GO

update pGRTolerance
set TolPlus = 0.0
where TolPlus is null
go


update pGRTolerance
set TolMinus = 0.0
where TolMinus is null
go


update pGRTolerance
set IsPrimaryKeyMeas = 0
where IsPrimaryKeyMeas is null
go




UPDATE pGRPOMAlternates
SET AlternatesGuidId = '00000000-0000-0000-0000-000000000000'
where AlternatesGuidId in  (select AlternatesGuidId
                         from pgralternates
                         WHERE AlternatesDesc = 'None'
                          and (AlternatesCode is null or AlternatesCode = ''))
go

UPDATE pgralternates
set AlternatesGuidId = '00000000-0000-0000-0000-000000000000'
WHERE AlternatesDesc = 'None'
and (AlternatesCode is null or AlternatesCode = '')
go