IF NOT EXISTS (SELECT * FROM pPlanningActivityType)
BEGIN

	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('SD', 'Style', 'Style {0} has been dropped from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('SSA', 'Style', 'Style {0} has been set as active from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('SR', 'Style', 'Style {0} has been removed from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('SIU', 'Style', 'The Image of Style {0} has been updated from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('SAL', 'Style', 'Style {0} was added to this Line List from the Line Plan')

	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('CD', 'Color', 'The color {0} has been dropped from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('CSA', 'Color', 'The color {0} has been set as active in the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('CDS', 'Color', 'The color {0} has been dropped in style {1} from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('CAS', 'Color', 'The color {0} has been added to style {1} from the Line Plan')

	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('MD', 'Material', 'The material {0} has been dropped from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('MSA', 'Material', 'The material {0} has been set as active in the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('MAS', 'Material', 'The material {0} has been added to style {1} from the Line Plan')
	INSERT INTO pPlanningActivityType (PlanningActivityKey, PlanningActivityType, PlanningActivityMsg)
	VALUES ('MRpS', 'Material', 'The material {0} has been replaced in style {1} with material {2} from the Line Plan')

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07940', GetDate())
GO
