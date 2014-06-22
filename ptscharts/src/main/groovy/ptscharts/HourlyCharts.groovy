// <2014-05-21 Wed 11:04> This class has been created to pump out hourly charts for the past month of all current symbols in db.

/**
 *
 * @author rickcharon
 */

package ptscharts;

//
import ptsutils.PtsDBops;
import ptsutils.PtsSymbolInfos;
import ptscharts.indicators.*;
import ptscharts.PtsChartFactory;
import org.joda.time.DateTime;

class HourlyCharts {

  def syminfs = new PtsSymbolInfos();
  def factory = new PtsChartFactory(syminfs);
  
  //ZW, ZC, JPY, AUD, GBP, EUR, CAD, ZB, ZN, CL, ES, GC, ZF, ZS
  def hourlies = [:];
  // def syms = {
  //   syminfs.getSymInfos().each {
  //     hourlies[it] = hc.factory.createPtsChart(it ,new DateTime().minusMonths(1).toString(),
  //                                             new DateTime().toString(), 60)
  //   }
  // }
  // def audhourly;
  // def cadhourly;
  // def clhourly;
  // def eshourly;
  // def eurhourly;
  // def gbphourly;
  // def gchourly;
  // def jpyhourly;
  // def zbhourly;
  // def zchourly;
  // def zfhourly;
  // def znhourly;
  // def zshourly;
  // def zwhourly;

  
  def setup() {
    syminfs.getDistinctSymbolInfos();
  }
  
	static void main(String[] args) {
    def weeksBack = Integer.parseInt(args[0])
    def weeksShown = weeksBack - Integer.parseInt(args[1])
    HourlyCharts hc  = new HourlyCharts()
    hc.setup()
    hc.syminfs.getSymInfos().each {
      hc.hourlies[it.key] = hc.factory.createPtsChart(it.key, new DateTime().minusWeeks(weeksBack).toString(),
                                                      new DateTime().minusWeeks(weeksShown).toString(), 60)
    }
    hc.hourlies.each { it.value.show() } 
    // hc.hourlies.each { println it.key; println it.value } //hc.hourlies[it]. }
    // hc.syminfs.getSymbols().each{println it}
    // hc.audhourly = hc.factory.createPtsChart("AUD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.audhourly.show();
    // hc.cadhourly = hc.factory.createPtsChart("CAD",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.cadhourly.show();
    // hc.clhourly = hc.factory.createPtsChart("CL",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.clhourly.show();
    // hc.eshourly = hc.factory.createPtsChart("ES",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.eshourly.show();
    // hc.eurhourly = hc.factory.createPtsChart("EUR",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.eurhourly.show();
    // hc.gbphourly = hc.factory.createPtsChart("GBP",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.gbphourly.show();
    // hc.gchourly = hc.factory.createPtsChart("GC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.gchourly.show();
    // hc.jpyhourly = hc.factory.createPtsChart("JPY",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.jpyhourly.show();
    // hc.zbhourly = hc.factory.createPtsChart("ZB",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.zbhourly.show();
    // hc.zchourly = hc.factory.createPtsChart("ZC",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.zchourly.show();
    // hc.zfhourly = hc.factory.createPtsChart("ZF",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.zfhourly.show();
    // hc.znhourly = hc.factory.createPtsChart("ZN",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.znhourly.show();
    // hc.zshourly = hc.factory.createPtsChart("ZS",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.zshourly.show();
    // hc.zwhourly = hc.factory.createPtsChart("ZW",new DateTime().minusMonths(1).toString(), new DateTime().toString(), 60);
    // hc.zwhourly.show();


    // PtsDBops.distinctSymolsList().each { println it }
    // PtsDBops.distinctSymolsList().each { factory.createPtsChart(it, new DateTime().minusMonths(1).toString(),
    //                                                            new DateTime().toString(), 60).show() }
  }
}