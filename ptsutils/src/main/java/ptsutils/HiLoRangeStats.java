
/**
 * HiLoRangeStats.java Created Sep 1, 2012 by rickcharon.
 *
 */


package ptsutils;

import java.util.Date;
import org.jfree.data.time.RegularTimePeriod;
import org.joda.time.DateTime;



public class HiLoRangeStats {
  public double[] range = null;
  public double max;
  public int maxIdx;
  public double min;
  public double minIdx;
  public double mean;
  PtsOHLCV ohlcv = null;
  
  private void hiloRange( double[] highs, double[] lows ) {
    range = new double[highs.length];
    for(int i = 0; i < highs.length - 1; i++) {
      range[i] = highs[i] - lows[i];
    }
  }
  
  public void printRange() {
    for(int i = 0; i < range.length - 1; i++) {
      System.out.println(i + ", " + ohlcv.getPeriods(0).get(i) + ", " + range[i] );
    }
  }
  
  HiLoRangeStats(PtsOHLCV ohlcv_in) {
    ohlcv = ohlcv_in;
    hiloRange(ohlcv.getHighs(0), ohlcv.getLows(0));
    printRange();
  }
  
  
  public static void main(String args[]) {
    PtsOHLCV ohlcv = new PtsOHLCV();
    PtsSymbolInfos syminfs = new PtsSymbolInfos();
    syminfs.getDistinctSymbolInfos();
    PtsSymbolInfo sym = syminfs.getSymbolInfo("ZB");
    DateTime dt = new DateTime();
    Date dd = dt.toDate();
    long dtime = dd.getTime();
    long dttime = dt.getMillis();
   
    PtsDBops.getOHLCandVolumeCompressed(ohlcv, sym, sym.getMinDate().getMillis(), 
            sym.getMaxDate().getMillis(), 60 * 24);
    //ptsutils.Stats stats = new ptsutils.Stats();
    HiLoRangeStats hrs = new HiLoRangeStats(ohlcv);    
  }
  
}
