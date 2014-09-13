IF NOT EXISTS (SELECT * FROM pPlanningActivityType WHERE PlanningActivityKey = 'SAP')
BEGIN
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('SAP', 'Style', 'Style {0} has been added to the Line Plan')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07952', GetDate())
GO
