// <2011-08-05 Fri 19:06> ~/.groovy/groovysh.rc is where the goodies are defined
// get a list of defined underlying's
syms();
// <2011-09-17 Sat 15:14> Look for "Saving chart lines" below, code for doing that.
// <2011-09-28 Wed 13:28> General form for closures:
// gchh = {IndicatorSet1.run(factory, "GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);}
// gcdd = {IndicatorSet1.run(factory, "GC","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);}

//********************************************************
//Purge everything loaded so far
\p all
// reload the basics needed
\l /home/rickcharon/.groovy/groovysh.rc
//********************************************************

//<2014-04-03 Thu 11:31> ZW, ZC, JPY, AUD, GBP, EUR, CAD, ZB, ZN, CL, ES, GC, ZF, ZS  are current symbols available.
// Hourly charts for jumps and paper trades.
// dt is to use a time that I've already scanned up to. 
gchourly = factory.createPtsChart("GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);

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

audhourly = factory.createPtsChart("AUD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
audhourly.show();
auddaily = factory.createPtsChart("AUD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
auddaily.show();

cadhourly = factory.createPtsChart("CAD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
cadhourly.show();
caddaily = factory.createPtsChart("CAD","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
caddaily.show();

eurhourly = factory.createPtsChart("EUR",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
eurhourly.show();
eurdaily = factory.createPtsChart("EUR","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
eurdaily.show();


gbpdaily = factory.createPtsChart("GBP","2009-03-11T00:00", new DateTime().plusDays(1).toString(), 60 * 24);
gbpdaily.show();




groovy.swing.factory.ActionFactory

syms()

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

