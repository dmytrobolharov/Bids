BEGIN TRY
BEGIN TRAN

;WITH POMTemplate AS ( -- get list of sizes(and tamplates) that are used
	SELECT pt.POMTempID, V.* 
	FROM pGRMeasurementsPOMTemplate pt
	CROSS APPLY (
		VALUES (Size0, 0),  (Size1, 1),  (Size2, 2),  (Size3, 3),  (Size4, 4), 
			   (Size5, 5),  (Size6, 6),  (Size7, 7),  (Size8, 8),  (Size9, 9),
			   (Size10, 10), (Size11, 11), (Size12, 12), (Size13, 13), (Size14, 14),
			   (Size15, 15), (Size16, 16), (Size17, 17), (Size18, 18), (Size19, 19),
			   (Size20, 20), (Size21, 21), (Size22, 22), (Size23, 23), (Size24, 24),
			   (Size25, 25), (Size26, 26), (Size27, 27), (Size28, 28), (Size29, 29),
			   (Size30, 30), (Size31, 31), (Size32, 32), (Size33, 33), (Size34, 34),
			   (Size35, 35), (Size36, 36), (Size37, 37), (Size38, 38), (Size39, 39),
			   (Size40, 40), (Size41, 41), (Size42, 42), (Size43, 43), (Size44, 44),
			   (Size45, 45), (Size46, 46), (Size47, 47), (Size48, 48), (Size49, 49)
	) V(Size, Num)
	WHERE V.Size <> '')
, POMTempItem AS (	-- list of template items with NULL's in used sizes
	SELECT DISTINCT pti.POMTempItemID
	FROM pGRMeasurementsPOMTemplateItem pti
	CROSS APPLY (
		VALUES (Incr0, 0),  (Incr1, 1),  (Incr2, 2),  (Incr3, 3),  (Incr4, 4), 
			   (Incr5, 5),  (Incr6, 6),  (Incr7, 7),  (Incr8, 8),  (Incr9, 9),
			   (Incr10, 10), (Incr11, 11), (Incr12, 12), (Incr13, 13), (Incr14, 14),
			   (Incr15, 15), (Incr16, 16), (Incr17, 17), (Incr18, 18), (Incr19, 19),
			   (Incr20, 20), (Incr21, 21), (Incr22, 22), (Incr23, 23), (Incr24, 24),
			   (Incr25, 25), (Incr26, 26), (Incr27, 27), (Incr28, 28), (Incr29, 29),
			   (Incr30, 30), (Incr31, 31), (Incr32, 32), (Incr33, 33), (Incr34, 34),
			   (Incr35, 35), (Incr36, 36), (Incr37, 37), (Incr38, 38), (Incr39, 39),
			   (Incr40, 40), (Incr41, 41), (Incr42, 42), (Incr43, 43), (Incr44, 44),
			   (Incr45, 45), (Incr46, 46), (Incr47, 47), (Incr48, 48), (Incr49, 49)
	) V(Incr, Num)
	INNER JOIN POMTemplate pt ON pti.POMTempID = pt.POMTempID AND V.Num = pt.Num
	WHERE V.Incr IS NULL)
