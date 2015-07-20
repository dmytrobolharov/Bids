insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-1-1', 'New Year''s Day')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-2-24', 'Independence Day')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-4-18', 'Good Friday')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-4-20', 'Easter Sunday')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-5-1', 'Spring Day (May Day)')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-6-8', 'Whit Sunday')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-6-23', 'Victory Day')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-6-24', 'St. John''s Day (Midsummer Day)')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-8-20', 'Day of Restoration of Independence')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-12-24', 'Christmas Eve')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-12-25', 'Christmas Day')
insert into pTACalHoliday(TACalHolidayDate, TACalHolidayName) values('2014-12-26', 'Boxing Day')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07999', GetDate())
GO
