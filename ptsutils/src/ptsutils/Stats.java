
/**
 * Stats.java Created Aug 31, 2012 by rickcharon.
 *
 */


package ptsutils;

import java.util.Date;
import org.jfree.data.time.RegularTimePeriod;
import org.joda.time.DateTime;



public class Stats {

  
  /**
   * 8/31/12 4:30 PM 
   * @param highs - double array of bar highs
   * @param lows - double array of low bars
   * @return array of doubles that is the range for a bar's high and low
   */
  public static double[] hiloRange( double[] highs, double[] lows ) {
    double[] range = new double[highs.length];
    for(int i = 0; i < highs.length - 1; i++) {
      range[i] = highs[i] - lows[i];
    }
    
    return range;
  }
  
  public static double maxOfRange(double[] range) {
    double max = 0;
    for(int i = 0; i < range.length; i++) {
      if(range[i] > max) {
        max = range[i];
      }
    }
    return max;
  }
    

  /**
   * Test code
   * @param args not used
   */
  public static void main(String args[]) {
    PtsOHLCV ohlcv = new PtsOHLCV();
    PtsSymbolInfos syminfs = new PtsSymbolInfos();
    syminfs.getDistinctSymbolInfos();
    PtsSymbolInfo sym = syminfs.getSymbolInfo("ES");
    DateTime dt = new DateTime();
    Date dd = dt.toDate();
    long dtime = dd.getTime();
    long dttime = dt.getMillis();
   
    PtsDBops.getOHLCandVolumeCompressed(ohlcv, sym, sym.getMinDate().getMillis(), 
            sym.getMaxDate().getMillis(), 60 * 24);
    //ptsutils.Stats stats = new ptsutils.Stats();
    double range[] = Stats.hiloRange(ohlcv.getHighs(0), ohlcv.getLows(0));
    Integer idxMax = null;
    System.out.println(sym.symbol + ", \t" + Stats.maxOfRange(range));
    RegularTimePeriod tp = ohlcv.getPeriods(384).get(0);
    int i = range.length;
    
  }
  

}
