
// <2014-07-02 Wed 06:40> Test getDistinctSymbolInfos() and Chart Factory creation times.

package dbtests;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.joda.time.DateTime;
import ptscharts.PtsChart;
import ptscharts.PtsChartFactory;
import ptsutils.PtsDBops;
import ptsutils.PtsSymbolInfos;

/**
 *
 * @author rickcharon
 */
public class ChartFactoryTest {

  /**
   * @param args the command line arguments
   */
  public static void main(String[] args) {
      long startTime;
      ArrayList symbols = new ArrayList();
      PtsSymbolInfos syminfs = new PtsSymbolInfos();
      
      startTime = System.nanoTime();
      syminfs.getDistinctSymbolInfos();
      long stopTime = System.nanoTime();
      long elapsedTime = stopTime - startTime;
      System.out.println(elapsedTime);
      double seconds = (double) elapsedTime / 1000000000.0;
      System.out.println(seconds + " secs. for getDistinctSymbolInfos." );
      PtsChartFactory factory;
      startTime = System.nanoTime();
      factory = new PtsChartFactory(syminfs);
      stopTime = System.nanoTime();
      elapsedTime = stopTime - startTime;
      System.out.println(elapsedTime);
      seconds = (double) elapsedTime / 1000000000.0;
      System.out.println(seconds + " secs. for factory creation." );

      DateTime dt1 = new DateTime(2014, 1, 1, 0, 0, 0, 0);
      DateTime dt2 = new DateTime(2014, 6, 27, 0, 0, 0, 0);

      startTime = System.nanoTime();
      PtsChart clhourly = factory.createPtsChart("CL", dt1.toString(), dt2.toString(), 60);
      stopTime = System.nanoTime();
      elapsedTime = stopTime - startTime;
      System.out.println(elapsedTime);
      seconds = (double) elapsedTime / 1000000000.0;
      System.out.println(seconds + " secs. chart creation." );
    } 
  }

