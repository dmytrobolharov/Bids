

Insert into psampleworkflow values('90A',	'Proto Meas Sample',	'40000000-0000-0000-0000-000000000050',	'E'	,'ProtoType',	'21',	'Yes',	NULL,	NULL	,NULL,	NULL	,'015',	0)

Insert into psampleworkflow values('91A',	'PP Meas Sample',	'40000000-0000-0000-0000-000000000050',	'E'	,'Pre Prod',	'21',	'Yes',	NULL,	NULL	,NULL,	NULL	,'015',	0)

Insert into psampleworkflow values('92A',	'Ship Meas Sample',	'40000000-0000-0000-0000-000000000050',	'E'	,'Sales',	'21',	'Yes',	NULL,	NULL	,NULL,	NULL	,'015',	0)

Insert into psampleworkflow values('93A',	'Top Meas Sample',	'40000000-0000-0000-0000-000000000050',	'E'	,'Top of Prod',	'21',	'Yes',	NULL,	NULL	,NULL,	NULL	,'015',	0)

Insert into psampleworkflow values('94A',	'Fit Meas Sample',	'40000000-0000-0000-0000-000000000050',	'E'	,'Fit',	'21',	'Yes',	NULL,	NULL	,NULL,	NULL	,'015',	0)

Go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '868', GetDate())
GO
