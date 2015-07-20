update pAMLMeasHdr
   SET SizeClassId = (SELECT FlatSizeClassId
                        FROM pGRClassRange
                       WHERE ClassRangeId =  pAMLMeasHdr.SizeRangeId )
      ,SizeRangeId = (SELECT  FlatSizeRangeId
                        FROM pGRClassRange
                       WHERE ClassRangeId =  pAMLMeasHdr.SizeRangeId )
go
 UPDATE pAMLMeasLbl
    SEt SizeRangeId = (SELECT SizeRangeId
                          FROM pAMLMeasHdr
                         WHERE pAMLMeasLbl.AMLMeasHdrId = AMLMeasHdrId)
go
UPDATE pAMLMeasPOM
    SET POMGuidId        = (SELECT FlatPOMId
                              FROM pGRPOM
                             WHERE pAMLMeasPOM.POMGuidId = POMGuidId)
       ,RefCode          = (SELECT FlatRefCode
                              FROM pGRPOM
                             WHERE pAMLMeasPOM.POMGuidId = POMGuidId)
GO