IF NOT EXISTS(SELECT * FROM pPlanningFinancial WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000019')
BEGIN
	-- update sorts for planning columns after the new one, that will be inserted
	UPDATE pPlanningFinancial SET PlanningFinancialSort = RIGHT('0000' + CAST(CAST(PlanningFinancialSort AS INT) + 1 AS nVARCHAR(5)), 4)
	WHERE PlanningFinancialSort > '0000'

	-- insert new planning columns
	INSERT INTO pPlanningFinancial(PlanningFinancialID, PlanningFinancialDataType, PlanningFinancialDataFormat, PlanningFinancialCssClass,
		PlanningFinancialText, PlanningFinancialSort, Active, Editable, AllowPercentInput)
	VALUES ('10000000-0000-0000-0000-000000000019', 'decimal', '0', 'fontHead', 
		'# of Planned Colorways', '0001', 1, 1, 0)
		
	-- insert records for newly added planning column for existing sub categories as thay seem to not sync automatically
	INSERT INTO pPlanningBusiness(PlanningID, SeasonYearID, 
		PlanningBrandID, PlanningBrand,
		PlanningDivisionID, PlanningDivision,
		PlanningStyleTypeID, PlanningStyleTypeDescription,
		PlanningStyleCategoryID, PlanningStyleCategory,
		PlanningSubCategoryID, PlanningSubCategory,
		PlanningFinancialID, PlanningFinancialText)
	SELECT pscsc.PlanningID, pscsc.SeasonYearID, 
		pscsc.PlanningBrandID, b.Custom,
		pscsc.PlanningDivisionID, d.Custom,
		pscsc.PlanningStyleTypeID, st.StyleTypeDescription,
		pscsc.PlanningStyleCategoryID, sc.StyleCategory,
		pscsc.SubCategoryID, sbc.Custom,
		'10000000-0000-0000-0000-000000000019', '# of Planned Colorways'
	FROM pPlanningStyleCategoryToSubCategory pscsc
	LEFT JOIN pBrand b ON pscsc.PlanningBrandID = b.CustomID
	LEFT JOIN vwx_Division_SEL d ON pscsc.PlanningDivisionID = d.CustomID
	LEFT JOIN pStyleType st ON pscsc.PlanningStyleTypeID = st.StyleTypeID
	LEFT JOIN pStyleCategory sc ON pscsc.PlanningStyleCategoryID = sc.StyleCategoryId
	LEFT JOIN pSubCategory sbc ON pscsc.SubCategoryID = sbc.CustomID
	LEFT JOIN pPlanningBusiness pb ON pscsc.PlanningID = pb.PlanningID 
		AND pscsc.SeasonYearID = pb.SeasonYearID
		AND pscsc.PlanningBrandID = pb.PlanningBrandID
		AND pscsc.PlanningDivisionID = pb.PlanningDivisionID
		AND pscsc.PlanningStyleTypeID = pb.PlanningStyleTypeID
		AND pscsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
		AND pscsc.SubCategoryID = pb.PlanningSubCategoryID
		AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000019'
	WHERE pb.PlanningBusinessID IS NULL

	-- update all sorts
	UPDATE pb SET PlanningFinancialSort = pf.PlanningFinancialSort
	FROM pPlanningBusiness pb 
	INNER JOIN pPlanningFinancial pf ON pb.PlanningFinancialID = pf.PlanningFinancialID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07576', GetDate())
GO
