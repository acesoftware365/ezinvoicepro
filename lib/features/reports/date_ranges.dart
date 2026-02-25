DateTime monthStart(DateTime d) => DateTime(d.year, d.month, 1);
DateTime monthEndExclusive(DateTime d) => DateTime(d.year, d.month + 1, 1);

DateTime yearStart(DateTime d) => DateTime(d.year, 1, 1);
DateTime yearEndExclusive(DateTime d) => DateTime(d.year + 1, 1, 1);
