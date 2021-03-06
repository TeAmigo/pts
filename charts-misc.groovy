// -*- mode: groovy -*-
// import ptsutils.PtsDBops;
// import ptsutils.PtsSymbolInfos;
// import ptscharts.indicators.*;
// import ptscharts.PtsChartFactory;
// import org.joda.time.DateTime;

// syminfs = new PtsSymbolInfos();
// syminfs.getDistinctSymbolInfos();
// factory = new PtsChartFactory(syminfs);
// syms = {syminfs.getSymInfos().each{println it}}

enum TimeFactor{
  DAY,
  MINUTE } //<2014-05-11 Sun 12:41> Put a newline between MINUTE and } and Groovysh2.3 barfs.


// australian $
audhh = {IndicatorSet1.run(factory, "AUD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
auddd = {IndicatorSet1.run(factory, "AUD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// canadian $
cadhh = {IndicatorSet1.run(factory, "CAD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
caddd = {IndicatorSet1.run(factory, "CAD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// Oil
clhh = {IndicatorSet1.run(factory, "CL",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
cldd = {IndicatorSet1.run(factory, "CL","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// Dollar
dxhh = {IndicatorSet1.run(factory, "DX",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
dx5m = {IndicatorSet1.run(factory, "DX",new DateTime().minusDays(3).toString(), new DateTime().toString(), 5);}
dxdd = {IndicatorSet1.run(factory, "DX","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// SP500
eshh = {IndicatorSet1.run(factory, "ES",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
esdd = {IndicatorSet1.run(factory, "ES","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// Euro
eurhh = {IndicatorSet1.run(factory, "EUR",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
eurdd = {IndicatorSet1.run(factory, "EUR","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// British pound
gbphh = {IndicatorSet1.run(factory, "GBP",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
gbpdd = {IndicatorSet1.run(factory, "GBP","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// Gold
gchh = {IndicatorSet1.run(factory, "GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
gcdd = {IndicatorSet1.run(factory, "GC","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// Yen
jpyhh = {IndicatorSet1.run(factory, "JPY",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
jpydd = {IndicatorSet1.run(factory, "JPY","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//30yr
zbhh = {IndicatorSet1.run(factory, "ZB",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
zbdd = {IndicatorSet1.run(factory, "ZB","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//Corn
zchh = {IndicatorSet1.run(factory, "ZC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
zcdd = {IndicatorSet1.run(factory, "ZC","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//5yr
zfhh = {IndicatorSet1.run(factory, "ZF",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
zfdd = {IndicatorSet1.run(factory, "ZF","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//10yr
znmm = {IndicatorSet1.run(factory, "DX",new DateTime().minusDays(2).toString(), new DateTime().toString(), 1);}
znhh = {IndicatorSet1.run(factory, "ZN",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
zndd = {IndicatorSet1.run(factory, "ZN","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//Soy
zshh = {IndicatorSet1.run(factory, "ZS",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
zsdd = {IndicatorSet1.run(factory, "ZS","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//Wheat
zwhh = {IndicatorSet1.run(factory, "ZW",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
zwdd = {IndicatorSet1.run(factory, "ZW","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}