UPDATE pti
SET Incr0 = CASE WHEN Incr0 IS NULL AND pt.Size0 != '' THEN 0 ELSE Incr0 END, 
	Incr1 = CASE WHEN Incr1 IS NULL AND pt.Size1 != '' THEN 0 ELSE Incr1 END, 
	Incr2 = CASE WHEN Incr2 IS NULL AND pt.Size2 != '' THEN 0 ELSE Incr2 END, 
	Incr3 = CASE WHEN Incr3 IS NULL AND pt.Size3 != '' THEN 0 ELSE Incr3 END, 
	Incr4 = CASE WHEN Incr4 IS NULL AND pt.Size4 != '' THEN 0 ELSE Incr4 END, 
	Incr5 = CASE WHEN Incr5 IS NULL AND pt.Size5 != '' THEN 0 ELSE Incr5 END, 
	Incr6 = CASE WHEN Incr6 IS NULL AND pt.Size6 != '' THEN 0 ELSE Incr6 END, 
	Incr7 = CASE WHEN Incr7 IS NULL AND pt.Size7 != '' THEN 0 ELSE Incr7 END, 
	Incr8 = CASE WHEN Incr8 IS NULL AND pt.Size8 != '' THEN 0 ELSE Incr8 END, 
	Incr9 = CASE WHEN Incr9 IS NULL AND pt.Size9 != '' THEN 0 ELSE Incr9 END, 
	Incr10 = CASE WHEN Incr10 IS NULL AND pt.Size10 != '' THEN 0 ELSE Incr10 END, 
	Incr11 = CASE WHEN Incr11 IS NULL AND pt.Size11 != '' THEN 0 ELSE Incr11 END, 
	Incr12 = CASE WHEN Incr12 IS NULL AND pt.Size12 != '' THEN 0 ELSE Incr12 END, 
	Incr13 = CASE WHEN Incr13 IS NULL AND pt.Size13 != '' THEN 0 ELSE Incr13 END, 
	Incr14 = CASE WHEN Incr14 IS NULL AND pt.Size14 != '' THEN 0 ELSE Incr14 END, 
	Incr15 = CASE WHEN Incr15 IS NULL AND pt.Size15 != '' THEN 0 ELSE Incr15 END, 
	Incr16 = CASE WHEN Incr16 IS NULL AND pt.Size16 != '' THEN 0 ELSE Incr16 END, 
	Incr17 = CASE WHEN Incr17 IS NULL AND pt.Size17 != '' THEN 0 ELSE Incr17 END, 
	Incr18 = CASE WHEN Incr18 IS NULL AND pt.Size18 != '' THEN 0 ELSE Incr18 END, 
	Incr19 = CASE WHEN Incr19 IS NULL AND pt.Size19 != '' THEN 0 ELSE Incr19 END, 
	Incr20 = CASE WHEN Incr20 IS NULL AND pt.Size20 != '' THEN 0 ELSE Incr20 END, 
	Incr21 = CASE WHEN Incr21 IS NULL AND pt.Size21 != '' THEN 0 ELSE Incr21 END, 
	Incr22 = CASE WHEN Incr22 IS NULL AND pt.Size22 != '' THEN 0 ELSE Incr22 END, 
	Incr23 = CASE WHEN Incr23 IS NULL AND pt.Size23 != '' THEN 0 ELSE Incr23 END, 
	Incr24 = CASE WHEN Incr24 IS NULL AND pt.Size24 != '' THEN 0 ELSE Incr24 END, 
	Incr25 = CASE WHEN Incr25 IS NULL AND pt.Size25 != '' THEN 0 ELSE Incr25 END, 
	Incr26 = CASE WHEN Incr26 IS NULL AND pt.Size26 != '' THEN 0 ELSE Incr26 END, 
	Incr27 = CASE WHEN Incr27 IS NULL AND pt.Size27 != '' THEN 0 ELSE Incr27 END, 
	Incr28 = CASE WHEN Incr28 IS NULL AND pt.Size28 != '' THEN 0 ELSE Incr28 END, 
	Incr29 = CASE WHEN Incr29 IS NULL AND pt.Size29 != '' THEN 0 ELSE Incr29 END, 
	Incr30 = CASE WHEN Incr30 IS NULL AND pt.Size30 != '' THEN 0 ELSE Incr30 END, 
	Incr31 = CASE WHEN Incr31 IS NULL AND pt.Size31 != '' THEN 0 ELSE Incr31 END, 
	Incr32 = CASE WHEN Incr32 IS NULL AND pt.Size32 != '' THEN 0 ELSE Incr32 END, 
	Incr33 = CASE WHEN Incr33 IS NULL AND pt.Size33 != '' THEN 0 ELSE Incr33 END, 
	Incr34 = CASE WHEN Incr34 IS NULL AND pt.Size34 != '' THEN 0 ELSE Incr34 END, 
	Incr35 = CASE WHEN Incr35 IS NULL AND pt.Size35 != '' THEN 0 ELSE Incr35 END, 
	Incr36 = CASE WHEN Incr36 IS NULL AND pt.Size36 != '' THEN 0 ELSE Incr36 END, 
	Incr37 = CASE WHEN Incr37 IS NULL AND pt.Size37 != '' THEN 0 ELSE Incr37 END, 
	Incr38 = CASE WHEN Incr38 IS NULL AND pt.Size38 != '' THEN 0 ELSE Incr38 END, 
	Incr39 = CASE WHEN Incr39 IS NULL AND pt.Size39 != '' THEN 0 ELSE Incr39 END, 
	Incr40 = CASE WHEN Incr40 IS NULL AND pt.Size40 != '' THEN 0 ELSE Incr40 END, 
	Incr41 = CASE WHEN Incr41 IS NULL AND pt.Size41 != '' THEN 0 ELSE Incr41 END, 
	Incr42 = CASE WHEN Incr42 IS NULL AND pt.Size42 != '' THEN 0 ELSE Incr42 END, 
	Incr43 = CASE WHEN Incr43 IS NULL AND pt.Size43 != '' THEN 0 ELSE Incr43 END, 
	Incr44 = CASE WHEN Incr44 IS NULL AND pt.Size44 != '' THEN 0 ELSE Incr44 END, 
	Incr45 = CASE WHEN Incr45 IS NULL AND pt.Size45 != '' THEN 0 ELSE Incr45 END, 
	Incr46 = CASE WHEN Incr46 IS NULL AND pt.Size46 != '' THEN 0 ELSE Incr46 END, 
	Incr47 = CASE WHEN Incr47 IS NULL AND pt.Size47 != '' THEN 0 ELSE Incr47 END, 
	Incr48 = CASE WHEN Incr48 IS NULL AND pt.Size48 != '' THEN 0 ELSE Incr48 END, 
	Incr49 = CASE WHEN Incr49 IS NULL AND pt.Size49 != '' THEN 0 ELSE Incr49 END
FROM pGRMeasurementsPOMTemplateItem pti
INNER JOIN pGRMeasurementsPOMTemplate pt ON pti.POMTempID = pt.POMTempID
INNER JOIN POMTempItem ON pti.POMTempItemID = POMTempItem.POMTempItemID

COMMIT
END TRY
BEGIN CATCH
	SELECT 
          ERROR_NUMBER() AS ErrorNumber
        , ERROR_SEVERITY() AS ErrorSeverity
        , ERROR_STATE() AS ErrorState
        , ERROR_PROCEDURE() AS ErrorProcedure
        , ERROR_LINE() AS ErrorLine
        , ERROR_MESSAGE() AS ErrorMessage;
        
	IF XACT_STATE() <> 0 ROLLBACK
END CATCH
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09966', GetUTCDate())
GO
