// <2011-08-05 Fri 19:06> ~/.groovy/groovysh.rc is where the goodies are defined
// get a list of defined underlying's
syms();
// <2011-09-17 Sat 15:14> Look for "Saving chart lines" below, code for doing that.
// <2011-09-28 Wed 13:28> General form for closures:
// gchh = {IndicatorSet1.run(factory, "GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
// gcdd = {IndicatorSet1.run(factory, "GC","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//********************************************************
// <2014-05-12 Mon 17:50> load the basics needed. FIXED by Groovy devs. (not yet in gvm)
// :l /home/rickcharon/.groovy/groovysh.rc
//********************************************************

// <2014-04-03 Thu 11:31> ZW, ZC, JPY, AUD, GBP, EUR, CAD, ZB, ZN, CL, ES, GC, ZF, ZS  (count = 14)
// are current symbols available.


// Hourly charts for jumps and paper trades.
// <2014-05-21 Wed 10:43> ZB, ZC, ES no papertrades yet.
// dt is to use a time that I've already scanned up to. 
gchourly = factory.createPtsChart("GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
clhourly = factory.createPtsChart("CL",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);

//<2014-06-20 Fri 17:32> 2weeks up to now.
jpyhourly = factory.createPtsChart("JPY",new DateTime().minusWeeks(2).toString(), new DateTime().toString(), 60);
conn = PtsDBops.setuptradesConnection()



// <2014-06-20 Fri 17:32> 2 weeks starting at date dt.
dt = new DateTime(2011, 2, 15, 0, 0, 0, 0);
clhourly = factory.createPtsChart("CL", dt.toString(), dt.plusWeeks(2).toString(), 60);
clhourly.show();



dt = new DateTime(2012, 1, 1, 0, 0, 0, 0);
gchourly = factory.createPtsChart("GC", dt.toString(), dt.plusWeeks(2).toString(), 60);
gchourly.show();

dt = new DateTime(2012, 4, 10, 0, 0, 0, 0);
jpyhourly = factory.createPtsChart("JPY", dt.toString(), dt.plusWeeks(2).toString(), 60);
jpyhourly.show();

dt = new DateTime(2011, 2, 15, 0, 0, 0, 0);
zshourly = factory.createPtsChart("ZS", dt.toString(), dt.plusWeeks(2).toString(), 60);
zshourly.show();


dt = new DateTime(2010, 1, 17, 0, 0, 0, 0);
cadhourly = factory.createPtsChart("CAD", dt.toString(), dt.plusWeeks(2).toString(), 60);
cadhourly.show();


dt = new DateTime(2009, 6, 16, 0, 0, 0, 0);
zwhourly = factory.createPtsChart("ZW", dt.toString(), dt.plusWeeks(2).toString(), 60);
zwhourly.show();


zwhourly.getJumpBarSize();

zwmindate = syminfs.getSymbolInfo("ZW").getMinDate();
zw2weekdate = zwmindate.plusWeeks(2);
zwhourly = factory.createPtsChart("ZW", zwmindate.toString(), zw2weekdate.toString(), 60);



// <2014-03-28 Fri 10:19> Another few months of no use. Had a hunch about CAD,
cadall = factory.createPtsChart("CAD",
                                syminfs.getSymbolInfo("CAD").getMinDate(),
                                syminfs.getSymbolInfo("CAD").getMaxDate(),
                                60 * 24); 
cadall.show();


// <2012-08-23 Thu 14:02> Haven't used for 5 months, so need to get dates that are in db to do charts

// daily ES chart
esall = factory.createPtsChart("ES",
                                syminfs.getSymbolInfo("ES").getMinDate(),
                                syminfs.getSymbolInfo("ES").getMaxDate(),
                                60 * 24); 
esall.show();

pc = esall.ohlcv
ptsutils.Stats.maxOfRange(pc.getHighs(0));
pc.getItemCount();
st = new ptsutils.Stats();
hh = pc.getHighs(0);
println hh
rr = st.hiloRange(pc.getHighs(0), pc.getLows(0));
ptsutils.Stats.hiloRange(pc.getHighs(0), pc.getLows(0));

gcall = factory.createPtsChart("GC",
                                syminfs.getSymbolInfo("GC").getMinDate(),
                                syminfs.getSymbolInfo("GC").getMaxDate(),
                                60 * 24);
gcall.show();

/*******/
clall = factory.createPtsChart("CL",
                                syminfs.getSymbolInfo("CL").getMinDate(),
                                syminfs.getSymbolInfo("CL").getMaxDate(),
                                60 * 24);
clall.show();

/******* SOY **************/
zsall = factory.createPtsChart("ZS",
                                syminfs.getSymbolInfo("ZS").getMinDate(),
                                syminfs.getSymbolInfo("ZS").getMaxDate(),
                                60 * 24);
zsall.show();

//Charts with no indicators, just price and volume
//Gold
gchourly = factory.createPtsChart("GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
gchourly.show();
gcdaily = factory.createPtsChart("GC","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
gcdaily.show();
//Dollar <2012-03-01 Thu 16:17> no longer available without very expensive fees
// dxhourly = factory.createPtsChart("DX",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
// dxhourly.show();
// dxdaily = factory.createPtsChart("DX","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
// dxdaily.show();
// Currencies

// <2014-05-21 Wed 10:40> Hourly, no indicators.
audhourly = factory.createPtsChart("AUD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
audhourly.show();
cadhourly = factory.createPtsChart("CAD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
cadhourly.show();
eurhourly = factory.createPtsChart("EUR",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
eurhourly.show();
gbpdaily = factory.createPtsChart("GBP","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
gbpdaily.show();


// <2014-05-21 Wed 10:41> Daily, no indicators.
auddaily = factory.createPtsChart("AUD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
auddaily.show();
caddaily = factory.createPtsChart("CAD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
caddaily.show();
eurdaily = factory.createPtsChart("EUR","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
eurdaily.show();




groovy.swing.factory.ActionFactory
syms()

// <2014-05-21 Wed 10:42> Daily and Hourly with indicators.
// australian $
audhh = {IndicatorSet1.run(factory, "AUD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
auddd = {IndicatorSet1.run(factory, "AUD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// canadian $
cadhh = {IndicatorSet1.run(factory, "CAD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
caddd = {IndicatorSet1.run(factory, "CAD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

// Oil
clhh = {IndicatorSet1.run(factory, "CL",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
cldd = {IndicatorSet1.run(factory, "CL","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

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

//Currencies
// Australian dollar
audh = audhh()
audd = auddd()

// Canadian $, loonie
cadh=cadhh()
cadd=caddd()

//oil
clh = clhh()
cld = cldd()

// $ Dollaar $ //
dxh=dxhh()
dxd=dxdd()
dx5=dx5m()

//S&P 500
esh=eshh()
esd=esdd()

// Euro
eurh=eurhh()
eurd=eurdd()

// British Pound
gbph=gbphh()
gbpd=gbpdd()

//Gold
gch = gchh()
gcd = gcdd()

// Yen
jpyh = jpyhh()
jpyd = jpydd()

//30yr
zbh = zbhh()
zbd = zbdd()

//Corn
zch = zchh()
zcd = zcdd()

//5yr notes
zfh = zfhh()
zfd = zfdd()

//10yr notes
znm = znmm()
znh = znhh()
znd = zndd()

//Soy
zsh = zshh()
zsd = zsdd()

//Wheat
zwh = zwhh()
zwd = zwdd()




// Saving chart lines

//  Scratch
tt = PtsDBops.distinctSymbolInfos();

audh = audhh();
vp = audh.getVolumePlot();
vpds = vp.getDataset();
vpds.getSeriesCount(); //Since there is only one series in Volume, returns 1.
vpds.getItemCount(0); // 0 based index for serieses
vpds.getX(0, 433);
vpds.getY(0, 433);  // Just returns 433, what's the use of that?
vpds.getYValue(0, 433);

audh = audhh();
ohlcv = audh.ohlcv; // Returns the instance of PtsOHLCV class which actually contains 
ohlcv.lastItemCount; // Returns the same as vpds.getItemCount(0) above, right now 434. <2011-11-28 Mon 14:36>
// Might be a minor issue below, end is only 59secs later (should be 59 minutes
ohlcv.PriceBars.getPeriod(ohlcv.getLastItemCount() - 1).getStart();
ohlcv.PriceBars.getPeriod(ohlcv.getLastItemCount() - 1).getEnd();
vv = ohlcv.getVolumes(0);
vv[ohlcv.lastItemCount - 1];
cc = ohlcv.getCloses(0);
cc[ohlcv.lastItemCount - 1]; // Should be the last close,
hh = ohlcv.getHighs(0);

// class IndicatorGroup - everything could go here?
ii = audh.getIndicators();
iics = ii.getCloses();
iics[iics.length - 1];
iihs = ii.getHighs();
iihs[iihs.length - 1];
indlist = ii.getIndicators();
indlist.size();

